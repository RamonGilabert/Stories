import UIKit

extension UIView {

  func shadow(color: UIColor, offset: CGFloat = 0, radius: CGFloat) {
    layer.shadowColor = color.CGColor
    layer.shadowOffset = CGSize(width: 0, height: offset)
    layer.shadowRadius = radius
    layer.shadowOpacity = 1
  }
}
