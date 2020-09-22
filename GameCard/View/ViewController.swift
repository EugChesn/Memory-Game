//
//  ViewController.swift
//  GameCard
//
//  Created by Евгений on 21.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private weak var collectionView: UICollectionView!
    private weak var bottomView: UIView!
    private weak var countLabel: UILabel!

    private var modelGame: Modeling?

    override func loadView() {
        super.loadView()
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.backgroundColor = .white
    }

    /*override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }*/

    private func configure() {
        modelGame = ModelGame()

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 150),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView

        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        view.addSubview(bottomView)

        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        self.bottomView = bottomView

        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = modelGame?.textCount
        countLabel.font = .systemFont(ofSize: 23)
        bottomView.addSubview(countLabel)

        NSLayoutConstraint.activate([
            bottomView.centerXAnchor.constraint(equalTo: countLabel.centerXAnchor),
            bottomView.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor)
        ])
        self.countLabel = countLabel
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelGame?.numberCards ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell

        if let card = modelGame?.getCard(at: indexPath.row) {
            if card.isFaceUp {
                cell.configure(color: .white, emoji: card.emoji)
            } else {
                cell.configure(color: card.isMatched ? .white : #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1), emoji: nil)
            }
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }

        modelGame?.tapCount = "1"
        countLabel.text = modelGame?.tapCount

        modelGame?.stepGame(at: indexPath.row)
        collectionView.reloadData()
    }
}

