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

  struct Connect {
    static let title = UIFont(name: Monaco.regular, size: 28)
  }
}
