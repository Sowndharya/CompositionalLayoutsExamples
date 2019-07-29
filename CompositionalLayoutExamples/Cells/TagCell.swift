//
//  TagCell.swift
//  CompositionalLayoutExamples
//
//  Created by Sowndharya M on 21/07/19.
//  Copyright © 2019 Sowndharya M. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell, CellInterface {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tagName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }
}
