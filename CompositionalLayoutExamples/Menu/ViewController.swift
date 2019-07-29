//
//  ViewController.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

import UIKit

protocol CellDisplay {
    
    var displayName: String { get }
}

enum LayoutDesign: CaseIterable, CellDisplay {
    
    case appStore
    case pinterest
    
    var displayName: String {
        
        switch self {
        case .appStore: return "App Store"
        case .pinterest: return "Pinterest"
        }
    }
}

enum LayoutExample: CaseIterable, CellDisplay {
    
    case list
    case grid
    case nestedGroups
    case distinctSections
    case orthogonalScrolling
    
    var displayName: String {
        
        switch self {
        case .list: return "List"
        case .grid: return "Grid"
        case .nestedGroups: return "Nested Groups"
        case .distinctSections: return "Distinct Sections"
        case .orthogonalScrolling: return "Orthogonal Scrolling"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var layouts: [[CellDisplay]] = [LayoutExample.allCases, LayoutDesign.allCases]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Compositional Layouts"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return layouts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.ReuseID) as! ListTableViewCell
        cell.label.text = layouts[indexPath.section][indexPath.row].displayName
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc: UIViewController
        
        let layout = layouts[indexPath.section][indexPath.row]
        
        if let _layout = layout as? LayoutExample {
            
            switch _layout {
            case .list: vc = ListVC()
            case .grid: vc = GridVC()
            case .nestedGroups: vc = NestedGroupsVC()
            case .distinctSections: vc = DistinctSectionsVC()
            case .orthogonalScrolling: vc = OrthogonalScrollingVC()
            }
        
        } else if let _layout = layout as? LayoutDesign {
            
            switch _layout {
            case .appStore: vc = AppStoreVC()
            case .pinterest: vc = PinterestVC()
            }
        
        } else {
            
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 60))
        headerView.backgroundColor = UIColor.systemBackground
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: view.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        if section == 0 {
            label.text = "Examples"
        } else {
            label.text = "Case Studies"
        }
        headerView.addSubview(label)
        return headerView
    }
}

