import UIKit
import Transition

protocol EngineControllerDelegate {

  func enginePresentMenu()
}

class EngineController: GeneralController {

  lazy var transition: Transition = {
    let transition = Transition() { controller, show in
      guard let controller = controller as? EngineController else { return }
      controller.view.alpha = show ? 1 : 0
    }

    transition.spring = (0.6, 0.4)
    transition.animationDuration = 1

    return transition
  }()

  lazy var engineView: EngineView = { [unowned self] in
    let view = EngineView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self

    return view
  }()

  var delegate: EngineControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(engineView)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      engineView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      engineView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      engineView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      engineView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
      ])
  }
}

extension EngineController: Animatable {

  func animate() {
    UIView.animateWithDuration(0.5, animations: {
      self.view.alpha = 1
    })
  }
}

extension EngineController: EngineViewDelegate {

  func menuButtonDidPress() {
    delegate?.enginePresentMenu()
  }
}
