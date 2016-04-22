import UIKit

class EngineView: UIView {

  lazy var menu: UIView = {
    let view = UIView()
    return view
  }()

  lazy var writeView: WriteView = {
    let view = WriteView(font: Font., string: <#T##String#>)
    return view
  }()

  lazy var leftButton: OptionButton = {
    let button = OptionButton()
    return button
  }()

  lazy var rightButton: OptionButton = {
    let button = OptionButton()
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
