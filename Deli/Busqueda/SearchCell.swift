//
//  SearchCell.swift
//  SearchController
//
//  Created by David Valencia on 02/02/18.
//  Copyright © 2018 David Valencia. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(restaurant: String, zonaRest: String) {
        self.init(style: .default, reuseIdentifier: nil)
        
        let nombre = NSMutableAttributedString(string: restaurant, attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 16.0)!, NSAttributedStringKey.foregroundColor : UIColor(red: 92/255, green: 91/255, blue: 92/255, alpha: 0.56)])
        let zona = NSMutableAttributedString(string: " " + zonaRest, attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Italic", size: 16.0)!, NSAttributedStringKey.foregroundColor : UIColor(red: 92/255, green: 91/255, blue: 92/255, alpha: 0.56)])
        let nameZone = NSMutableAttributedString()
        nameZone.append(nombre)
        nameZone.append(zona)
        
        let container = UILabel(frame: CGRect(x: wScreen * 0.1, y: 0, width: wScreen, height: hScreen * 0.1))
        container.attributedText = nameZone
        addSubview(container)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
