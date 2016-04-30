import UIKit
import Photos
import PhotosUI

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
      static let topOffset: CGFloat = 12
      static let bottomOffset: CGFloat = 20
    }
  }

  lazy var productView: PHLivePhotoView = {
    let imageView = PHLivePhotoView()
    imageView.translatesAutoresizingMaskIntoConstraints = false

    return imageView
  }()

  lazy var footerLabel: UILabel = {
    let label = UILabel()
    label.font = Font.Story.footer
    label.textColor = Color.Story.general
    label.numberOfLines = 0
    label.textAlignment = .Center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isAccessibilityElement = true
    label.accessibilityTraits = UIAccessibilityTraitStaticText
    
    return label
  }()

  var storyModel: StoryViewModel?

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
    storyModel = viewModel
    footerLabel.text = viewModel.footer

    preparePhoto()
    setupConstraints()
  }

  // MARK: - Live photos

  func preparePhoto() {
    let bundle = NSBundle.mainBundle()

    guard let viewModel = storyModel, modelImage = viewModel.image,
      image = bundle.URLForResource("\(modelImage)_bundle", withExtension: "JPG"),
      video = bundle.URLForResource("\(modelImage)_bundle", withExtension: "MOV") else { return }

    PHLivePhoto.requestLivePhotoWithResourceFileURLs(
      [image, video], placeholderImage: UIImage(named: viewModel.image ?? ""),
      targetSize: CGSize(width: UIScreen.mainScreen().bounds.width, height: Dimensions.Image.height),
      contentMode: .AspectFill, resultHandler: { [weak self] livePhoto, information in
        guard let weakSelf = self, cancelled = information[PHLivePhotoInfoCancelledKey] as? Int
          where cancelled == 0 else { return }
        weakSelf.productView.livePhoto = livePhoto
    })
  }

  // MARK: - Touches

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    productView.startPlaybackWithStyle(.Full)
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
