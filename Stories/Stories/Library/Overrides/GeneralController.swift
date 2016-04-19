import UIKit

class GeneralController: UIViewController {

  lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [Color.Background.top.CGColor, Color.Background.bottom.CGColor]

    return layer
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.layer.cornerRadius = 7
    view.clipsToBounds = true
    view.layer.addSublayer(gradientLayer)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    gradientLayer.frame = view.bounds
  }
}
