//
//  DropDownCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit

class DropDownCVC: UICollectionViewCell {

    static let identifier = "DropDownCVC"

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = DropDownDetailTVC.rowHeight
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            } else {
                // Fallback on earlier versions
            }
        }
    }

    lazy var isOpen: Bool = false
    lazy var detailArray: [Any] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(withClassAndIdentifier: DropDownDetailTVC.self)
    }

    func fillCell() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DropDownCVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownDetailTVC.identifier,
                                                       for: indexPath) as? DropDownDetailTVC else { return UITableViewCell() }

        return cell
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect(x: 30, y: 0, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
        label.text = "Header"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "LabelColor")
        headerView.addSubview(label)
        return headerView
    }
}

// MARK: - UITableViewDelegate
extension DropDownCVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
