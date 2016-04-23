import UIKit
import SafariServices

class WebsiteController: SFSafariViewController {

  override init(URL: NSURL, entersReaderIfAvailable: Bool) {
    super.init(URL: URL, entersReaderIfAvailable: false)
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
