import UIKit

class StoryCell: UITableViewCell {

  static let reusableIdentifier = "StoryCellIdentifier"

  lazy var letterLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  lazy var textView: UITextView = {
    let textView = UITextView()
    return textView
  }()

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
