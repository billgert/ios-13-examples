import UIKit

class ViewController: UIViewController {
  private let topic: Topic
  
  init(topic: Topic) {
    self.topic = topic
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = topic.title()
  
    switch topic.style {
    case .cardStyleSheets:
      addViewController(CardStyleSheetsViewController())
    case .darkMode:
      addViewController(DarkModeViewController())
    case .contextualMenus:
      addViewController(ContextualMenusViewController())
    case .accessibility:
      addViewController(AccessibilityViewController())
    case .customFonts:
      addViewController(CustomFontsViewController())
    }
  }
  
  func addViewController(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
}

