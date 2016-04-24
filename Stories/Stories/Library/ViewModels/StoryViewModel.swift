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

  static let story = StoryViewModel(title: Text.Story.title, cells: [
    StoryViewModel(letter: Text.Story.firstTitle, text: Text.Story.message),
    StoryViewModel(image: Image.Story.main, footer: Text.Story.footer),
    StoryViewModel(text: Text.Story.conclusion),
    ])

  static let motivation = StoryViewModel(title: Text.Story.title, cells: [
    StoryViewModel(letter: Text.Motivation.firstTitle, text: Text.Motivation.message),
    StoryViewModel(image: Image.Motivation.main, footer: Text.Motivation.footer),
    StoryViewModel(text: Text.Motivation.conclusion),
    ])
}
