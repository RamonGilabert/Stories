import UIKit

extension UIView {

  func prepareStars(sizes: [CGFloat], _ number: Int, _ divider: CGFloat = 1) {
    let screenSize = UIScreen.mainScreen().bounds

    for _ in 0..<number {
      let star = UIView()
      let index = Int(arc4random_uniform(UInt32(sizes.count)))
      let size = sizes[index]

      star.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(screenSize.width))),
                          y: CGFloat(arc4random_uniform(UInt32(screenSize.height / divider))),
                          width: size, height: size)
      star.backgroundColor = Color.Welcome.star
      star.layer.cornerRadius = size / 2
      star.opaque = true
      star.clipsToBounds = true
      star.layer.drawsAsynchronously = true

      addSubview(star)
    }
  }
}
