import UIKit
import Ripple

class LandscapeView: UIView {

  struct Dimensions {
    static let moon: CGFloat = 200
    static let moonStroke: CGFloat = 3
    static let topOffset: CGFloat = 95
    static let smallStar: CGFloat = 1
    static let mediumStar: CGFloat = 2
    static let bigStar: CGFloat = 3

    struct Shadow {
      static let moon: CGFloat = 30
      static let star: CGFloat = 15
    }
  }

  struct Constants {
    static let starNumber = 50
  }

  lazy var moon: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = Dimensions.moon / 2
    view.layer.borderColor = Color.Welcome.moon.CGColor
    view.layer.borderWidth = Dimensions.moon / 2
    view.shadow(Color.Welcome.moonShadow, radius: Dimensions.Shadow.moon)

    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = Color.General.clear
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(moon)
    setupConstraints()
    prepareStars([Dimensions.smallStar, Dimensions.mediumStar, Dimensions.bigStar], Constants.starNumber, 1.75)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      moon.widthAnchor.constraintEqualToConstant(Dimensions.moon),
      moon.heightAnchor.constraintEqualToConstant(Dimensions.moon),
      moon.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      moon.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.topOffset)
      ])
  }

  // MARK: - Helper methods

  func stone(duration: NSTimeInterval = 4, multiplier: CGFloat = 1.65, divider: CGFloat = 1.5) {
    ripple(moon.center,
           view: self,
           size: Dimensions.moon,
           duration: duration, multiplier: multiplier, divider: divider,
           color: Color.General.ripple)
  }
}
