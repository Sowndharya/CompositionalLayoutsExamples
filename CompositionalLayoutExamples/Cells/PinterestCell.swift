//
//  PinterestCell.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class PinterestCell: UICollectionViewCell, CellInterface {

    @IBOutlet weak var pinImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        pinImage.layer.cornerRadius = 8
    }
}
