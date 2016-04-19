import UIKit

class LoadingView: UIView {

  struct Dimensions {
    static let moon: CGFloat = 200
    static let topOffset: CGFloat = 95

    struct Shadow {
      static let moon: CGFloat = 30
    }
  }

  lazy var moon: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = Dimensions.moon / 2
    view.backgroundColor = Color.Welcome.moon
    view.shadow(Color.Welcome.moonShadow, radius: 30)

    return view
  }()

  lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [Color.Background.top.CGColor, Color.Background.bottom.CGColor]

    return layer
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(moon)
    layer.addSublayer(gradientLayer)

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      moon.widthAnchor.constraintEqualToConstant(Dimensions.moon),
      moon.heightAnchor.constraintEqualToConstant(Dimensions.moon),
      moon.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      moon.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
      ])
  }
}
