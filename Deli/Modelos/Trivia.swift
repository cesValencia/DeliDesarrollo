//
//  Trivia.swift
//  Deli
//
//  Created by David Valencia on 11/02/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import Foundation
import UIKit

class Trivia: NSObject {
    
    var id = ""
    var name = ""
    var status = ""
    var fecha = ""
    var incluye = ""
    var vigencia = ""
    var premio = ""
    var logoB = ""
    var logoN = ""
    var imgP = ""
    var content = ""
    
    override init() {
        super.init()
    }
    
    convenience init(dictionary: NSDictionary){
        self.init()
        
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
        self.fecha = dictionary["fecha"] as? String ?? ""
        self.incluye = dictionary["incluye"] as? String ?? ""
        self.vigencia = dictionary["vigencia"] as? String ?? ""
        self.premio = dictionary["vigencia"] as? String ?? ""
        self.logoB = dictionary["logoB"] as? String ?? ""
        self.logoN = dictionary["logoN"] as? String ?? ""
        self.imgP = dictionary["imgP"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""

    }
}
