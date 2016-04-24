import UIKit

class FinaleController: GeneralController {

  lazy var finaleView: FinaleView = {
    let view = FinaleView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
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

extension FinaleController: Animatable {

  func prepareAnimate() {
    view.alpha = 0
  }

  func animate() {
    UIView.animateWithDuration(0.3, animations: {
      self.view.alpha = 1
    })
  }
}
