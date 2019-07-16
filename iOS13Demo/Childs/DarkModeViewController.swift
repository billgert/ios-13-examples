import UIKit

class DarkModeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let colors: [Color] = [
    Color(system: .systemRed, normal: .red),
    Color(system: .systemBlue, normal: .blue),
    Color(system: .systemYellow, normal: .yellow),
    Color(system: .systemGreen, normal: .green),
    Color(system: .systemOrange, normal: .orange)
  ]
  
  lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var enabledSystemColorsSwitch: UISwitch = {
    let view = UISwitch()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isOn = DarkModeViewController.isSystemColorsEnabled
    view.addTarget(self, action: #selector(didChangeColorSwitch), for: .valueChanged)
    return view
  }()
  
  @objc func didChangeColorSwitch() {
    DarkModeViewController.isSystemColorsEnabled.toggle()
    updateSettings()
  }
  
  lazy var tableView: UITableView = {
    let view = UITableView()
    view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.delegate = self
    view.dataSource = self
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true
    view.backgroundColor = .clear
    view.layer.cornerRadius = 10
    view.separatorStyle = .none
    return view
  }()
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    view.addSubview(enabledSystemColorsSwitch)
    NSLayoutConstraint.activate([
      enabledSystemColorsSwitch.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
      enabledSystemColorsSwitch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
    ])
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.heightAnchor.constraint(equalToConstant: 220)
    ])
    
    updateSettings()
  }
  
  // MARK: Settings
  
  func updateSettings() {
    view.backgroundColor = DarkModeViewController.isSystemColorsEnabled ? UIColor.systemBackground : UIColor.white
    titleLabel.text = DarkModeViewController.isSystemColorsEnabled ? "Using system colors" : "Using basic colors"
    titleLabel.textColor = DarkModeViewController.isSystemColorsEnabled ? UIColor.secondaryLabel : .black
    tableView.reloadData()
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colors.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let color = colors[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.contentView.backgroundColor = DarkModeViewController.isSystemColorsEnabled ? color.system : color.normal
    return cell
  }
}

extension DarkModeViewController {
  static var isSystemColorsEnabled: Bool {
    set { UserDefaults.standard.set(newValue, forKey: "isSystemColorsEnabled") }
    get { UserDefaults.standard.bool(forKey: "isSystemColorsEnabled") }
  }
}

struct Color {
  let system: UIColor
  let normal: UIColor
}
