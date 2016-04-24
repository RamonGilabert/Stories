import UIKit

class FinaleView: UIView {

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  lazy var button: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(restartButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [titleLabel, button].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func restartButtonDidPress() {
    // TODO: Handle the delegate.
  }

  // MARK: - Constraints

  func setupConstraints() {

  }
}
