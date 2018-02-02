//
//  NewsModel.swift
//  Noticias
//
//  Created by David Valencia on 22/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import Foundation
import UIKit

class NewsModel: NSObject {
    
    var nombre: String? = ""
    var categoria: String? = ""
    var imagen_autor: String? = ""
    var autor: String? = ""
    var subtitulo: String? = ""
    var fecha: String? = ""
    var introduccion: String? = ""
    var encabezado: String? = ""
    var parrafo1: String? = ""
    var parrafo2: String? = ""
    var parrafo3: String? = ""
    var parrafo4: String? = ""
    var logo: String? = ""
    var imagen_principal = ""
    var link_video: String? = ""
    var imagenSegundaria1: String? = ""
    var imagenSecundaria2: String? = ""
    var imagenSecundaria3: String? = ""
    var imgSecundariaDesc1: String? = ""
    var imgSecundariaDesc2: String? = ""
    var imgSecundariaDesc3: String? = ""
    var frase: String? = ""
    var editorial: String? = ""
    var logoEditorial: String? = ""
    var sugeridos: String? = ""
    
    override init() {
        super.init()
    }
    
    convenience init(dictionary: NSDictionary) {
        self.init()
        
        self.nombre = dictionary["name"] as? String ?? ""
        self.categoria = dictionary["categoria"] as? String ?? ""
        self.imagen_autor = dictionary["img_autor"] as? String ?? ""
        self.autor = dictionary["autor"] as? String ?? ""
        self.subtitulo = dictionary["subtitulo"] as? String ?? ""
        self.fecha = dictionary["fecha"] as? String ?? ""
        self.introduccion = dictionary["introduccion"] as? String ?? ""
        self.encabezado = dictionary["encabezado"] as? String ?? ""
        self.parrafo1 = dictionary["p1"] as? String ?? ""
        self.parrafo2 = dictionary["p2"] as? String ?? ""
        self.parrafo3 = dictionary["p3"] as? String ?? ""
        self.parrafo4 = dictionary["p4"] as? String ?? ""
        self.logo = dictionary["logo"] as? String ?? ""
        self.imagen_principal = dictionary["img_p"] as? String ?? ""
        self.link_video = dictionary["video"] as? String ?? ""
        self.imagenSegundaria1 = dictionary["img_sec1"] as? String ?? ""
        self.imagenSecundaria2 = dictionary["img_sec2"] as? String ?? ""
        self.imagenSecundaria3 = dictionary["img_sec3"] as? String ?? ""
        self.imgSecundariaDesc1 = dictionary["desc_img_sec1"] as? String ?? ""
        self.imgSecundariaDesc2 = dictionary["desc_img_sec2"] as? String ?? ""
        self.imgSecundariaDesc3 = dictionary["desc_img_sec3"] as? String ?? ""
        self.frase = dictionary["frase"] as? String ?? ""
        self.editorial = dictionary["editorial"] as? String ?? ""
        self.logoEditorial = dictionary["logo_editorial"] as? String ?? ""
        self.sugeridos = dictionary["sugeridos"] as? String ?? ""
    }
}
