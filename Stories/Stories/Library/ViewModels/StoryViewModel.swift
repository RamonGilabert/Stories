import UIKit

struct StoryViewModel {

  enum Kind {
    case Text, Image
  }

  var title: String
  var cells: [StoryViewModel]
  var letter: String?
  var text: String?
  var image: String?
  var footer: String?
  var kind: Kind?

  init(title: String = "", cells: [StoryViewModel] = [], letter: Bool = false,
       text: String? = nil, image: String? = nil, footer: String? = nil) {

    self.title = title
    self.cells = cells
    self.text = text
    self.image = image
    self.footer = footer
    self.kind = image == nil ? .Text : .Image

    if let text = text, string = text.characters.first where letter {
      self.letter = String(string).uppercaseString
    }
  }

  static let story = StoryViewModel(title: Text.Story.title, cells: [
    StoryViewModel(letter: true, text: Text.Story.message),
    StoryViewModel(image: Image.Story.main, footer: Text.Story.footer),
    StoryViewModel(text: Text.Story.conclusion)
    ])

  static let motivation = StoryViewModel(title: Text.Motivation.title, cells: [
    StoryViewModel(letter: true, text: Text.Motivation.message),
    StoryViewModel(image: Image.Motivation.main, footer: Text.Motivation.footer),
    StoryViewModel(text: Text.Motivation.conclusion)
    ])
}
