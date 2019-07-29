//
//  OrthogonalScrollingVC.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class OrthogonalScrollingVC: UIViewController {

    static let headerElementKind = "header-element-kind"

    enum SectionKind: Int, CaseIterable {
        case continuous
        case continuousGroupLeadingBoundary
        case paging
        case groupPaging
        case groupPagingCentered
        case none
        
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .none:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.none
            case .continuous:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
            case .continuousGroupLeadingBoundary:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuousGroupLeadingBoundary
            case .paging:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.paging
            case .groupPaging:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
            case .groupPagingCentered:
                return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPagingCentered
            }
        }
        
        var sectionColor: UIColor {
            switch self {
            case .none: return UIColor.systemFill
            case .continuous: return UIColor.systemTeal
            case .continuousGroupLeadingBoundary: return UIColor.systemRed
            case .paging: return UIColor.systemBlue
            case .groupPaging: return UIColor.systemYellow
            case .groupPagingCentered: return UIColor.systemPink
            }
        }
        
        var heading: String {
            switch self {
            case .none: return "None"
            case .continuous: return "Continuous"
            case .continuousGroupLeadingBoundary: return "Continuous Group Leading Boundary"
            case .paging: return "Paging"
            case .groupPaging: return "Group Paging"
            case .groupPagingCentered: return "Group Paging Centered"
            }
        }
    }

    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orthogonal Scrolling Behaviors"
        configureHierarchy()
    }
}

extension OrthogonalScrollingVC {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createOrthogonalScrollingLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.register(TitleView.cellNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleView.id)
        view.addSubview(collectionView)
        collectionView.dataSource = self
    }
}

extension OrthogonalScrollingVC {

    private func createOrthogonalScrollingLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let height: CGFloat = 250
            
            let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
            
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            let smallItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let smallItemsGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallItemGroupSize, subitems: [smallItem])
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(height))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [bigItem, smallItemsGroup])
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = SectionKind.allCases[sectionIndex].orthogonalScrollingBehavior
            
            return section
        }
        return layout
    }
}

extension OrthogonalScrollingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension OrthogonalScrollingVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else {
            fatalError("Cannot create new cell")
        }
        
        cell.label.text = "\(indexPath.section), \(indexPath.item)"
        cell.label.layer.cornerRadius = 10
        cell.label.layer.masksToBounds = true
        cell.label.backgroundColor = SectionKind.allCases[indexPath.section].sectionColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleView.id, for: indexPath) as! TitleView
        header.title.text = SectionKind.allCases[indexPath.section].heading
        return header
    }
}
