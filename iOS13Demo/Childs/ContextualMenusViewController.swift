import UIKit

class ContextualMenusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let photos: [UIImage] = [
    UIImage(named: "dog1")!,
    UIImage(named: "dog2")!,
    UIImage(named: "dog3")!,
    UIImage(named: "dog4")!,
    UIImage(named: "dog5")!
  ]
  
  lazy var tableView: UITableView = {
    let view = UITableView()
    view.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    view.delegate = self
    view.dataSource = self
    view.translatesAutoresizingMaskIntoConstraints = false
    view.separatorStyle = .none
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    updateSettings()
  }
  
  func updateSettings() {
    view.backgroundColor = UIColor.systemBackground
  }
  
  // MARK: - Table view
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let photo = photos[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    cell.photoImageView.image = photo
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let photo = photos[indexPath.row]
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}

class TableViewCell: UITableViewCell {
  let photoImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.backgroundColor = .red
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(photoImageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    photoImageView.frame = bounds
  }
}
