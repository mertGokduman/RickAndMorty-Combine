//
//  DropDownCVC.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit
import Combine

class DropDownCVC: UICollectionViewCell {

    static let identifier = "DropDownCVC"

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = DropDownDetailTVC.rowHeight
            tableView.isScrollEnabled = false
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
        }
    }

    lazy var isOpen: Bool = false
    lazy var dataArray: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(withClassAndIdentifier: DropDownDetailTVC.self)
    }

    func fillCell(with data: [String],
                  title: String) {
        lblTitle.text = title
        self.dataArray = data
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DropDownCVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownDetailTVC.identifier,
                                                       for: indexPath) as? DropDownDetailTVC else { return UITableViewCell() }
        cell.fillCell(with: self.dataArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DropDownCVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
