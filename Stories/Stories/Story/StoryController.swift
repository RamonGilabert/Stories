import UIKit
import Transition

class StoryController: GeneralController {

  lazy var storyView: StoryView = {
    let view = StoryView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
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

extension StoryController: Animatable {

  func animate() {
    UIView.animateWithDuration(0.3, animations: {
      self.view.alpha = 0
    })
  }
}
