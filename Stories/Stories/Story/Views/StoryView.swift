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
    static let separator: CGFloat = 45
    static let opacity: CGFloat = 1
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
  var shouldAnimate = true

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

  func scrollValue(constant: CGFloat) -> CGFloat {
    let offset = tableView.contentOffset.y
    let maximum = Constants.maximum

    return constant * offset / maximum > constant ? constant : constant * offset / maximum
  }

  func updateLayout() {
    let separator = StoryHeaderView.Dimensions.Separator.bottomOffset
    let height = Dimensions.Table.offset - scrollValue(Constants.size)
    let separatorOffset = separator - scrollValue(Constants.separator)

    headerView.separator.transform = CGAffineTransformMakeRotation(scrollValue(Constants.rotation))
    headerView.titleLabel.font = Font.Story.title.fontWithSize(Font.Story.title.pointSize - scrollValue(Constants.fontSize))
    headerConstraint.constant = height > Dimensions.Table.offset ? Dimensions.Table.offset : height
    headerView.titleConstraint.constant = StoryHeaderView.Dimensions.Title.offset - scrollValue(Constants.origin)
    headerView.separatorConstraint.constant = separatorOffset > separator ? -separator : -separatorOffset
    headerView.layer.shadowOpacity = Float(scrollValue(Constants.opacity))

    setNeedsLayout()
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
    guard indexPath.row == 0 && shouldAnimate else { return }

    cell.alpha = 0
    cell.transform = CGAffineTransformMakeTranslation(0, 100)
    
    shouldAnimate = false

    UIView.animateWithDuration(0.8, animations: {
      cell.alpha = 1
      cell.transform = CGAffineTransformIdentity
    })
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    updateLayout()
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
