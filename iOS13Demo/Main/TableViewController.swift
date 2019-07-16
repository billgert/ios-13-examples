import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let topics: [Topic] = [
    Topic(style: .cardStyleSheets),
    Topic(style: .darkMode)
  ]
  
  lazy var tableView: UITableView = {
    let view = UITableView()
    view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.delegate = self
    view.dataSource = self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Topics"
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topics.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let topic = topics[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = topic.title()
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let topic = topics[indexPath.row]
    let viewController = ViewController(topic: topic)
    navigationController?.pushViewController(viewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
