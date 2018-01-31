//
//  Horarios.swift
//  Deli
//
//  Created by David Valencia on 08/11/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import Foundation
import UIKit

class Horarios: NSObject {
    
    var blocked = ""
    var error = ""
    
    override init(){
        super.init()
    }
    
    convenience init (withDay: String){
        self.init()
        self.blocked = withDay 
    }
    
    convenience init(dictionary: NSDictionary){
        self.init()
        

        self.blocked = dictionary["blocked_hours"] as? String ?? ""
        self.error = dictionary["error"] as? String ?? ""
    
        
    }
}




