import UIKit

protocol MenuCellDelegate {

  func buttonDidPress(title: String)
}

class MenuCell: UITableViewCell {

  static let reusableIdentifier = "MenuCellIdentifier"

  lazy var button: UIButton = { [unowned self] in
    let button = UIButton()
    button.addTarget(
      self, action: #selector(buttonDidPress), forControlEvents: .TouchUpInside)
    button.shadow(Color.Menu.shadow, radius: 2)
    button.setTitleColor(Color.Menu.general, forState: .Normal)
    button.titleLabel?.font = Font.Menu.title

    return button
  }()

  var delegate: MenuCellDelegate?

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(viewModel: MenuViewModel) {

  }

  // MARK: - Action methods

  func buttonDidPress() {
    guard let title = button.titleForState(.Normal) else { return }
    delegate?.buttonDidPress(title)
  }
}