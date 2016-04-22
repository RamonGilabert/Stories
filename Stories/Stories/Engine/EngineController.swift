import UIKit

class EngineController: GeneralController {

  lazy var engineView: EngineView = { [unowned self] in
    let view = EngineView()
    view.delegate = self

    return view
  }()
}

extension EngineController: EngineViewDelegate {

  func menuButtonDidPress() {
    // TODO: Show the menu.
  }
}
