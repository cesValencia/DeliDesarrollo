//
//  CollectionViewEx5.swift
//  Deli
//
//  Created by David Valencia on 16/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class CollectionViewEx5: UICollectionViewCell {
    
    var imgTriv = UIImageView()
    var mes = UILabel()
    var trivia = UILabel()
    var valorPremio = UILabel()
    var btn = UIButton()
    var lineSpace = UIView()
    
    func setCellSubviews() {
        
        imgTriv = UIImageView(frame: CGRect(x: frame.width * 0.1365, y: 0, width: frame.width * 0.727, height: frame.width * 0.727))
        addSubview(imgTriv)
        
        mes = UILabel(frame: CGRect(x: frame.width * 0.125, y: imgTriv.frame.maxY + 15, width: frame.width * 0.7, height: frame.height * 0.076))
        mes.textColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
        mes.font = UIFont(name: "Roboto-Black", size: 13.5)
        addSubview(mes)
        
        trivia = UILabel(frame: CGRect(x: frame.width * 0.125, y: mes.frame.maxY, width: frame.width * 0.7, height: frame.height * 0.24))
        trivia.textColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        trivia.font = UIFont(name: "Roboto-Bold", size: 15)
        trivia.numberOfLines = 3
        addSubview(trivia)
        
        valorPremio = UILabel(frame: CGRect(x: frame.width * 0.125, y: trivia.frame.maxY, width: frame.width * 0.7, height: frame.height * 0.13))
        valorPremio.textColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        valorPremio.font = UIFont(name: "HelveticaNeue-Bold", size: 11.25)
        valorPremio.numberOfLines = 2
        addSubview(valorPremio)
        
        lineSpace = UIView(frame: CGRect(x: frame.width - frame.width * 0.01, y: 0, width: frame.width * 0.005, height: frame.height))
        lineSpace.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        addSubview(lineSpace)
    }
}
