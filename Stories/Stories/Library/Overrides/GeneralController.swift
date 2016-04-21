import UIKit
import Ripple

class GeneralController: UIViewController {

  lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [Color.Background.top.CGColor, Color.Background.bottom.CGColor]

    return layer
  }()

  lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: #selector(handleTapGesture))

    return gesture
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.layer.cornerRadius = 7
    view.clipsToBounds = true
    view.layer.insertSublayer(gradientLayer, atIndex: 0)
    view.addGestureRecognizer(tapGesture)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    gradientLayer.frame = view.bounds
  }

  // MARK: - Action methods

  func handleTapGesture() {
    let location = tapGesture.locationInView(view)

    droplet(location,
            view: view,
            size: 25,
            duration: 1, multiplier: 2.5,
            color: Color.General.ripple)
  }
}
