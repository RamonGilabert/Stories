import UIKit

struct MenuViewModel {

  enum Kind {
    case Story, Motivation, Default
  }

  var title: String
  var hint: String

  static func cells(kind: Kind = .Default) -> [MenuViewModel] {
    var cells: [MenuViewModel] = [
      MenuViewModel(title: Text.Menu.story, hint: ""),
      MenuViewModel(title: Text.Menu.motivation, hint: ""),
      MenuViewModel(title: Text.Menu.end, hint: ""),
      MenuViewModel(title: Text.Menu.github, hint: ""),
      MenuViewModel(title: Text.Menu.contact, hint: "")
    ]

    switch(kind) {
    case .Story:
      cells[0] = MenuViewModel(title: Text.Menu.backStory, hint: "")
      cells[1] = MenuViewModel(title: Text.Menu.motivation, hint: "")
    case .Motivation:
      cells[0] = MenuViewModel(title: Text.Menu.story, hint: "")
      cells[1] = MenuViewModel(title: Text.Menu.backStory, hint: "")
    default:
      break
    }

    return cells
  }
}
