import UIKit

class CardStyleSheetsViewController: UIViewController {
  lazy var isSwipeToDismissEnabledLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var isSwipeToDismissEnabledSwitch: UISwitch = {
    let view = UISwitch()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isOn = CardStyleSheetsViewController.isSwipeToDismissEnabled
    view.addTarget(self, action: #selector(didChangeSwipeToDismissSwitch), for: .valueChanged)
    return view
  }()
  
  @objc func didChangeSwipeToDismissSwitch() {
    CardStyleSheetsViewController.isSwipeToDismissEnabled.toggle()
    updateSettings()
  }
  
  lazy var isFullScreenModeEnabledLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var isFullScreenModeEnabledSwitch: UISwitch = {
    let view = UISwitch()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isOn = CardStyleSheetsViewController.isFullScreenModeEnabled
    view.addTarget(self, action: #selector(didChangeFullScreenModeSwitch), for: .valueChanged)
    return view
  }()
  
  @objc func didChangeFullScreenModeSwitch() {
    CardStyleSheetsViewController.isFullScreenModeEnabled.toggle()
    updateSettings()
  }
  
  lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 10
    stackView.axis = .vertical
    stackView.alignment = .center
    return stackView
  }()
  
  lazy var button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Present modal screen", for: .normal)
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    button.backgroundColor = .systemFill
    button.setTitleColor(.label, for: .normal)
    button.layer.cornerRadius = 10
    return button
  }()
  
  @objc func didTapButton() {
    let navController = UINavigationController(rootViewController: ModalViewController())
    navController.modalPresentationStyle = CardStyleSheetsViewController.isFullScreenModeEnabled ? .fullScreen : .automatic
    navController.isModalInPresentation = CardStyleSheetsViewController.isSwipeToDismissEnabled ? false : true
    present(navController, animated: true)
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    verticalStackView.addArrangedSubview(isSwipeToDismissEnabledLabel)
    verticalStackView.addArrangedSubview(isSwipeToDismissEnabledSwitch)
    verticalStackView.addArrangedSubview(isFullScreenModeEnabledLabel)
    verticalStackView.addArrangedSubview(isFullScreenModeEnabledSwitch)
    
    view.addSubview(verticalStackView)
    NSLayoutConstraint.activate([
      verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
      button.heightAnchor.constraint(equalToConstant: 60),
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    updateSettings()
  }
  
  // MARK: Settings
  
  func updateSettings() {
    view.backgroundColor = UIColor.systemBackground
    
    isSwipeToDismissEnabledLabel.textColor = UIColor.secondaryLabel
    isFullScreenModeEnabledLabel.textColor = UIColor.secondaryLabel
    
    isSwipeToDismissEnabledLabel.text = CardStyleSheetsViewController.isSwipeToDismissEnabled ? "Swipe to dismiss is enabled" : "Swipe to dismiss is disabled"
    isFullScreenModeEnabledLabel.text = CardStyleSheetsViewController.isFullScreenModeEnabled ? "Fullscreen modal is enabled" : "Fullscreen modal is disabled"
  }
}

class ModalViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
  }
  
  @objc func didTapCancel() {
    dismiss(animated: true)
  }
}

extension CardStyleSheetsViewController {
  static var isSwipeToDismissEnabled: Bool {
    set { UserDefaults.standard.set(newValue, forKey: "isSwipeToDismissEnabled") }
    get { UserDefaults.standard.bool(forKey: "isSwipeToDismissEnabled") }
  }
  
  static var isFullScreenModeEnabled: Bool {
    set { UserDefaults.standard.set(newValue, forKey: "isFullScreenModeEnabled") }
    get { UserDefaults.standard.bool(forKey: "isFullScreenModeEnabled") }
  }
}
