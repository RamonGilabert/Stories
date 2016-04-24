import UIKit
import Walker
import Ripple

protocol FinaleControllerDelegate {

  func finaleResetButtonDidPress()
}

class FinaleController: GeneralController {

  lazy var finaleView: FinaleView = { [unowned self] in
    let view = FinaleView()
    view.delegate = self
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()

  var delegate: FinaleControllerDelegate?

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
    [finaleView.landscape.moon, finaleView.titleLabel, finaleView.button].forEach {
      $0.transform = CGAffineTransformMakeTranslation(0, -500)
    }
  }

  func animate() {
    animateController(true)
  }

  // MARK: - Helper methods

  func animateController(appear: Bool) {
    let transform = appear ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, -750)

    calm()
    closeDistilleries()

    UIView.animateWithDuration(appear ? 0.3 : 1, animations: {
      self.view.alpha = appear ? 1 : 0
    })

    spring(finaleView.landscape.moon, delay: appear ? 0.4 : 0, spring: 50, friction: 60, mass: 50, animations: {
      $0.transform = transform
    }).finally({
      guard appear else { self.delegate?.finaleResetButtonDidPress(); return }
      self.finaleView.landscape.stone()
    })

    spring(finaleView.titleLabel, delay: 0.2, spring: 50, friction: 60, mass: 50) {
      $0.transform = transform
    }

    spring(finaleView.button, delay: appear ? 0 : 0.4, spring: 50, friction: 60, mass: 50) {
      $0.transform = transform
    }
  }
}

extension FinaleController: FinaleViewDelegate {

  func resetButtonDidPress() {
    animateController(false)
  }
}
