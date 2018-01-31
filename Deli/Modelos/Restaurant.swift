//
//  Restaurant.swift
//  PagingMenu
//
//  Created by David Valencia on 27/11/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import Foundation
import UIKit

class Restaurant: NSObject {
    
    var id_restaurante = "";
    var zona = "";
    var nombre = "";
    var incluye = "";
    var categoria = "";
    var imagen_principal = "";
    var direccion = "";
    var tipo_comida = "";
    var precio = "";
    var introduccion = "";
    var p1 = "";
    var p2 = "";
    var p3 = "";
    var logo = "";
    var link_video = "";
    var imagen2 = "";
    var imagen3 = "";
    var frase = "";
    var editorial = "";
    var logo_editorial = "";
    var coordenadas = "";
    var no_ordenes_deli = 0;
    var no_ordenes_adicionales = 0;
    var horario_disponible = "";
    var horario_restringido = "";
    var dias_no_disponibles = "";
    var img_price = "";
    var thumbnail = ""
    var tag = ""
    var nickname = ""
    var tolerancia = ""
    
    override init() {
        super.init()
    }
    
    convenience init(dictionary: NSDictionary){
        self.init()
        
        self.id_restaurante = dictionary["id_restaurant"] as? String ?? ""
        self.zona = dictionary["zona"] as? String ?? ""
        self.nombre = dictionary["name_restaurant"] as? String ?? ""
        self.incluye = dictionary["incluye"] as? String ?? ""
        self.categoria = dictionary["category"] as? String ?? ""
        self.imagen_principal = dictionary["imagen_principal"] as? String ?? ""
        self.direccion = dictionary["direccion"] as? String ?? ""
        self.tipo_comida = dictionary["tipo_comida"] as? String ?? ""
        self.precio = dictionary["precio"] as? String ?? ""
        self.introduccion = dictionary["introduccion"] as? String ?? ""
        self.p1 = dictionary["p1"] as? String ?? ""
        self.p2 = dictionary["p2"] as? String ?? ""
        self.p3 = dictionary["p3"] as? String ?? ""
        self.logo = dictionary["logo"] as? String ?? ""
        self.link_video = dictionary["link_video"] as? String ?? ""
        self.imagen2 = dictionary["imagen_2"] as? String ?? ""
        self.imagen3 = dictionary["imagen_3"] as? String ?? ""
        self.frase = dictionary["frase"] as? String ?? ""
        self.editorial = dictionary["editorial"] as? String ?? ""
        self.logo_editorial = dictionary["logo_editorial"] as? String ?? ""
        self.coordenadas = dictionary["coordenadas"] as? String ?? ""
        self.no_ordenes_deli = dictionary["no_ordenes_deli"] as? Int ?? 0
        self.no_ordenes_adicionales = dictionary["no_ordenes_adicionales"] as? Int ?? 0
        self.horario_disponible = dictionary["horario_disponible"] as? String ?? ""
        self.horario_restringido = dictionary["horario_restringido"] as? String ?? ""
        self.dias_no_disponibles = dictionary["dias_no_disponibles"] as? String ?? ""
        self.img_price = dictionary["img_price"] as? String ?? ""
        self.thumbnail = dictionary["thumbnail"] as? String ?? ""
        self.tag = dictionary["tag"] as? String ?? ""
        self.nickname = dictionary["nickname"] as? String ?? ""
        self.tolerancia = dictionary["tolerancia"] as? String ?? ""
    }
}

