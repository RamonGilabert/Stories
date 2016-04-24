import UIKit

class StoryImageCell: UITableViewCell {

  static let reusableIdentifier = "StoryImageCellIdentifier"

  lazy var productView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  lazy var footerLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [productView, footerLabel].forEach { addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(viewModel: StoryViewModel) {

  }

  // MARK: - Constraints

  func setupConstraints() {
    
  }
}
