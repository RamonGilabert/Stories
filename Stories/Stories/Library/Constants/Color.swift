import UIKit
import Hue

struct Color {

  struct Background {
    static let top = UIColor.hex("1B2834")
    static let bottom = UIColor.hex("1D2022")
  }

  struct General {
    static let button = UIColor.whiteColor()
    static let buttonShadow = UIColor.whiteColor().alpha(0.8)
  }

  struct Welcome {
    static let moon = UIColor.whiteColor()
    static let moonShadow = UIColor.whiteColor().alpha(0.75)
    static let star = UIColor.whiteColor()
    static let starShadow = UIColor.whiteColor()
  }

  struct Engine {

    struct Text {
      static let color = UIColor.whiteColor()
      static let cursor = UIColor.whiteColor()
    }
  }
}
