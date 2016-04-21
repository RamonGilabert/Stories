import UIKit
import Sugar

struct Text {

  struct Welcome {
    static let title = localizedString("welcome").uppercaseString
  }

  struct Connecting {
    static let first = localizedString("connectingFirstMessage")
    static let second = localizedString("connectingSecondMessage")
    static let third = localizedString("connectingThirdMessage")
    static let fourth = localizedString("connectingFourthMessage")
  }
}
