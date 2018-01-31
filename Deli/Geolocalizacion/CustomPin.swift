//
//  CustomPin.swift
//  GoogleMaps1
//
//  Created by David Valencia on 21/12/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import Foundation
import GoogleMaps

class CustomPin: GMSMarker {
    
    var latitud: String?
    var longitud: String?
    var nombreRestaurante: String?
    var thumb: String?
    var idRestaurante: String?
    
    override init() {
        super.init()
        
    }
    
    convenience init(latitud: String, longitud: String, nombreRestaurante: String, thumb: String, idRestaurante: String) {
        
        self.init()
        
        self.latitud = latitud
        self.longitud = longitud
        self.nombreRestaurante = nombreRestaurante
        self.thumb = thumb
        self.idRestaurante = idRestaurante
        let pinCoordinate = CLLocationCoordinate2D(latitude: Double(latitud)!, longitude: Double(longitud)!)
        position = pinCoordinate
        icon = #imageLiteral(resourceName: "pin-map")
    }
}
