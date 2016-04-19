import UIKit

class WelcomeView: UIView {

  struct Dimensions {
    static let moon: CGFloat = 180
    static let topOffset: CGFloat = 95
    static let smallStar: CGFloat = 1
    static let mediumStar: CGFloat = 2
    static let bigStar: CGFloat = 3

    struct Shadow {
      static let moon: CGFloat = 30
      static let star: CGFloat = 15
    }
  }

  static let starNumber = 15

  lazy var moon: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var stars: [UIView] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
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

  func prepareStars() {
    let sizes = [Dimensions.smallStar, Dimensions.mediumStar, Dimensions.bigStar]
    let screenSize = UIScreen.mainScreen().bounds

    for _ in 0..<WelcomeView.starNumber {
      let star = UIView()
      let index = Int(arc4random_uniform(UInt32(sizes.count)))
      let size = sizes[index]

      star.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(screenSize.width))),
                          y: CGFloat(arc4random_uniform(UInt32(screenSize.height / 2))),
                          width: size, height: size)
      star.shadow(Color.Welcome.starShadow, radius: 15)

      stars.append(star)
      addSubview(star)
    }
  }
}
