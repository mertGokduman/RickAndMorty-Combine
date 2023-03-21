//
//  DetailDataView.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 21.03.2023.
//

import UIKit

class DetailDataView: UIView {

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .bold)
        label.textColor = UIColor(named: "LabelColor")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    // MARK: - SETUP UI
    private func setupUI() {

        self.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lblTitle.heightAnchor.constraint(equalToConstant: 15)
        ])

        self.addSubview(lblValue)
        NSLayoutConstraint.activate([
            lblValue.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lblValue.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 2),
            lblValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lblValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lblValue.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - FILL VIEW
    func fillView(with title: String?,
                  value: String?) {
        lblTitle.text = title
        lblValue.text = value
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
