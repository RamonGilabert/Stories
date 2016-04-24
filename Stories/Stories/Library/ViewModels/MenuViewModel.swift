import UIKit

struct MenuViewModel {

  enum Kind {
    case Story, Motivation, Default
  }

  var title: String

  static func cells(kind: Kind = .Default) -> [MenuViewModel] {
    var cells: [MenuViewModel] = [
      MenuViewModel(title: Text.Menu.story),
      MenuViewModel(title: Text.Menu.motivation),
      MenuViewModel(title: Text.Menu.end),
      MenuViewModel(title: Text.Menu.github),
      MenuViewModel(title: Text.Menu.contact)
    ]

    switch(kind) {
    case .Story:
      cells[0] = MenuViewModel(title: Text.Menu.backStory)
      cells[1] = MenuViewModel(title: Text.Menu.motivation)
    case .Motivation:
      cells[0] = MenuViewModel(title: Text.Menu.story)
      cells[1] = MenuViewModel(title: Text.Menu.backStory)
    default:
      break
    }

    return cells
  }
}
