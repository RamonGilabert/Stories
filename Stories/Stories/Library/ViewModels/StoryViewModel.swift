import UIKit

struct StoryViewModel {

  var title: String
  var cells: [StoryViewModel]
  var letter: String?
  var text: String?
  var image: String?
  var footer: String?

  init(title: String = "", cells: [StoryViewModel] = [], letter: String? = nil,
       text: String? = nil, image: String? = nil, footer: String? = nil) {

    self.title = title
    self.cells = cells
    self.letter = letter
    self.text = text
    self.image = image
    self.footer = footer
  }

  static let story = StoryViewModel(title: "", cells: [
    StoryViewModel(letter: "R", text: ""),
    StoryViewModel(image: "R", footer: ""),
    StoryViewModel(letter: "R", text: ""),
    ])

  static let motivation = StoryViewModel(title: "", cells: [
    StoryViewModel(letter: "R", text: ""),
    StoryViewModel(image: "R", footer: ""),
    StoryViewModel(letter: "R", text: ""),
    ])
}
