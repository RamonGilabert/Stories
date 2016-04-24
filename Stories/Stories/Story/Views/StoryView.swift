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

  struct Constants {
    static let maximum: CGFloat = 150
    static let size: CGFloat = 130
    static let rotation: CGFloat = CGFloat(M_PI_2)
    static let fontSize: CGFloat = 2
    static let origin: CGFloat = 35
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
  var headerHeight: CGFloat = Dimensions.Table.offset
  var headerConstraint = NSLayoutConstraint()

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
    headerView.titleLabel.font = Font.Story.title
    headerView.separator.transform = CGAffineTransformIdentity
    headerView.titleLabel.text = viewModel.title
  }

  // MARK: - Constraints

  func setupConstraints() {
    headerConstraint = headerView.heightAnchor.constraintEqualToConstant(headerHeight)

    NSLayoutConstraint.activateConstraints([
      tableView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      tableView.topAnchor.constraintEqualToAnchor(headerView.bottomAnchor),
      tableView.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
      tableView.rightAnchor.constraintEqualToAnchor(rightAnchor),

      headerView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      headerConstraint,
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
    let offset = scrollView.contentOffset.y
    let maximum = Constants.maximum
    let rotation = Constants.rotation * offset / maximum > Constants.rotation
      ? Constants.rotation : Constants.rotation * offset / maximum
    let font = Constants.fontSize * offset / maximum > Constants.fontSize
      ? Constants.fontSize : Constants.fontSize * offset / maximum
    let initialFont = Font.Story.title.pointSize
    let size = Constants.size * offset / maximum > Constants.size
      ? Constants.size : Constants.size * offset / maximum
    let height = Dimensions.Table.offset - size
    let title = 35 * offset / maximum > 35 ? 35 : 35 * offset / maximum
    let titleOffset = 65 - title
    let separator = 45 * offset / maximum > 45 ? 45 : 45 * offset / maximum
    let separatorOffset = 40 - separator
    let opacity = 1 * offset / maximum > 1 ? 1 : 1 * offset / maximum

    headerView.separator.transform = CGAffineTransformMakeRotation(rotation < 0 ? 0 : rotation)
    headerView.titleLabel.font = Font.Story.title.fontWithSize(initialFont - font)
    headerConstraint.constant = height > Dimensions.Table.offset ? Dimensions.Table.offset : height
    headerView.titleConstraint.constant = titleOffset > 65 ? 65 : titleOffset
    headerView.separatorConstraint.constant = separatorOffset > 40 ? -40 : -separatorOffset
    headerView.layer.shadowOpacity = Float(opacity)

    setNeedsLayout()
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
