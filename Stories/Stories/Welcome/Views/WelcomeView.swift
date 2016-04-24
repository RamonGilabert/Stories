import UIKit
import Walker
import Sugar

protocol WelcomeViewDelegate {

  func dismissController()
}

class WelcomeView: UIView {

  struct Dimensions {
    static let landscape: CGFloat = UIScreen.mainScreen().bounds.height / 1.75
    static let welcomeOffset: CGFloat = UIScreen.mainScreen().bounds.height / 1.375
    static let writeOffset: CGFloat = 90
  }

  struct Constants {
    static let mediumAlpha: CGFloat = 0.1
  }

  lazy var landscape: LandscapeView = LandscapeView()
  lazy var writeView: WriteView = WriteView(font: Font.Welcome.title, string: Text.Welcome.title)
  lazy var secondWrite: WriteView = WriteView(font: Font.Connecting.title, string: Text.Connecting.second)

  var initialFrame = CGRectZero
  var delegate: WelcomeViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)

    [landscape, writeView, secondWrite].forEach { addSubview($0) }

    setupConstraints()
    setupFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  func prepareAnimation(enter: Bool = true) {
    landscape.moon.transform = CGAffineTransformMakeTranslation(0, -1000)
    writeView.alpha = 0
  }

  func animate(enter: Bool = true, completion: () -> ()) {
    UIView.animateWithDuration(0.4, animations: {
      self.writeView.alpha = 1
    })

    spring(landscape.moon, spring: 50, friction: 60, mass: 50, animations: {
      $0.transform = CGAffineTransformIdentity
    }).finally({
      completion()
    })
  }

  func connect() {
    let duration = 0.3
    let animation = CABasicAnimation(keyPath: "borderWidth")

    animation.fromValue = LandscapeView.Dimensions.moon / 2
    animation.toValue = LandscapeView.Dimensions.moonStroke
    animation.duration = duration
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.additive = false
    animation.cumulative = false
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

    landscape.moon.layer.addAnimation(animation, forKey: "border-animation")

    writeView.deleteAnimation {
      self.writeView.font = Font.Connecting.title
      self.writeView.string = Text.Connecting.first
      self.writeView.velocity = 2

      delay(0.4) {
        self.writeView.changeText { self.nextWritingView() }
      }
    }

    delay(duration) {
      self.landscape.stone()
    }
  }

  func nextWritingView() {
    UIView.animateWithDuration(0.4, animations: {
      self.writeView.transform = CGAffineTransformMakeTranslation(0, 5)
      }, completion: { _ in
        self.writeView.cursorAnimation = false

        spring(self.writeView, spring: 50, friction: 60, mass: 50, animations: {
          $0.transform = CGAffineTransformMakeTranslation(0, -120)
          $0.alpha = Constants.mediumAlpha
        }).finally({
          delay(0.4) {
            self.secondWrite.frame = self.initialFrame
            self.secondWrite.velocity = 1
            self.secondWrite.startAnimation {
              self.secondWrite.cursorAnimation = false

              delay(1) {
                self.dismissView()
              }
            }
          }
        })
    })
  }

  func dismissView() {
    UIView.animateWithDuration(0.6, animations: {
      self.transform = CGAffineTransformMakeScale(1.1, 1.1)
      }, completion: { _ in
        UIView.animateWithDuration(0.3, animations: {
          self.transform = CGAffineTransformMakeScale(0.001, 0.001)
          }, completion: { _ in
            self.delegate?.dismissController()
        })
    })
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      landscape.widthAnchor.constraintEqualToAnchor(widthAnchor),
      landscape.heightAnchor.constraintEqualToConstant(Dimensions.landscape),
      landscape.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      landscape.topAnchor.constraintEqualToAnchor(topAnchor)
      ])
  }

  func setupFrames() {
    writeView.frame.origin = CGPoint(
      x: Dimensions.writeOffset / 2,
      y: Dimensions.welcomeOffset)
    writeView.frame.size.width = UIScreen.mainScreen().bounds.width - Dimensions.writeOffset

    initialFrame = writeView.frame
  }
}
