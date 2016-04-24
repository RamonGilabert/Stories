import UIKit

protocol StoryViewDelegate {

  func menuButtonDidPress()
}

class StoryView: UIView {

  enum Kind {
    case Story, Motivation
  }

  struct Dimensions {
    struct Table {
      static let offset: CGFloat = 230
      static let bottomOffset: CGFloat = 50
    }
  }

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.layer.borderColor = Color.Engine.Button.general.CGColor
    button.layer.borderWidth = EngineView.Dimensions.Menu.border
    button.layer.cornerRadius = EngineView.Dimensions.Menu.size / 2
    button.backgroundColor = Color.Engine.Button.background
    button.shadow(Color.Engine.Button.shadow, radius: 10)
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  lazy var headerView: StoryHeaderView = StoryHeaderView(title: "This is my story".uppercaseString)

  lazy var tableView: UITableView = UITableView()

  var kind: Kind = .Story {
    didSet {
      viewModel = kind == .Story ? StoryViewModel.story : StoryViewModel.motivation
      tableView.reloadData()
      reloadHeader()
    }
  }

  var viewModel = StoryViewModel.story
  var delegate: StoryViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)

    [tableView, headerView, menu].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    setupTableView()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .None
    tableView.scrollsToTop = true
    tableView.contentInset.bottom = Dimensions.Table.bottomOffset
    tableView.backgroundColor = Color.General.clear
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = Dimensions.Table.offset

    tableView.registerClass(
      StoryCell.self, forCellReuseIdentifier: StoryCell.reusableIdentifier)
    tableView.registerClass(
      StoryImageCell.self, forCellReuseIdentifier: StoryImageCell.reusableIdentifier)
  }

  // MARK: - Action

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }

  // MARK: - Helper methods

  func reloadHeader() {
    headerView.titleLabel.text = viewModel.title
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      tableView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      tableView.topAnchor.constraintEqualToAnchor(headerView.bottomAnchor),
      tableView.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
      tableView.rightAnchor.constraintEqualToAnchor(rightAnchor),

      headerView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      headerView.heightAnchor.constraintEqualToConstant(Dimensions.Table.offset),
      headerView.topAnchor.constraintEqualToAnchor(topAnchor),
      headerView.rightAnchor.constraintEqualToAnchor(rightAnchor),

      menu.widthAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(topAnchor, constant: EngineView.Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -EngineView.Dimensions.Menu.rightOffset)
      ])
  }
}

extension StoryView: UITableViewDelegate {

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    // TODO: Perform the animation to show the story.
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    // TODO: Do the animation of the separator.
  }
}

extension StoryView: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cells.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let kind = viewModel.cells[indexPath.row].kind else { return UITableViewCell() }

    switch(kind) {
    case .Text:
      guard let cell = tableView.dequeueReusableCellWithIdentifier(StoryCell.reusableIdentifier) as? StoryCell else { return UITableViewCell() }

      cell.configureCell(viewModel.cells[indexPath.row])

      return cell
    case .Image:
      guard let cell = tableView.dequeueReusableCellWithIdentifier(StoryImageCell.reusableIdentifier) as? StoryImageCell else { return UITableViewCell() }

      cell.configureCell(viewModel.cells[indexPath.row])

      return cell
    }
  }
}
