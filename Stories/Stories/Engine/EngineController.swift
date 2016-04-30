import UIKit
import Transition

protocol EngineControllerDelegate {

  func enginePresentMenu()
  func enginePresentFinale()
}

class EngineController: GeneralController {

  lazy var transition: Transition = {
    let transition = Transition() { controller, show in
      guard let controller = controller as? EngineController else { return }
      controller.view.alpha = show ? 1 : 0
    }

    transition.spring = (0.6, 0.4)
    transition.animationDuration = 1

    return transition
  }()

  lazy var engineView: EngineView = { [unowned self] in
    let view = EngineView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self

    return view
  }()

  var story = Engine.initialTexts
  var buttons = Engine.initialButtons
  var shouldAnimate = true
  var delegate: EngineControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(engineView)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    guard shouldAnimate else { return }

    story = Engine.initialTexts
    buttons = Engine.initialButtons
    engineView.prepareButtons()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    if let first = engineView.currentButtons.first, last = engineView.currentButtons.last {
      engineView.animateButtons(true, first, last)
    }

    if let text = story.first where shouldAnimate {
      shouldAnimate = false
      engineView.animateText(text, Engine.buttons(text))
    }
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      engineView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      engineView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      engineView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      engineView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
      ])
  }
}

extension EngineController: Animatable {

  func prepareAnimate() {
    view.alpha = 0
  }

  func animate() {
    UIView.animateWithDuration(0.7, animations: {
      self.view.alpha = 1
    })
  }
}

extension EngineController: EngineViewDelegate {

  func menuButtonDidPress() {
    delegate?.enginePresentMenu()
  }

  func textDidEndDisplaying() {
    story.removeFirst()

    if let text = story.first where !story.isEmpty {
      engineView.changeText(text, buttons: Engine.buttons(text))
    } else {
      delegate?.enginePresentFinale()
    }
  }

  func buttonDidPress(button: String) {
    story = Engine.response(button)

    if let text = story.first where !story.isEmpty {
      if button == Text.Interactive.Buttons.twentyTwoOne
        || button == Text.Interactive.Buttons.twentyTwoTwo {
        engineView.changeText(String(format: text, button), buttons: Engine.buttons(text))
      } else if button == Text.Interactive.Buttons.thirtySixOne
        || button == Text.Interactive.Buttons.thirtySixTwo {
        delegate?.enginePresentFinale()
      } else {
        engineView.changeText(text, buttons: Engine.buttons(text))
      }
    } else {
      delegate?.enginePresentFinale()
    }
  }
}
