//
//  PinterestVC.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class PinterestVC: UIViewController {
    
    enum Section {
        case main
    }
    
    struct Item: Hashable {
        let image: UIImage
        let height: CGFloat
        private let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs:Item, rhs:Item) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Item>!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =  LayoutDesign.pinterest.displayName
        configureHierarchy()
        configureDataSource()
    }
}

extension PinterestVC {
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: waterfallLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        collectionView.register(PinterestCell.cellNib, forCellWithReuseIdentifier: PinterestCell.id)
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCell.id, for: indexPath) as! PinterestCell
            cell.pinImage.image = UIImage(named: "Image\(indexPath.item + 1)")
            return cell
        }
        currentSnapshot = intialSnapshot()
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
    func intialSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        let itemCount = 15
        var items = [Item]()
        for index in 0..<itemCount {
            let image = UIImage(named: "Image\(index + 1)")
            let imageHeight: CGFloat
            if let _imageHeight = image?.size.height {
                
                imageHeight = _imageHeight / 2
            
            } else {
                
                imageHeight = UIScreen.main.bounds.height / 4
            }
            
            let item = Item(image: image!, height: imageHeight)
            items.append(item)
        }
        
        let snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        return snapshot
    }
    
    func waterfallLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            var leadingGroupHeight = CGFloat(0.0)
            var trailingGroupHeight = CGFloat(0.0)
            var leadingGroupItems = [NSCollectionLayoutItem]()
            var trailingGroupItems = [NSCollectionLayoutItem]()
            let items = self.currentSnapshot.itemIdentifiers
            
            // could get a bit fancier and balance the columns if they are too different height-wise -  here is just a simple take on this
            
            var runningHeight = CGFloat(0.0)
            for index in 0..<self.currentSnapshot.numberOfItems {
                let item = items[index]
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(item.height))
                let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
                layoutItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                runningHeight += item.height
                
                if leadingGroupHeight <= trailingGroupHeight {
                    
                    leadingGroupItems.append(layoutItem)
                    leadingGroupHeight += item.height
                
                } else {
                    
                    trailingGroupItems.append(layoutItem)
                    trailingGroupHeight += item.height
                }
            }
            
            let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(leadingGroupHeight))
            let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitems:leadingGroupItems)
            
            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(trailingGroupHeight))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitems: trailingGroupItems)
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(max(leadingGroupHeight, trailingGroupHeight)))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [leadingGroup, trailingGroup])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}
