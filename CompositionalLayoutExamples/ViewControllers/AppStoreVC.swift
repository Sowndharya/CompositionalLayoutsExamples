//
//  AppStoreVC.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class AppStoreVC: UIViewController {

    var collectionView: UICollectionView! = nil
    var appSections = AppsDataProvider.generateFakeApps()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LayoutDesign.appStore.displayName
        configureHierarchy()
    }
}

extension AppStoreVC {
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BannerCell.cellNib, forCellWithReuseIdentifier: BannerCell.id)
        collectionView.register(AppListingCell.cellNib, forCellWithReuseIdentifier: AppListingCell.id)
        collectionView.register(AppListingHeaderView.cellNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppListingHeaderView.id)
        view.addSubview(collectionView)
        collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionType = self.appSections[sectionIndex].section
            
            switch sectionType {
                
            case .banner: return self.getBannerSection()
            case .category(tag:  _): return self.getCategorySection()
                
            }
        }
        
        layout.configuration.interSectionSpacing = 20
        return layout
    }
    
    func getBannerSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    func getCategorySection() -> NSCollectionLayoutSection {
        
        
        let itemHeight: CGFloat = 100
        let groupItemCount = 3
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(itemHeight * CGFloat(groupItemCount)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: groupItemCount)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                      heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

extension AppStoreVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return appSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appSections[section].apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = appSections[indexPath.section].section
        switch section {
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.id, for: indexPath) as! BannerCell
            cell.bindData(withApp: appSections[indexPath.section].apps[indexPath.row])
            return cell
        case .category( _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppListingCell.id, for: indexPath) as! AppListingCell
            cell.bindData(withApp: appSections[indexPath.section].apps[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppListingHeaderView.id, for: indexPath) as! AppListingHeaderView
        header.heading.text = appSections[indexPath.section].section.name
        return header
    }
}
