import UIKit

class StoryImageCell: UITableViewCell {

  static let reusableIdentifier = "StoryImageCellIdentifier"

  struct Dimensions {
    struct Image {
      static let widthOffset: CGFloat = 40
      static let height: CGFloat = 230
      static let topOffset: CGFloat = 5
    }

    struct Footer {
      static let widthOffset: CGFloat = 60
      static let topOffset: CGFloat = 7
      static let bottomOffset: CGFloat = 10
    }
  }

  lazy var productView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false

    return imageView
  }()

  lazy var footerLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .Center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .None
    backgroundColor = Color.General.clear

    [productView, footerLabel].forEach { addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(viewModel: StoryViewModel) {
    productView.image = UIImage(named: viewModel.image ?? "")
    footerLabel.text = viewModel.footer

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      productView.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -Dimensions.Image.widthOffset),
      productView.heightAnchor.constraintEqualToConstant(Dimensions.Image.height),
      productView.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      productView.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Image.topOffset),

      footerLabel.widthAnchor.constraintLessThanOrEqualToAnchor(widthAnchor, constant: -Dimensions.Footer.widthOffset),
      footerLabel.topAnchor.constraintEqualToAnchor(productView.bottomAnchor, constant: Dimensions.Footer.topOffset),
      footerLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      footerLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Footer.bottomOffset)
      ])
  }
}
