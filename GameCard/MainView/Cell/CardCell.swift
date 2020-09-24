//
//  CardCell.swift
//  GameCard
//
//  Created by Евгений on 21.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    static var identifier: String = "Card"

    weak var mainView: UIView!
    weak var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        self.mainView = view


        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40)
        label.text = ""

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.label = label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(color: UIColor, emoji: String?) {
        mainView.backgroundColor = color
        if let emoji = emoji { label.text = emoji } else { label.text = "" }
    }
}


