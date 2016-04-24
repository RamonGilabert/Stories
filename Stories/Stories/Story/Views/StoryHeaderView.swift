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
      static let topOffset: CGFloat = 40
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

  init(title: String) {
    super.init(frame: CGRectZero)

    translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    [titleLabel, separator].forEach { addSubview($0) }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      titleLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      titleLabel.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Title.offset),

      separator.widthAnchor.constraintEqualToConstant(Dimensions.Separator.width),
      separator.heightAnchor.constraintEqualToConstant(Dimensions.Separator.height),
      separator.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      separator.topAnchor.constraintEqualToAnchor(titleLabel.bottomAnchor, constant: Dimensions.Separator.topOffset)
      ])
  }
}
