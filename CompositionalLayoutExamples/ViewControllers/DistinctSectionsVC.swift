//
//  DistinctSectionsVC.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class DistinctSectionsVC: UIViewController {

    var collectionView: UICollectionView! = nil
    
    enum LayoutType: CaseIterable {
        case list
        case grid
        case nestedGroups
        init(id : Int) {
            switch id {
            case 0: self = .list
            case 1: self = .grid
            case 2: self = .nestedGroups
            default: self = .list
            }
        }
        var itemCount: Int {
            switch self {
            case .list: return 5
            case .grid: return 10
            case .nestedGroups: return 6
            }
        }
        var sectionColor: UIColor {
            switch self {
            case .list: return UIColor.systemTeal
            case .grid: return UIColor.systemPink
            case .nestedGroups: return UIColor.systemBlue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        navigationItem.title = "Distinct Sections"
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createDistinctSectionsLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.dataSource = self
    }
}

extension DistinctSectionsVC {
    
    private func createDistinctSectionsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = LayoutType(id: sectionIndex)
            
            switch sectionLayoutKind {
            case .list: return self.createListLayout()
            case .grid: return self.createGridLayout()
            case .nestedGroups: return self.createNestedGroupsSection()
            }
        }
        return layout
    }
    
    private func createListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createGridLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return section
    }
    
    func createNestedGroupsSection() -> NSCollectionLayoutSection {
        
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
        
        return section
    }
}

extension DistinctSectionsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return LayoutType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LayoutType.allCases[section].itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
            fatalError("Cannot create new cell")
        }
        
        cell.label.text = "\(indexPath.section), \(indexPath.item)"
        cell.label.layer.cornerRadius = 10
        cell.label.layer.masksToBounds = true
        cell.label.backgroundColor = LayoutType.allCases[indexPath.section].sectionColor
        return cell
    }
}
