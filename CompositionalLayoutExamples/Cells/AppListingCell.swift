//
//  AppListingCell.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class AppListingCell: UICollectionViewCell, CellInterface {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var inAppPurchases: UILabel!
    
    func bindData(withApp app: App) {
        appIcon.image = nil
        appName.text = app.appName
        appDesc.text = app.appDesc
        if app.isInstalled {
            actionButton.titleLabel?.text = "OPEN"
        } else {
            actionButton.titleLabel?.text = "GET"
        }
        inAppPurchases.isHidden = false
        appIcon.image = app.bannerImage
    }
}
