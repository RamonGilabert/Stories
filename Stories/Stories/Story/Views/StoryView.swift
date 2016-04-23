import UIKit

protocol StoryViewDelegate {

  func menuButtonDidPress()
}

class StoryView: UIView {

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.layer.borderColor = Color.Engine.Button.general.CGColor
    button.layer.borderWidth = EngineView.Dimensions.Menu.border
    button.layer.cornerRadius = EngineView.Dimensions.Menu.size / 2
    button.backgroundColor = Color.Engine.Button.background
    button.translatesAutoresizingMaskIntoConstraints = false
    button.shadow(Color.Engine.Button.shadow, radius: 10)
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  lazy var tableView: UITableView = UITableView()

  var delegate: StoryViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.registerClass(
      StoryCell.self, forCellReuseIdentifier: StoryCell.reusableIdentifier)
  }

  // MARK: - Action

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      tableView.widthAnchor.constraintEqualToAnchor(widthAnchor),
      tableView.heightAnchor.constraintEqualToAnchor(heightAnchor),
      tableView.topAnchor.constraintEqualToAnchor(topAnchor),
      tableView.rightAnchor.constraintEqualToAnchor(rightAnchor)
      ])
  }
}

extension StoryView: UITableViewDelegate {

}

extension StoryView: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
