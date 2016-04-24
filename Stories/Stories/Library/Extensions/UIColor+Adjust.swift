import UIKit

extension UIColor {

  func darker() -> UIColor {
    let value: CGFloat = 0.2
    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
    
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return UIColor(red: red - value, green: green - value, blue: blue - value, alpha: alpha)
  }
}
