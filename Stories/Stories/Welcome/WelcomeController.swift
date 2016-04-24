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

    view.addSubview(welcomeView)

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

  func prepareAnimate() { }

  func animate() {
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
