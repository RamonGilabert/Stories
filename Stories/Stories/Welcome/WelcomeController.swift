import UIKit
import Sugar

class WelcomeController: GeneralController {

  lazy var welcomeView: WelcomeView = {
    let view = WelcomeView()
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(welcomeView)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    welcomeView.prepareAnimation()
  }

  // MARK: - Animations

  func animate() {
    welcomeView.animate(completion: {
      self.welcomeView.writeView.startAnimation()

      delay(5) { self.welcomeView.connect() }
    })
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
