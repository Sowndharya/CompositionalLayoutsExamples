//
//  NestedGroupsVC.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class NestedGroupsVC: UIViewController {

    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        navigationItem.title = "Nested Groups"
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createNestedGroupsLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.dataSource = self
    }
}

extension NestedGroupsVC {
    func createNestedGroupsLayout() -> UICollectionViewLayout {
        
        //   +-----------------------------------------------------+
        //   | +---------------------------------+  +-----------+  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |     1     |  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |           |  |
        //   | |                                 |  +-----------+  |
        //   | |               0                 |                 |
        //   | |                                 |  +-----------+  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |     2     |  |
        //   | |                                 |  |           |  |
        //   | |                                 |  |           |  |
        //   | +---------------------------------+  +-----------+  |
        //   +-----------------------------------------------------+

        let height: CGFloat = 250
        
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        
        let smallItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let smallItemsGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallItemGroupSize, subitems: [smallItem])
        
        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [bigItem, smallItemsGroup])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension NestedGroupsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
            fatalError("Cannot create new cell")
        }
        
        cell.label.text = "\(indexPath.item)"
        cell.label.layer.cornerRadius = 10
        cell.label.layer.masksToBounds = true
        cell.label.backgroundColor = UIColor.systemBlue
        return cell
    }
}
