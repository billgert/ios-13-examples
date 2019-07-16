import Foundation

struct Topic {
  let style: Style
  
  enum Style {
    case cardStyleSheets
    case darkMode
    case contextualMenus
    case accessibility
    case customFonts
  }
  
  func title() -> String {
    switch style {
    case .cardStyleSheets:
      return "Card Style Sheets"
    case .darkMode:
      return "Dark Mode"
    case .contextualMenus:
      return "Contextual Menus"
    case .accessibility:
      return "Accessibility"
    case .customFonts:
      return "Custom Fonts"
    }
  }
}
