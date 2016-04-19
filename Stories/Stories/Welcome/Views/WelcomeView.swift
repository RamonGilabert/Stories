import UIKit

class WelcomeView: UIView {

  struct Dimensions {
    static let moon: CGFloat = 200
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
    view.backgroundColor = Color.Welcome.moon
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
