import UIKit
import Walker
import Ripple
import Sugar

class WelcomeView: UIView {

  struct Dimensions {
    static let moon: CGFloat = 200
    static let moonStroke: CGFloat = 3
    static let topOffset: CGFloat = 95
    static let smallStar: CGFloat = 1
    static let mediumStar: CGFloat = 2
    static let bigStar: CGFloat = 3
    static let welcomeOffset: CGFloat = UIScreen.mainScreen().bounds.height / 1.375
    static let writeOffset: CGFloat = 90

    struct Shadow {
      static let moon: CGFloat = 30
      static let star: CGFloat = 15
    }
  }

  static let starNumber = 50

  lazy var moon: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = Dimensions.moon / 2
    view.layer.borderColor = Color.Welcome.moon.CGColor
    view.layer.borderWidth = Dimensions.moon / 2
    view.shadow(Color.Welcome.moonShadow, radius: 30)

    return view
  }()

  lazy var writeView: WriteView = WriteView(font: Font.Welcome.title, string: Text.Welcome.title)

  var stars: [UIView] = []

  override init(frame: CGRect) {
    super.init(frame: frame)

    [moon, writeView].forEach { addSubview($0) }

    prepareStars()
    setupConstraints()
    setupFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  func prepareAnimation(enter: Bool = true) {
    moon.transform = CGAffineTransformMakeTranslation(0, -500)
    writeView.alpha = 0
  }

  func animate(enter: Bool = true, completion: () -> ()) {
    UIView.animateWithDuration(0.4, animations: {
      self.writeView.alpha = 1
    })

    spring(moon, spring: 50, friction: 60, mass: 50, animations: {
      $0.transform = CGAffineTransformIdentity
    }).finally({
      completion()
    })
  }

  func connect() {
    let duration = 0.3
    let animation = CABasicAnimation(keyPath: "borderWidth")

    animation.fromValue = Dimensions.moon / 2
    animation.toValue = Dimensions.moonStroke
    animation.duration = duration
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.additive = false
    animation.cumulative = false
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

    moon.layer.addAnimation(animation, forKey: "border-animation")

    delay(duration) {
      self.stone()
      self.writeView.deleteAnimation()
    }
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

  func setupFrames() {
    writeView.frame.size.width = UIScreen.mainScreen().bounds.width - Dimensions.writeOffset
    writeView.frame.origin = CGPoint(
      x: Dimensions.writeOffset / 2,
      y: Dimensions.welcomeOffset)
  }

  // MARK: - Helper methods

  func stone(duration: NSTimeInterval = 4, multiplier: CGFloat = 1.65, divider: CGFloat = 1.5) {
    ripple(moon.center,
           view: self,
           size: Dimensions.moon,
           duration: duration, multiplier: multiplier, divider: divider,
           color: Color.General.ripple)
  }

  func prepareStars() {
    let sizes = [Dimensions.smallStar, Dimensions.mediumStar, Dimensions.bigStar]
    let screenSize = UIScreen.mainScreen().bounds

    for _ in 0..<WelcomeView.starNumber {
      let star = UIView()
      let index = Int(arc4random_uniform(UInt32(sizes.count)))
      let size = sizes[index]

      star.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(screenSize.width))),
                          y: CGFloat(arc4random_uniform(UInt32(screenSize.height / 1.75))),
                          width: size, height: size)
      star.backgroundColor = Color.Welcome.star
      star.layer.cornerRadius = size / 2
      star.shadow(Color.Welcome.starShadow, radius: 15)

      stars.append(star)
      addSubview(star)
    }
  }
}
