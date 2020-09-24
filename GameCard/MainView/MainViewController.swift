//
//  ViewController.swift
//  GameCard
//
//  Created by Евгений on 21.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
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
        collectionView.backgroundColor = #colorLiteral(red: 0.3463526964, green: 0.6376843452, blue: 0.6900572777, alpha: 1)
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

    private func configureSelectCard(cell: CardCell, card: Card) {
        if card.isFaceUp {
            cell.configure(color: #colorLiteral(red: 0.3463526964, green: 0.6376843452, blue: 0.6900572777, alpha: 1), emoji: card.emoji)
        } else {
            cell.configure(color: card.isMatched ? #colorLiteral(red: 0.3463526964, green: 0.6376843452, blue: 0.6900572777, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emoji: nil)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelGame?.numberCards ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UICollectionViewCell() }
        guard let card = modelGame?.getCard(at: indexPath.row) else { return cell }

        configureSelectCard(cell: cell, card: card)

        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        guard var model = modelGame else { return }

        model.tapCount = "1"
        countLabel.text = model.tapCount
        model.stepGame(at: indexPath.row)

        UIView.transition(with: cell.contentView, duration: 1.2, options: .transitionFlipFromBottom, animations: {
            self.configureSelectCard(cell: cell, card: model.getCard(at: indexPath.row))
        },completion: nil)


        var indexPathUpdate = [IndexPath]()
        for i in 0 ..< model.numberCards where i != indexPath.row {
            indexPathUpdate.append(IndexPath(row: i, section: 0))
        }
        collectionView.reloadItems(at: indexPathUpdate)
    }
}

