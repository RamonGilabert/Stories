import UIKit

struct Font {

  struct Brandon {
    static let bold = "BrandonGrotesque-Bold"
  }

  struct Monaco {
    static let regular = "Monaco"
  }

  struct Welcome {
    static let title = UIFont(name: Brandon.bold, size: 40)!
  }

  struct Connecting {
    static let title = UIFont(name: Monaco.regular, size: 28)!
  }

  struct Engine {
    static let text = UIFont(name: Monaco.regular, size: 24)!
    static let button = UIFont(name: Monaco.regular, size: 18)!
  }

  struct Menu {
    static let title = UIFont(name: Brandon.bold, size: 30)!
  }

  struct Story {
    static let title = UIFont(name: Brandon.bold, size: 30)!
    static let letter = UIFont(name: Brandon.bold, size: 87)!
    static let message = UIFont.systemFontOfSize(20)
  }
}
