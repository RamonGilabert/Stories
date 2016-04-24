import UIKit

class StoryCell: UITableViewCell {

  static let reusableIdentifier = "StoryCellIdentifier"

  struct Dimensions {
    struct Letter {
      static let topOffset: CGFloat = 0
      static let leftOffset: CGFloat = 30
    }

    struct Text {
      static let topOffset: CGFloat = 0
      static let leftOffset: CGFloat = 38
      static let bottomOffset: CGFloat = 10
    }
  }

  lazy var letterLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  lazy var textView: UITextView = {
    let textView = UITextView()
    return textView
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [letterLabel, textView].forEach { addSubview($0) }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(viewModel: StoryViewModel) {
//    letterLabel.text = viewModel.letter
    textView.text = viewModel.text ?? ""

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      letterLabel.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Letter.topOffset),
      letterLabel.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Letter.leftOffset),

      textView.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Text.topOffset),
      textView.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Text.leftOffset),
      textView.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: Dimensions.Text.bottomOffset)
      ])
  }
}
