import UIKit

class MenuView: UIView {

  struct Dimensions {
    struct Table {
      static let leftOffset: CGFloat = 30
      static let rightOffset: CGFloat = 16
    }
  }

  lazy var blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.backgroundColor = Color.Engine.Button.general
    button.shadow(Color.Engine.Button.shadow, radius: 10)
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
    }()

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [blurView, menu, tableView].forEach {
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
    tableView.registerClass(
      MenuCell.self, forCellReuseIdentifier: MenuCell.reusableIdentifier)
  }

  // MARK: - Actions

  func menuButtonDidPress() {
    
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      blurView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      blurView.heightAnchor.constraintEqualToAnchor(heightAnchor),
      blurView.topAnchor.constraintEqualToAnchor(topAnchor),
      blurView.rightAnchor.constraintEqualToAnchor(rightAnchor),

      menu.widthAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(topAnchor, constant: EngineView.Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -EngineView.Dimensions.Menu.rightOffset),

      tableView.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      tableView.centerYAnchor.constraintEqualToAnchor(centerYAnchor),
      tableView.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Table.leftOffset),
      tableView.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -Dimensions.Table.rightOffset)
      ])
  }
}

extension MenuView: UITableViewDelegate {

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    // TODO: Do the animation for the first time.
  }
}

extension MenuView: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuViewModel.cells.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(MenuCell.reusableIdentifier) as? MenuCell
      else { return UITableViewCell() }

    cell.configureCell(MenuViewModel.cells[indexPath.row])
    cell.delegate = self

    return cell
  }
}

extension MenuView: MenuCellDelegate {

  func buttonDidPress(title: String) {
    // TODO: Handle the button press.
  }
}
