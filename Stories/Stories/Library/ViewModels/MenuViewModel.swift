import UIKit

struct MenuViewModel {

  var title: String

  static var cells: [MenuViewModel] = [
    MenuViewModel(title: Text.Menu.story),
    MenuViewModel(title: Text.Menu.motivation),
    MenuViewModel(title: Text.Menu.end),
    MenuViewModel(title: Text.Menu.github),
    MenuViewModel(title: Text.Menu.contact)
  ]
}
