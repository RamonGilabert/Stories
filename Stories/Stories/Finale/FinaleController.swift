import UIKit
import Walker
import Ripple

protocol FinaleControllerDelegate {

  func finaleResetButtonDidPress()
  func finaleMenuButtonDidPress()
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

    view.insertSubview(finaleView, belowSubview: menu)

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
    view.alpha = 1
    [finaleView.landscape.moon, finaleView.titleLabel, finaleView.button, menu].forEach {
      $0.transform = CGAffineTransformMakeTranslation(0, -750)
    }
  }

  func animate() {
    animateController(true)
  }

  // MARK: - Helper methods

  func animateController(appear: Bool) {
    let transform = appear ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, -750)

    calm()

    spring(finaleView.landscape.moon, delay: appear ? 0.4 : 0, spring: 50, friction: 60, mass: 50, animations: {
      $0.transform = transform
    }).finally({
      guard appear else { self.delegate?.finaleResetButtonDidPress(); return }
      self.finaleView.landscape.stone()
    })

    spring(finaleView.titleLabel, menu, delay: 0.2, spring: 50, friction: 60, mass: 50) {
      $0.transform = transform
      $1.transform = transform
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

  override func menuButtonDidPress() {
    delegate?.finaleMenuButtonDidPress()
  }
}
