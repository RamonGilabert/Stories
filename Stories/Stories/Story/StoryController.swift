import UIKit
import Transition
import Walker

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

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    storyView.tableView.contentOffset = CGPointZero
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    storyView.shouldAnimate = true
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

  func prepareAnimate() {
    view.alpha = 1
    storyView.headerView.titleLabel.transform = CGAffineTransformMakeTranslation(0, -300)
    storyView.headerView.separator.transform = CGAffineTransformMakeTranslation(0, 600)
  }

  func animate() {
    spring(storyView.headerView.titleLabel, storyView.headerView.separator, spring: 50, friction: 60, mass: 50, animations: {
      [$0, $1].forEach { $0.transform = CGAffineTransformIdentity }
    })
  }
}

extension StoryController: StoryViewDelegate {

  func menuButtonDidPress() {
    delegate?.storyMenuDidPress()
  }
}
