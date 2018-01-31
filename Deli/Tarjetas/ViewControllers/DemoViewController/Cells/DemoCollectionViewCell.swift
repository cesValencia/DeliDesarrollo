//
//  DemoCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: BasePageCollectionCell {
  
    @IBOutlet weak var centerView: UIView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var customTitle: UILabel!
  @IBOutlet weak var texto2: UILabel!
    @IBOutlet weak var texto3: UILabel!
    @IBOutlet weak var texto4: UILabel!
    @IBOutlet weak var barra: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      customTitle.layer.shadowRadius = 2
      customTitle.layer.shadowOffset = CGSize(width: 0, height: 2)
      customTitle.layer.shadowOpacity = 0.2
    }
}
