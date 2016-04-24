import UIKit

class StoryHeaderView: UIView {

  struct Dimensions {

    static let shadow: CGFloat = 10

    struct Title {
      static let offset: CGFloat = 65
    }

    struct Separator {
      static let width: CGFloat = 3
      static let height: CGFloat = 45
      static let bottomOffset: CGFloat = 40
    }
  }

  struct Constants {
    static let radius: CGFloat = 1
  }

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = Font.Story.title
    label.textColor = Color.Story.general
    label.translatesAutoresizingMaskIntoConstraints = false
    label.shadow(Color.Story.Shadow.general, radius: 10)

    return label
  }()

  lazy var separator: UIView = {
    let view = UIView()
    view.backgroundColor = Color.Story.general
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = Constants.radius
    view.shadow(Color.Story.Shadow.general, radius: 10)

    return view
  }()

  lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [Color.Story.Gradient.bottom.CGColor, Color.Story.Gradient.top.CGColor]

    return layer
  }()

  var titleConstraint = NSLayoutConstraint()
  var separatorConstraint = NSLayoutConstraint()

  init(title: String) {
    super.init(frame: CGRectZero)
    
    shadow(Color.Story.Shadow.header, radius: 10)

    layer.shadowOpacity = 0
    layer.insertSublayer(gradientLayer, atIndex: 0)
    translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    [titleLabel, separator].forEach { addSubview($0) }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    gradientLayer.frame = bounds
  }

  // MARK: - Constraints

  func setupConstraints() {
    titleConstraint = titleLabel.topAnchor.constraintEqualToAnchor(
      topAnchor, constant: Dimensions.Title.offset)
    separatorConstraint = separator.bottomAnchor.constraintEqualToAnchor(
      bottomAnchor, constant: -Dimensions.Separator.bottomOffset)

    NSLayoutConstraint.activateConstraints([
      titleConstraint,
      titleLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),

      separator.widthAnchor.constraintEqualToConstant(Dimensions.Separator.width),
      separator.heightAnchor.constraintEqualToConstant(Dimensions.Separator.height),
      separator.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      separatorConstraint
      ])
  }
}
