import UIKit

protocol MenuViewDelegate {

  func buttonDidPress(title: String)
}

class MenuView: UIView {

  struct Dimensions {
    struct Table {
      static let topOffset: CGFloat = 145
      static let leftOffset: CGFloat = 30
      static let rightOffset: CGFloat = 16
    }
  }

  lazy var blurView: UIVisualEffectView = {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  lazy var tableView: UITableView = UITableView()

  var delegate: MenuViewDelegate?
  var kind: MenuViewModel.Kind = .Default

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(blurView)
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      blurView.addSubview($0)
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
    tableView.backgroundColor = Color.General.clear
    tableView.separatorStyle = .None
    tableView.contentInset.top = Dimensions.Table.topOffset

    tableView.registerClass(
      MenuCell.self, forCellReuseIdentifier: MenuCell.reusableIdentifier)
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      blurView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      blurView.heightAnchor.constraintEqualToAnchor(heightAnchor),
      blurView.topAnchor.constraintEqualToAnchor(topAnchor),
      blurView.rightAnchor.constraintEqualToAnchor(rightAnchor),

      tableView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      tableView.topAnchor.constraintEqualToAnchor(topAnchor),
      tableView.bottomAnchor.constraintEqualToAnchor(bottomAnchor)
      ])
  }
}

extension MenuView: UITableViewDelegate {

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    cell.transform = CGAffineTransformMakeTranslation(-1000, 0)

    UIView.animateWithDuration(
      0.7, delay: Double(indexPath.row) * 0.115, usingSpringWithDamping: 0.79,
      initialSpringVelocity: 1, options: [], animations: {
      cell.transform = CGAffineTransformIdentity
      }, completion: nil)
  }
}

extension MenuView: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuViewModel.cells(kind).count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(MenuCell.reusableIdentifier) as? MenuCell
      else { return UITableViewCell() }

    cell.configureCell(MenuViewModel.cells(kind)[indexPath.row])
    cell.delegate = self

    return cell
  }
}

extension MenuView: MenuCellDelegate {

  func buttonDidPress(title: String) {
    delegate?.buttonDidPress(title)
  }
}
