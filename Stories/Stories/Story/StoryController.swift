import UIKit
import Transition

protocol StoryControllerDelegate {

  func storyMenuDidPress()
}

class StoryController: GeneralController {

  lazy var storyView: StoryView = { [unowned self] in
    let view = StoryView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    
    return view
  }()

  var kind: StoryView.Kind = .Story {
    didSet {
      storyView.kind = kind
    }
  }

  var delegate: StoryControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(storyView)

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      storyView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      storyView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      storyView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      storyView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
      ])
  }
}

extension StoryController: Animatable {

  func animate() {
    UIView.animateWithDuration(0.3, animations: {
      self.view.alpha = 1
    })
  }
}

extension StoryController: StoryViewDelegate {

  func menuButtonDidPress() {
    delegate?.storyMenuDidPress()
  }
}
