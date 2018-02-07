//
//  GlobalConstants.swift
//  Deli
//
//  Created by David Valencia on 05/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import Foundation
import UIKit

// Ancho y alto de la pantalla
let wScreen = UIScreen.main.bounds.width
let hScreen = UIScreen.main.bounds.height

// Color de los botones toIn y toUp
let toSignColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
let bgTipoComida = UIColor(red: 38.00/255, green: 40.00/255, blue: 52.00/255, alpha: 1.00)

// Llaves para userDefaults
let kIsFirstEntry = "kIsFirstEntry"

// Token de usuario
var userToken: String = ""

// Imagen de usuario
var userAvatar: NSData = UIImagePNGRepresentation(#imageLiteral(resourceName: "user-foto"))! as NSData

// Nombre y correo electrónico del usuario
var nombreUsuario = ""
var mailUsuario = ""

// Variables utilizadas para customizar el header de las tarjetas
var currentSelection = 1
var tarjetaActiva = 0

// Puntos a la izquierda de el origen en x de la pantalla
var currentOffset = 0.0

// Color de Fondo Pantallas de Pagos
let bgPagos = UIColor(red: 40/255, green: 39/255, blue: 45/255, alpha: 1)

// Color de fondo de label de Hoy
let purpleBG = UIColor(red: 107/255, green: 110/255, blue: 233/255, alpha: 1)

// Gris fecha
let dateGray = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)

// Color de lastText
let lastGray = UIColor(red: 137/255, green: 139/255, blue: 165/255, alpha: 1)

// Color morado de barra de progreso
let purpleProgress = UIColor(red: 105/255, green: 113/255, blue: 231/255, alpha: 1)

// Color gris de frase final
let grayFrase = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)

// Colores gris y verde de celdas de horarios
let grayCell = UIColor(red: 74/255, green: 71/255, blue: 87/255, alpha: 1)
let greenCell = UIColor(red: 178/255, green: 188/255, blue: 225/255, alpha: 1)

// Colores de header y paging menu de experiencias
let headColor1 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)

// Colores de los textos de las grids de experiencias
let categoryColor = UIColor(red: 142/255, green: 138/255, blue: 114/255, alpha: 1)
let nameColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
let zoneColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
