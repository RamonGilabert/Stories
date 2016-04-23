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

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -EngineView.Dimensions.Menu.rightOffset)
      ])
  }
}

extension MenuView: UITableViewDelegate {

}

extension MenuView: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
