import UIKit
import Transition

class StoryController: GeneralController {

  lazy var storyView: StoryView = {
    let view = StoryView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()

  lazy var transition: Transition = {
    let transition = Transition() { controller, show in
      guard let controller = controller as? StoryController else { return }
      controller.view.alpha = show ? 1 : 0
    }

    transition.spring = (0.6, 0.4)
    transition.animationDuration = 1

    return transition
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    // TODO: Prepare the animation.
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    // TODO: Perform the animation.
  }
}
