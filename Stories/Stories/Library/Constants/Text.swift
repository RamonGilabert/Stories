import UIKit
import Sugar

struct Text {

  struct Welcome {
    static let title = localizedString("welcome").uppercaseString
  }

  struct Connecting {
    static let first = localizedString("connectingEstablishing")
    static let second = localizedString("connectingConnected")
  }

  struct Menu {
    static let story = localizedString("menuFullStory")
    static let backStory = localizedString("menuBackStory")
    static let motivation = localizedString("menuReadMotivation")
    static let end = localizedString("menuWatchTheEnd")
    static let github = localizedString("menuFindGithub")
    static let contact = localizedString("menuContact")
  }
}
