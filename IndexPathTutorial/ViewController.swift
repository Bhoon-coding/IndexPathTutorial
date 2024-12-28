//
//  ViewController.swift
//  IndexPathTutorial
//
//  Created by 이병훈 on 12/28/24.
//

import UIKit

// MARK: - Data Models
enum CellType {
    case header
    case text(String)
    case image(UIImage?)
    case button(String)
}

struct Section {
    let title: String
    var items: [CellType]
}

// MARK: - Custom Cells
class HeaderCell: UITableViewCell {
    static let identifier = "HeaderCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

class ImageCell: UITableViewCell {
    static let identifier = "ImageCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            customImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            customImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            customImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            customImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage?) {
        customImageView.image = image
    }
}

class TextCell: UITableViewCell {
    static let identifier = "TextCell"
    
    private let customTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(customTextLabel)
        NSLayoutConstraint.activate([
            customTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with text: String) {
        customTextLabel.text = text
    }
}

class ButtonCell: UITableViewCell {
    static let identifier = "ButtonCell"
    
    private let customButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(customButton)
        NSLayoutConstraint.activate([
            customButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            customButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configure(with title: String) {
        customButton.setTitle(title, for: .normal)
    }
}

// MARK: - View Controller
class ViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var sections: [Section] = [
        Section(title: "프로필", items: [
            .header,
            .image(UIImage(named: "profile")),
            .text("사용자 이름")
        ]),
        Section(title: "설정", items: [
            .button("알림 설정"),
            .button("테마 변경"),
            .button("로그아웃")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register cells
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch item {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
            cell.configure(with: section.title)
            return cell
            
        case .image(let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            cell.configure(with: image)
            return cell
            
        case .text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as! TextCell
            cell.configure(with: text)
            return cell
            
        case .button(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
            cell.configure(with: title)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch item {
        case .header:
            return UITableView.automaticDimension
        case .image(let image):
            guard let image = image else { return 44 }
            let aspectRatio = image.size.width / image.size.height
            let width = tableView.bounds.width - 32
            return width / aspectRatio + 16
        case .text, .button:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch item {
        case .button(let title):
            handleButtonTap(title)
        default:
            break
        }
    }
    
    private func handleButtonTap(_ title: String) {
        switch title {
        case "알림 설정":
            // Handle notification settings
            print("알림 설정 탭")
        case "테마 변경":
            // Handle theme change
            print("테마 변경 탭")
        case "로그아웃":
            // Handle logout
            print("로그아웃 탭")
        default:
            break
        }
    }
}
