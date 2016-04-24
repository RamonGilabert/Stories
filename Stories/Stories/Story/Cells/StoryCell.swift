import UIKit

class StoryCell: UITableViewCell {

  static let reusableIdentifier = "StoryCellIdentifier"

  struct Constants {
    static let line: CGFloat = 15
  }

  struct Dimensions {
    struct Letter {
      static let topOffset: CGFloat = 18
      static let leftOffset: CGFloat = 30
    }

    struct Text {
      static let widthOffset: CGFloat = 60
      static let topOffset: CGFloat = 0
      static let leftOffset: CGFloat = 34
      static let bottomOffset: CGFloat = 10
    }
  }

  lazy var letterLabel: UILabel = {
    let label = UILabel()
    label.font = Font.Story.letter
    label.textColor = Color.Story.general
    label.backgroundColor = Color.General.clear
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  lazy var textView: UITextView = {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = Constants.line

    let textView = UITextView()
    textView.typingAttributes = [NSParagraphStyleAttributeName : paragraphStyle]
    textView.font = Font.Story.message
    textView.textColor = Color.Story.general
    textView.backgroundColor = Color.General.clear
    textView.editable = false
    textView.selectable = false
    textView.scrollEnabled = false
    textView.translatesAutoresizingMaskIntoConstraints = false

    return textView
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .None
    backgroundColor = Color.General.clear

    [letterLabel, textView].forEach { addSubview($0) }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(viewModel: StoryViewModel) {
    letterLabel.text = viewModel.letter ?? ""
    textView.text = viewModel.text ?? ""
    textView.sizeToFit()

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      letterLabel.topAnchor.constraintEqualToAnchor(topAnchor, constant: -Dimensions.Letter.topOffset),
      letterLabel.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Letter.leftOffset),

      textView.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -Dimensions.Text.widthOffset),
      textView.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Text.topOffset),
      textView.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Text.leftOffset),
      textView.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Text.bottomOffset)
      ])
  }
}
