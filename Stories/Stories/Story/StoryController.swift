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

  var delegate: StoryControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
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
