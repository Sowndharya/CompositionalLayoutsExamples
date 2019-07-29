//
//  BannerCell.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell, CellInterface {

    @IBOutlet weak var bannerName: UILabel!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    func bindData(withApp app: App) {
        bannerName.text = app.tag.name.uppercased()
        appName.text = app.appName
        appDesc.text = app.appDesc
        bannerImage.image = app.bannerImage
    }
}
