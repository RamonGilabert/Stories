import UIKit

class FinaleController: UIViewController {

  lazy var finaleView: FinaleView = {
    let view = FinaleView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(finaleView)

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      finaleView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      finaleView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      finaleView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      finaleView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
      ])
  }
}
