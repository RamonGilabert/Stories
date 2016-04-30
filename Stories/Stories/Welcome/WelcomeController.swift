import UIKit
import Sugar

protocol WelcomeControllerDelegate {

  func presentEngineController()
}

class WelcomeController: GeneralController {

  lazy var welcomeView: WelcomeView = { [unowned self] in
    let view = WelcomeView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self

    return view
  }()

  var delegate: WelcomeControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    menu.alpha = 0
    view.insertSubview(welcomeView, belowSubview: menu)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    welcomeView.prepareAnimation()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      welcomeView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      welcomeView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      welcomeView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      welcomeView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
      ])
  }
}

extension WelcomeController: Animatable {

  func prepareAnimate() {
    view.alpha = 0
  }

  func animate() {
    UIView.animateWithDuration(0.5, animations: {
      self.view.alpha = 1
    })

    welcomeView.animate(completion: {
      self.welcomeView.writeView.startAnimation()

      delay(4.5) { self.welcomeView.connect() }
    })
  }
}

extension WelcomeController: WelcomeViewDelegate {

  func dismissController() {
    delegate?.presentEngineController()
  }
}
