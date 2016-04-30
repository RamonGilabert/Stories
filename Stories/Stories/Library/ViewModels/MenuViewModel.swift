import UIKit

struct MenuViewModel {

  enum Kind {
    case Story, Motivation, Default
  }

  var title: String
  var hint: String

  static func cells(kind: Kind = .Default) -> [MenuViewModel] {
    var cells: [MenuViewModel] = [
      MenuViewModel(title: Text.Menu.story, hint: Text.Accessibility.Hint.story),
      MenuViewModel(title: Text.Menu.motivation, hint: Text.Accessibility.Hint.motivation),
      MenuViewModel(title: Text.Menu.end, hint: Text.Accessibility.Hint.end),
      MenuViewModel(title: Text.Menu.github, hint: Text.Accessibility.Hint.github),
      MenuViewModel(title: Text.Menu.contact, hint: Text.Accessibility.Hint.contact)
    ]

    switch(kind) {
    case .Story:
      cells[0] = MenuViewModel(title: Text.Menu.backStory, hint: Text.Accessibility.Hint.back)
      cells[1] = MenuViewModel(title: Text.Menu.motivation, hint: Text.Accessibility.Hint.motivation)
    case .Motivation:
      cells[0] = MenuViewModel(title: Text.Menu.story, hint: Text.Accessibility.Hint.story)
      cells[1] = MenuViewModel(title: Text.Menu.backStory, hint: Text.Accessibility.Hint.back)
    default:
      break
    }

    return cells
  }
}
