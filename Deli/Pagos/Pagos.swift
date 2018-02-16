//
//  Pagos.swift
//  PagosNew
//
//  Created by David Valencia on 19/12/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit

class Pagos: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /*Preloader News*/
    var count: Int = 0
    var counting: Bool = false
    var timer: Timer = Timer()
    var centinela: Int = 0
    var metaSpin: MetaSpin?
    /*Preloader News*/
    
    // Vistas de pagos
    var pagos1: UIView?
    var pagos2: UIView?
    var pagos3: UIView?
    var pagos4: UIView?
    // Vistas de pagos
    
    // Variables generales del controlador
    var botContainer: UIView?
    var botPurple: UIView?
    var seleccionaL: UILabel?
    var fraseL: UILabel?
    var nextImg1: UIImageView?
    var nextImg2: UIImageView?
    var nextImg3: UIImageView?
    var nextBtn1: UIButton?
    var nextBtn2: UIButton?
    var nextBtn3: UIButton?
    var rest2: Restaurant?
    var dia0: Int = 0
    var dataSource = [Horarios]()
    var horario: Horarios?
    var blockedHrs = [String]()
    var mesActual: String?
    var verCodigo: UILabel?
    var verPendiente: UILabel?
    var goCodigos: UIButton?
    
    let Domingo = 0
    let Lunes = 1
    let Martes = 2
    let Miercoles = 3
    let Jueves = 4
    let Viernes = 5
    let Sabado = 6
    
    var rest3: Restaurant?
    var dia: Int?    
    var horario2: Horarios?
    // Variables generales del controlador
    
    // Variables de pagos1
    var backBtn: UIButton?
    var avatarPagos: UIImageView?
    var titleLabel1: UILabel?
    var subLabel1: UILabel?
    var fechaBG: UIImageView?
    var fecha1: UILabel?
    var dates: [Date] = [Date]()
    var picker: UIPickerView?
    var lastText: UILabel?
    // Variables de pagos1
    
    // Variables de pagos2
    var backBtn2: UIButton?
    var avatarPagos2: UIImageView?
    var titleLabel2: UILabel?
    var subLabel2: UILabel?
    var fechaBG2: UIImageView?
    var fecha2: UILabel?
    var horas = [String]()
    var blocked = [String]()
    var tablaHorarios: UICollectionView?
    var horaSelected: String?
    // Variables de pagos2
    
    // Variables de pagos3
    var backBtn3: UIButton?
    var avatarPagos3: UIImageView?
    var titleLabel3: UILabel?
    var subLabel3: UILabel?
    var fechaBG3: UIImageView?
    var fecha3: UILabel?
    var imgCarrito: UIImageView?
    // Variables de pagos3
    
    // Variables de pagos4
    var backBtn4: UIButton?
    var avatarPagos4: UIImageView?
    var titleLabel4: UILabel?
    var subLabel4: UILabel?
    var fechaBG4: UIImageView?
    var fecha4: UILabel?
    // Variables de pagos4
    
    // Info de compra
    var place: String?
    var concept: String?
    var dateC: String?
    var horaReserva: String?
    var tolerance: String?
    var zone: String?
    var price: String?
    var diaReserva: String = ""
    var hReservaDesc: UILabel?
    var myDay: String = ""
    // Info de compra

    override func viewDidLoad() {
        super.viewDidLoad()
        
        horas = ["0", "1", "2", "3", "4", "5","6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

        loadInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Ocultando navigationBar del sistema
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Implementación de userDefaults para cargar imagen de usuario
        if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarPagos?.image = UIImage(data: userAvatar as Data)
            avatarPagos2?.image = UIImage(data: userAvatar as Data)
            avatarPagos3?.image = UIImage(data: userAvatar as Data)
            avatarPagos4?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarPagos?.image = #imageLiteral(resourceName: "user-foto")
            avatarPagos2?.image = #imageLiteral(resourceName: "user-foto")
            avatarPagos3?.image = #imageLiteral(resourceName: "user-foto")
            avatarPagos4?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Ocultando navigationBar del sistema
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Implementación de userDefaults para cargar imagen de usuario
        if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarPagos?.image = UIImage(data: userAvatar as Data)
            avatarPagos2?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarPagos?.image = #imageLiteral(resourceName: "user-foto")
            avatarPagos2?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    func loadInterface() {
        
        // Obteniendo los componentes de la fecha actual
        let currentDate = Date()
        let calendar = Calendar.current

        myDay = String(calendar.component(.day, from: currentDate))
        let year = String(calendar.component(.year, from: currentDate))
        let month = calendar.component(.month, from: currentDate)
        let day = String(calendar.component(.day, from: currentDate))
        
        switch month {
        case 1:
            mesActual = "Enero"
        case 2:
            mesActual = "Febrero"
        case 3:
            mesActual = "Marzo"
        case 4:
            mesActual = "Abril"
        case 5:
            mesActual = "Mayo"
        case 6:
            mesActual = "Junio"
        case 7:
            mesActual = "Julio"
        case 8:
            mesActual = "Agosto"
        case 9:
            mesActual = "Septiembre"
        case 10:
            mesActual = "Octubre"
        case 11:
            mesActual = "Noviembre"
        default:
            mesActual = "Diciembre"
        }
        
        print(year)
        print(month)
        print(day)
        
        // Color de fondo de la vista
        view.backgroundColor = .white
        let backgroundScreen = UIImageView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88))
        backgroundScreen.image = #imageLiteral(resourceName: "pagos-fon")
        view.addSubview(backgroundScreen)
        
        // Vista de pagos1
        pagos1 = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos1?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(pagos1!)
        
        backBtn = UIButton(type: .custom)
        backBtn?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn?.tag = 1
        backBtn?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos1?.addSubview(backBtn!)
        
        avatarPagos = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.13, width: wScreen * 0.13, height: wScreen * 0.13))
        avatarPagos?.layer.masksToBounds = true
        avatarPagos?.layer.cornerRadius = avatarPagos!.frame.width/2
        pagos1?.addSubview(avatarPagos!)
        
        titleLabel1 = UILabel(frame: CGRect(x: avatarPagos!.frame.maxX + wScreen * 0.02, y: hScreen * 0.135, width: wScreen * 0.3, height: wScreen * 0.06))
        titleLabel1?.text = "Elige el día"
        titleLabel1?.font = UIFont(name: "Roboto-Black", size: 17.5)
        titleLabel1?.textColor = UIColor.white
        pagos1?.addSubview(titleLabel1!)
        
        subLabel1 = UILabel(frame: CGRect(x: avatarPagos!.frame.maxX + wScreen * 0.02, y: titleLabel1!.frame.maxY, width: wScreen * 0.3, height: wScreen * 0.05))
        subLabel1?.text = "de tu visita"
        subLabel1?.font = UIFont(name: "HelveticaNeue", size: 12)
        subLabel1?.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        pagos1?.addSubview(subLabel1!)
        
        fechaBG = UIImageView(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fechaBG?.image = #imageLiteral(resourceName: "pagos-label")
        pagos1?.addSubview(fechaBG!)
        
        fecha1 = UILabel(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fecha1?.text = day + " de " + mesActual!
        fecha1?.textAlignment = .center
        fecha1?.font = UIFont(name: "Roboto-Medium", size: 11.5)
        fecha1?.textColor = UIColor.white
        pagos1?.addSubview(fecha1!)
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var days = [Int]()
        
        var primeraVez = true
        
        for _ in 1 ... 100 {
            let day = cal.component(.day, from: date)
            days.append(day)
            
            
            if primeraVez{
                dates.append(date)
                primeraVez = false
            } else {
                date = cal.date(byAdding: .day, value: 1, to: date)!
                dates.append(date)
            }
        }
        
        picker = UIPickerView(frame: CGRect(x: 0, y: avatarPagos!.frame.maxY + hScreen * 0.1, width: wScreen, height: hScreen * 0.3))
        picker?.tintColor = UIColor.white
        picker?.dataSource = self
        picker?.delegate = self
        pagos1?.addSubview(picker!)
        
        lastText = UILabel(frame: CGRect(x: wScreen * 0.125, y: picker!.frame.maxY + hScreen * 0.13, width: wScreen * 0.75, height: hScreen * 0.08))
        lastText?.text = "Selecciona tu día y horario de tu visita. Promoción válida para un comensal por mesa."
        lastText?.numberOfLines = 2
        lastText?.textAlignment = .left
        lastText?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        lastText?.textColor = lastGray
        pagos1?.addSubview(lastText!)
        // Vista de pagos1
        
        // Vista de pagos2
        pagos2 = UIView(frame: CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos2?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(pagos2!)
        
        backBtn2 = UIButton(type: .custom)
        backBtn2?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn2?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn2?.tag = 2
        backBtn2?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos2?.addSubview(backBtn2!)
        
        avatarPagos2 = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.13, width: wScreen * 0.13, height: wScreen * 0.13))
        avatarPagos2?.layer.masksToBounds = true
        avatarPagos2?.layer.cornerRadius = avatarPagos2!.frame.width/2
        pagos2?.addSubview(avatarPagos2!)
        
        titleLabel2 = UILabel(frame: CGRect(x: avatarPagos2!.frame.maxX + wScreen * 0.02, y: hScreen * 0.135, width: wScreen * 0.3, height: wScreen * 0.06))
        titleLabel2?.text = "Elige el horario"
        titleLabel2?.font = UIFont(name: "Roboto-Black", size: 17.5)
        titleLabel2?.textColor = UIColor.white
        pagos2?.addSubview(titleLabel2!)
        
        subLabel2 = UILabel(frame: CGRect(x: avatarPagos2!.frame.maxX + wScreen * 0.02, y: titleLabel2!.frame.maxY, width: wScreen * 0.3, height: wScreen * 0.05))
        subLabel2?.text = "de tu visita"
        subLabel2?.font = UIFont(name: "HelveticaNeue", size: 12)
        subLabel2?.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        pagos2?.addSubview(subLabel2!)
        
        fechaBG2 = UIImageView(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fechaBG2?.image = #imageLiteral(resourceName: "pagos-label")
        pagos2?.addSubview(fechaBG2!)
        
        fecha2 = UILabel(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fecha2?.text = day + " de " + mesActual!
        fecha2?.textAlignment = .center
        fecha2?.font = UIFont(name: "Roboto-Medium", size: 11.5)
        fecha2?.textColor = UIColor.white
        pagos2?.addSubview(fecha2!)
        
        tablaHorarios = UICollectionView(frame: CGRect(x: wScreen * 0.05, y: avatarPagos2!.frame.maxY + hScreen * 0.07, width: wScreen * 0.9, height: hScreen * 0.5), collectionViewLayout: UICollectionViewFlowLayout())
        tablaHorarios?.backgroundColor = UIColor.white.withAlphaComponent(0)
        tablaHorarios?.register(ContentPagos.self, forCellWithReuseIdentifier: "hourCell")
        tablaHorarios?.dataSource = self
        tablaHorarios?.delegate = self
        pagos2?.addSubview(tablaHorarios!)
        // Vista de pagos2
        
        // Vista de pagos3
        pagos3 = UIView(frame: CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos3?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(pagos3!)
        
        backBtn3 = UIButton(type: .custom)
        backBtn3?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn3?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn3?.tag = 3
        backBtn3?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos3?.addSubview(backBtn3!)
        
        avatarPagos3 = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.13, width: wScreen * 0.13, height: wScreen * 0.13))
        avatarPagos3?.layer.masksToBounds = true
        avatarPagos3?.layer.cornerRadius = avatarPagos3!.frame.width/2
        pagos3?.addSubview(avatarPagos3!)
        
        titleLabel3 = UILabel(frame: CGRect(x: avatarPagos3!.frame.maxX + wScreen * 0.02, y: hScreen * 0.135, width: wScreen * 0.3, height: wScreen * 0.06))
        titleLabel3?.text = "Confirmar"
        titleLabel3?.font = UIFont(name: "Roboto-Black", size: 17.5)
        titleLabel3?.textColor = UIColor.white
        pagos3?.addSubview(titleLabel3!)
        
        subLabel3 = UILabel(frame: CGRect(x: avatarPagos3!.frame.maxX + wScreen * 0.02, y: titleLabel3!.frame.maxY, width: wScreen * 0.3, height: wScreen * 0.05))
        subLabel3?.text = "día y horario"
        subLabel3?.font = UIFont(name: "HelveticaNeue", size: 12)
        subLabel3?.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        pagos3?.addSubview(subLabel3!)
        
        fechaBG3 = UIImageView(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fechaBG3?.image = #imageLiteral(resourceName: "pagos-label")
        pagos3?.addSubview(fechaBG3!)
        
        fecha3 = UILabel(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fecha3?.text = day + " de " + mesActual!
        fecha3?.textAlignment = .center
        fecha3?.font = UIFont(name: "Roboto-Medium", size: 11.5)
        fecha3?.textColor = UIColor.white
        pagos3?.addSubview(fecha3!)
        
        let imgPrice = UIImageView(frame: CGRect(x: wScreen * 0.125, y: avatarPagos3!.frame.maxY + hScreen * 0.05, width: wScreen * 0.75, height: hScreen * 0.1))
        imgPrice.image = #imageLiteral(resourceName: "precioFake")
        pagos3?.addSubview(imgPrice)
        
        let realPrice = UILabel(frame: CGRect(x: wScreen * 0.125, y: avatarPagos3!.frame.maxY + hScreen * 0.05, width: wScreen * 0.75, height: hScreen * 0.1))
        realPrice.text = price! + " mxn"
        realPrice.font = UIFont(name: "Montserrat-Bold", size: 29)
        realPrice.textAlignment = .center
        realPrice.textColor = UIColor.white
        pagos3?.addSubview(realPrice)

        let line = UIImageView(frame: CGRect(x: wScreen * 0.125, y: imgPrice.frame.maxY + hScreen * 0.035, width: wScreen * 0.75, height: hScreen * 0.048))
        line.image = #imageLiteral(resourceName: "pagosBox")
        pagos3!.addSubview(line)
        
        let changeMethod = UIButton(type: .custom)
        changeMethod.frame = CGRect(x: wScreen * 0.125, y: line.frame.maxY + hScreen * 0.05, width: wScreen * 0.75, height: hScreen * 0.088)
        changeMethod.setImage(#imageLiteral(resourceName: "changeMethodBtn"), for: .normal)
        pagos3?.addSubview(changeMethod)
        
        let lugar = UILabel(frame: CGRect(x: wScreen * 0.06, y: changeMethod.frame.maxY + hScreen * 0.05, width: wScreen * 0.4, height: hScreen * 0.03))
        lugar.text = "LUGAR"
        lugar.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        lugar.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(lugar)
        
        let lugarDesc = UILabel(frame: CGRect(x: wScreen * 0.06, y: lugar.frame.maxY, width: wScreen * 0.4, height: hScreen * 0.05))
        lugarDesc.text = place
        lugarDesc.numberOfLines = 2
        lugarDesc.textColor = UIColor.white
        lugarDesc.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(lugarDesc)
        
        let concepto = UILabel(frame: CGRect(x: lugar.frame.maxX + wScreen * 0.05, y: changeMethod.frame.maxY + hScreen * 0.05, width: wScreen * 0.2, height: hScreen * 0.03))
        concepto.text = "CONCEPTO"
        concepto.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        concepto.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(concepto)
        
        let conceptoDesc = UILabel(frame: CGRect(x: lugar.frame.maxX + wScreen * 0.05, y: concepto.frame.maxY, width: wScreen * 0.2, height: hScreen * 0.05))
        conceptoDesc.text = concept! + " Experiencias"
        conceptoDesc.numberOfLines = 2
        conceptoDesc.textColor = UIColor.white
        conceptoDesc.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(conceptoDesc)
        
        let fechaP = UILabel(frame: CGRect(x: concepto.frame.maxX + wScreen * 0.05, y: changeMethod.frame.maxY + hScreen * 0.05, width: wScreen * 0.18, height: hScreen * 0.03))
        fechaP.text = "FECHA"
        fechaP.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        fechaP.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(fechaP)
        
        let fechaDesc = UILabel(frame: CGRect(x: concepto.frame.maxX + wScreen * 0.05, y: fechaP.frame.maxY, width: wScreen * 0.15, height: hScreen * 0.05))
        
        switch month {
        case 1:
            fechaDesc.text = "Enero" + " " + year
        case 2:
            fechaDesc.text = "Febrero" + " " + year
        case 3:
            fechaDesc.text = "Marzo" + " " + year
        case 4:
            fechaDesc.text = "Abril" + " " + year
        case 5:
            fechaDesc.text = "Mayo" + " " + year
        case 6:
            fechaDesc.text = "Junio" + " " + year
        case 7:
            fechaDesc.text = "Julio" + " " + year
        case 8:
            fechaDesc.text = "Agosto" + " " + year
        case 9:
            fechaDesc.text = "Septiembre" + " " + year
        case 10:
            fechaDesc.text = "Octubre" + " " + year
        case 11:
            fechaDesc.text = "Noviembre" + " " + year
        default:
            fechaDesc.text = "Diciembre" + " " + year
        }
        fechaDesc.numberOfLines = 2
        fechaDesc.textColor = UIColor.white
        fechaDesc.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(fechaDesc)
        
        let blackLine = UIView(frame: CGRect(x: wScreen * 0.06, y: lugarDesc.frame.maxY + hScreen * 0.01, width: wScreen * 0.88, height: 1))
        blackLine.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 35/255, alpha: 1)
        pagos3?.addSubview(blackLine)
        
        let hReserva = UILabel(frame: CGRect(x: wScreen * 0.06, y: blackLine.frame.maxY + hScreen * 0.01, width: wScreen * 0.4, height: hScreen * 0.03))
        hReserva.text = "HORARIO DE RESERVA"
        hReserva.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        hReserva.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(hReserva)
        
        hReservaDesc = UILabel(frame: CGRect(x: wScreen * 0.06, y: hReserva.frame.maxY, width: wScreen * 0.4, height: hScreen * 0.025))
        hReservaDesc?.text = diaReserva +  " " + myDay + ", " /*+ horaSelected!*/
        hReservaDesc?.numberOfLines = 2
        hReservaDesc?.textColor = UIColor.white
        hReservaDesc?.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(hReservaDesc!)
        
        let tolerancia = UILabel(frame: CGRect(x: hReserva.frame.maxX + wScreen * 0.05, y: blackLine.frame.maxY + hScreen * 0.01, width: wScreen * 0.2, height: hScreen * 0.03))
        tolerancia.text = "TOLERANCIA"
        tolerancia.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        tolerancia.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(tolerancia)
        
        let toleranciaDesc = UILabel(frame: CGRect(x: hReserva.frame.maxX + wScreen * 0.05, y: tolerancia.frame.maxY, width: wScreen * 0.2, height: hScreen * 0.025))
        toleranciaDesc.text = tolerance! + " horas"
        toleranciaDesc.numberOfLines = 2
        toleranciaDesc.textColor = UIColor.white
        toleranciaDesc.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(toleranciaDesc)
        
        let zona = UILabel(frame: CGRect(x: tolerancia.frame.maxX + wScreen * 0.05, y: blackLine.frame.maxY + hScreen * 0.01, width: wScreen * 0.18, height: hScreen * 0.03))
        zona.text = "ZONA"
        zona.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        zona.font = UIFont(name: "Montserrat-Regular", size: 10)
        pagos3?.addSubview(zona)
        
        let zonaDesc = UILabel(frame: CGRect(x: tolerancia.frame.maxX + wScreen * 0.05, y: zona.frame.maxY, width: wScreen * 0.15, height: hScreen * 0.025))
        zonaDesc.text = zone
        zonaDesc.numberOfLines = 2
        zonaDesc.textColor = UIColor.white
        zonaDesc.font = UIFont(name: "Roboto-Regular", size: 13)
        pagos3?.addSubview(zonaDesc)
        // Vista de pagos3
        
        // Vista de pagos4
        pagos4 = UIView(frame: CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos4?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(pagos4!)
        
        backBtn4 = UIButton(type: .custom)
        backBtn4?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn4?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn4?.tag = 4
        backBtn4?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos4?.addSubview(backBtn4!)
        
        avatarPagos4 = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.13, width: wScreen * 0.13, height: wScreen * 0.13))
        avatarPagos4?.layer.masksToBounds = true
        avatarPagos4?.layer.cornerRadius = avatarPagos4!.frame.width/2
        pagos4?.addSubview(avatarPagos4!)
        
        titleLabel4 = UILabel(frame: CGRect(x: avatarPagos4!.frame.maxX + wScreen * 0.02, y: hScreen * 0.135, width: wScreen * 0.3, height: wScreen * 0.06))
        titleLabel4?.text = "Confirmado!"
        titleLabel4?.font = UIFont(name: "Roboto-Black", size: 17.5)
        titleLabel4?.textColor = UIColor.white
        pagos4?.addSubview(titleLabel4!)
        
        subLabel4 = UILabel(frame: CGRect(x: avatarPagos4!.frame.maxX + wScreen * 0.02, y: titleLabel4!.frame.maxY, width: wScreen * 0.3, height: wScreen * 0.05))
        subLabel4?.text = "con éxito..."
        subLabel4?.font = UIFont(name: "HelveticaNeue", size: 12)
        subLabel4?.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        pagos4?.addSubview(subLabel4!)
        
        fechaBG4 = UIImageView(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fechaBG4?.image = #imageLiteral(resourceName: "pagos-label")
        pagos4?.addSubview(fechaBG4!)
        
        fecha4 = UILabel(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.142, width: wScreen * 0.28, height: wScreen * 0.085))
        fecha4?.text = day + " de " + mesActual!
        fecha4?.textAlignment = .center
        fecha4?.font = UIFont(name: "Roboto-Medium", size: 11.5)
        fecha4?.textColor = UIColor.white
        pagos4?.addSubview(fecha4!)
        
        /*Preloader*/
        metaSpin = MetaSpin(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        metaSpin?.center = view.center
        metaSpin?.ballFillColor = UIColor.white
        metaSpin?.centralBallRadius = 50.0
        metaSpin?.sideBallRadius = 7.0
        metaSpin?.speed = 0.02
        
        
        let gracias = UILabel(frame: CGRect(x: wScreen * 0.3, y: hScreen * 0.7, width: wScreen * 0.4, height: hScreen * 0.1))
        gracias.text = "Muchas gracias por tu preferencia!"
        gracias.font = UIFont(name: "Roboto-Bold", size: 15)
        gracias.textColor = .white
        gracias.textAlignment = .center
        gracias.numberOfLines = 2
//        pagos4?.addSubview(gracias)
        
        let endPagos = UIButton(type: .custom)
        endPagos.setImage(#imageLiteral(resourceName: "endPagosImg"), for: .normal)
        endPagos.frame = CGRect(x: wScreen * 0.15, y: hScreen * 0.7, width: wScreen * 0.7, height: hScreen * 0.08)
        endPagos.addTarget(self, action: #selector(closePagos), for: .touchUpInside)
        pagos4?.addSubview(endPagos)
        // Vista de pagos4
        
        botPurple = UIView(frame: CGRect(x: wScreen - wScreen * 0.025, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12))
        botPurple?.backgroundColor = purpleProgress
        view.addSubview(botPurple!)
        
        botContainer = UIView(frame: CGRect(x: 0, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12))
        botContainer?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(botContainer!)
        
        seleccionaL = UILabel(frame: CGRect(x: wScreen * 0.06, y: botContainer!.frame.height/2 - (hScreen * 0.05/2), width: wScreen * 0.25, height: hScreen * 0.05))
        seleccionaL?.text = "Selecciona"
        seleccionaL?.textColor = .black
        seleccionaL?.font = UIFont(name: "Roboto-Bold", size: 16)
        botContainer?.addSubview(seleccionaL!)
        
        fraseL = UILabel(frame: CGRect(x: seleccionaL!.frame.maxX + wScreen * 0.05, y: botContainer!.frame.height/2 - (hScreen * 0.05/2), width: wScreen * 0.5, height: hScreen * 0.05))
        fraseL?.text = "el día de tu visita"
        fraseL?.textColor = grayFrase
        fraseL?.font = UIFont(name: "Roboto-Bold", size: 16)
        botContainer?.addSubview(fraseL!)
        
        verCodigo = UILabel(frame: CGRect(x: botContainer!.frame.width * 0.1, y: 0, width: botContainer!.frame.width * 0.4, height: botContainer!.frame.height))
        verCodigo?.text = "Ver código de reserva"
        verCodigo?.textAlignment = .center
        verCodigo?.textColor = UIColor.white
        verCodigo?.font = UIFont(name: "Roboto-Black", size: 16.5)
        verCodigo?.alpha = 0
        botContainer?.addSubview(verCodigo!)
        
        verPendiente = UILabel(frame: CGRect(x: verCodigo!.frame.maxX, y: 0, width: botContainer!.frame.width * 0.4, height: botContainer!.frame.height))
        verPendiente?.text = "pendiente de activar"
        verPendiente?.textAlignment = .center
        verPendiente?.textColor = UIColor(red: 74/255, green: 80/255, blue: 157/255, alpha: 1)
        verPendiente?.font = UIFont(name: "Roboto-Bold", size: 14)
        verPendiente?.alpha = 0
        botContainer?.addSubview(verPendiente!)
        
        nextImg1 = UIImageView(frame: CGRect(x: wScreen - wScreen * 0.09, y: botContainer!.frame.height/2 - (wScreen * 0.05/2), width: wScreen * 0.031, height: wScreen * 0.05))
        nextImg1?.image = #imageLiteral(resourceName: "nextInPagos2")
        botContainer?.addSubview(nextImg1!)
        
        nextBtn1 = UIButton(type: .system)
        nextBtn1?.frame = CGRect(x: 0, y: 0, width: botContainer!.frame.width, height: botContainer!.frame.height)
        nextBtn1?.tag = 1
        nextBtn1?.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        botContainer?.addSubview(nextBtn1!)
        
        nextImg2 = UIImageView(frame: CGRect(x: wScreen - wScreen * 0.09, y: botContainer!.frame.height/2 - (wScreen * 0.05/2), width: wScreen * 0.031, height: wScreen * 0.05))
        nextImg2?.image = #imageLiteral(resourceName: "nextInPagos")
        nextImg2?.alpha = 0
        botContainer?.addSubview(nextImg2!)
        
        nextBtn2 = UIButton(type: .system)
        nextBtn2?.frame = CGRect(x: 0, y: 0, width: botContainer!.frame.width, height: botContainer!.frame.height)
        nextBtn2?.tag = 2
        nextBtn2?.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        nextBtn2?.alpha = 0
        botContainer?.addSubview(nextBtn2!)
        
        imgCarrito = UIImageView(frame: CGRect(x: wScreen * 0.751, y: botContainer!.frame.height * 0.4, width: wScreen * 0.16, height: wScreen * 0.04))
        imgCarrito?.image = #imageLiteral(resourceName: "nextInPagos3.pdf")
        imgCarrito?.alpha = 0
        botContainer?.addSubview(imgCarrito!)
        
        nextBtn3 = UIButton(type: .custom)
        nextBtn3?.frame = CGRect(x: 0, y: 0, width: botContainer!.frame.width, height: botContainer!.frame.height)
        nextBtn3?.tintColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        nextBtn3?.tag = 3
        nextBtn3?.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        nextBtn3?.alpha = 0
        botContainer?.addSubview(nextBtn3!)
        
        goCodigos = UIButton(type: .system)
        goCodigos?.frame = CGRect(x: 0, y: 0, width: botContainer!.frame.width, height: botContainer!.frame.height)
        goCodigos?.addTarget(self, action: #selector(openCodigos), for: .touchUpInside)
        goCodigos?.alpha = 0
        botContainer?.addSubview(goCodigos!)
    }
    
    // Funciones propias
    /*Preloader*/
    @objc func counter() -> Void {
        
        count += 1;
        
        
        if(count == 3){
            
            self.timer.invalidate();
            
            
            
            let alert = UIAlertController(title: "Gracias!", message: "Disfruta lo mejor con Deli", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc func backPressed(sender: UIButton) {
        
        switch sender.tag {
            case 1:
                navigationController?.popViewController(animated: true)
            case 2:
                UIView.animate(withDuration: 0.5, animations: {
                    self.pagos1?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.pagos2?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.025, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                    self.nextImg2?.alpha = 0
                    self.nextBtn2?.alpha = 0
                    self.nextImg1?.alpha = 1
                    self.nextBtn1?.alpha = 1
                }, completion: { (true) in
                    
                })
            case 3:
                UIView.animate(withDuration: 0.5, animations: {
                    self.pagos2?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.pagos3?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.25, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                    self.seleccionaL?.text = "Selecciona"
                    self.fraseL?.text = "el horario de tu visita"
                    self.imgCarrito?.alpha = 0
                    self.nextBtn3?.alpha = 0
                    self.nextImg2?.alpha = 1
                    self.nextBtn2?.alpha = 1
                }, completion: { (true) in
                    
                })

        default:
            UIView.animate(withDuration: 0.5, animations: {
                self.pagos3?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                self.pagos4?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.35, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                self.imgCarrito?.alpha = 1
                self.nextBtn3?.alpha = 1
                self.verCodigo?.alpha = 0
                self.verPendiente?.alpha = 0
                self.goCodigos?.alpha = 0
                self.seleccionaL?.alpha = 1
                self.fraseL?.alpha = 1
            }, completion: { (true) in
                
            })
        }
    }
    
    @objc func nextPressed(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            getJsonFromUrl()
            self.nextBtn1?.alpha = 0
            self.nextImg1?.alpha = 0
            self.nextBtn2?.alpha = 1
            self.nextImg2?.alpha = 1

        case 2:
            UIView.animate(withDuration: 0.5, animations: {
                self.pagos2?.frame = CGRect(x: -wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                self.pagos3?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.35, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                self.seleccionaL?.text = "MXN $" + self.price!
                self.fraseL?.text = "total IVA incluido"
                self.nextBtn2?.alpha = 0
                self.nextImg2?.alpha = 0
                self.nextBtn3?.alpha = 1
                self.imgCarrito?.alpha = 1
            }, completion: { (true) in
                
            })
        default:
            UIView.animate(withDuration: 0.5, animations: {
                self.pagos3?.frame = CGRect(x: -wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                self.pagos4?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                self.botPurple?.frame = CGRect(x: 0, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                self.seleccionaL?.alpha = 0
                self.fraseL?.alpha = 0
                self.nextBtn2?.alpha = 0
                self.nextImg2?.alpha = 0
                self.nextBtn3?.alpha = 0
                self.imgCarrito?.alpha = 0
                self.verCodigo?.alpha = 1
                self.verPendiente?.alpha = 1
                self.goCodigos?.alpha = 1
                self.pagos4?.addSubview(self.metaSpin!)
                
                self.metaSpin?.animateSideBall()
                
                if self.counting {
                    self.timer.invalidate();
                    
                }else if !self.counting{
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
                    
                }
            }, completion: { (true) in
                
            })
        }
    }
    
    @objc func openCodigos() {
        
        navigationController?.pushViewController(CodeControllerFake(), animated: true)
    }
    
    @objc func closePagos() {
        
    }
    // Funciones propias
    
    // MARK: - Funciones de Protocolo UiCollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as! ContentPagos
    
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        if cell.isSelected {
            cell.backgroundColor = UIColor(red: 101/255, green: 118/255, blue: 229/255, alpha: 1)
            cell.layer.borderColor = UIColor(red: 240/255, green: 147/255, blue: 133/255, alpha: 1).cgColor
        } else {
            cell.backgroundColor = UIColor.white.withAlphaComponent(0)
            cell.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.5).cgColor
        }
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10.0
        
        cell.horasDelDia.frame = CGRect(x: cell.frame.width * 0.1, y: cell.frame.height * 0.3, width: cell.frame.width * 0.8, height: cell.frame.height * 0.2)
        cell.horasDelDia.font = UIFont(name: "HelveticaNeue-Medium", size: 14.5)
        cell.horasDelDia.textAlignment = .center
        cell.horasDelDia.text = horas[indexPath.row] + ":00 hrs."
        cell.horasDelDia.textColor = .white
        cell.contentView.addSubview(cell.horasDelDia)
        
        
        
        for _ in horas {
            
            if blocked.contains(horas[indexPath.row]) {
                cell.disponible.frame = CGRect(x: cell.frame.width * 0.1, y: cell.horasDelDia.frame.maxY + 5, width: cell.frame.width * 0.8, height: cell.frame.height * 0.2)
                cell.disponible.font = UIFont(name: "Roboto-Bold", size: 13)
                cell.disponible.textAlignment = .center
                cell.disponible.textColor = grayCell
                cell.disponible.text = "Agotado"
                cell.contentView.addSubview(cell.disponible)
            } else {
                cell.disponible.frame = CGRect(x: cell.frame.width * 0.1, y: cell.horasDelDia.frame.maxY + 5, width: cell.frame.width * 0.8, height: cell.frame.height * 0.2)
                cell.disponible.font = UIFont(name: "Roboto-Bold", size: 12)
                cell.disponible.textAlignment = .center
                cell.disponible.textColor = greenCell
                cell.disponible.text = "Disponible"
                cell.contentView.addSubview(cell.disponible)
            }
            
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 110
        
        return CGSize(width: cellWidth, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if blocked.contains(horas[indexPath.row]) {
                print("No puedes seleccionar el horario")
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white.withAlphaComponent(0)
                collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.5).cgColor

                // Alerta de horario agotado
                let alert = UIAlertController(title: "Lo sentimos!", message: "El horario seleccionado no está disponible", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in

                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion:nil)
            } else {
                print("El horario está disponible")
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 101/255, green: 118/255, blue: 229/255, alpha: 1)
                collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor(red: 240/255, green: 147/255, blue: 133/255, alpha: 1).cgColor
            }
        
        horaSelected = horas[indexPath.row] + ":00 hrs."
        
        hReservaDesc?.text = diaReserva +  " " + myDay + ", " + horaSelected!
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white.withAlphaComponent(0)
        collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.5).cgColor

    }
    // MARK: - Funciones de Protocolo UiCollectionView
    
    // MARK: - Funciones de Protocolo UIPickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let dateSelected = DateFormatter()
        dateSelected.dateFormat = "EEEE"
        let selectedString = dateSelected.string(from: dates[row])
        
        let dateSelectedNumber = DateFormatter()
        dateSelectedNumber.dateFormat = "dd"
        let numberSelected = dateSelectedNumber.string(for: dates[row])
        myDay = numberSelected!
        
        if(selectedString == "Monday") {

            dia0 = Lunes
            diaReserva = "Lunes"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Lunes)
            print(diaReserva)
        }else if(selectedString == "Tuesday") {

            dia0 = Martes
            diaReserva = "Martes"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Martes)
            print(diaReserva)
        }else if(selectedString == "Wednesday") {

            dia0 = Miercoles
            diaReserva = "Miércoles"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Miercoles)
            print(diaReserva)
        }else if(selectedString == "Thursday") {

            dia0 = Jueves
            diaReserva = "Jueves"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Jueves)
            print(diaReserva)
        }else if(selectedString == "Friday") {

            dia0 = Viernes
            diaReserva = "Viernes"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Viernes)
            print(diaReserva)
        }else if(selectedString == "Saturday") {

            dia0 = Sabado
            diaReserva = "Sábado"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Sabado)
            print(diaReserva)
        }else if(selectedString == "Sunday") {

            dia0 = Domingo
            diaReserva = "Domingo"
            hReservaDesc?.text = diaReserva +  " " + myDay + ", "
            print(Domingo)
            print(diaReserva)
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "EEEE dd MMM"
        dateformatter.locale = Locale(identifier: "es_MX")
        
        let dateString = dateformatter.string(from: dates[row])
        
        
        return dateString
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "EEEE dd MMM"
        dateformatter.locale = Locale(identifier: "es_MX")
        
        let dateString = dateformatter.string(from: dates[row])
        
        let attributeDate = NSAttributedString(string: dateString, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        return attributeDate
    }
    // MARK: - Funciones de Protocolo UIPickerView
    
    //Petición a webservice
    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: "http://104.236.10.17/api/restaurantes/" + (rest2?.id_restaurante)! + "/schedule/" + String(dia0))
        
        print(url ?? "")
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                
                
                //getting the avengers tag array from json and converting it to NSArray
                if let bloqueados = jsonObj!.value(forKey: "blocked_hours") as? [String] {
                    //looping through all the elements
                    
                    for hora in bloqueados{
                        
                        let horario = Horarios(withDay: hora)
                        self.dataSource.append(horario)
                        
                        
                    }
                    
                    self.blockedHrs = bloqueados
                    print(self.blockedHrs)
                    
                }
                
                var mensajeError: String?
                
                if let error = jsonObj!.value(forKey: "error") as? String {
                    
                    mensajeError = error
                    print(error)
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    //print(jsonObj as Any)
                    
                    if(mensajeError != nil) {
                        
                        let alert = UIAlertController(title: "Lo sentimos!", message: mensajeError, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                            
                            UIView.animate(withDuration: 0.5, animations: {
                                self.pagos1?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                                self.pagos2?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                                self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.025, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                                self.nextImg2?.alpha = 0
                                self.nextBtn2?.alpha = 0
                                self.nextImg1?.alpha = 1
                                self.nextBtn1?.alpha = 1
                            })
                        }
                        
                        alert.addAction(okAction)
                        
                        self.present(alert, animated: true, completion:nil)
                    }else {
                        
//                        let view2 = Pago2()
                        self.rest3 = self.rest2
                        self.dia = self.dia0
                        self.horario2 = self.horario
                        self.blocked = self.blockedHrs
                        UIView.animate(withDuration: 0.5, animations: {
                            self.pagos1?.frame = CGRect(x: -wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                            self.pagos2?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                            self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.25, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                            self.fraseL?.text = "el horario de tu visita"
                            self.nextBtn1?.alpha = 0
                            self.nextBtn2?.alpha = 1
                        }) { (true) in
                            
                        }
                    }
                    
                })
            }
        }).resume()
    }
    //Petición a webservice

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Clase de CollectionViewCell
class ContentPagos: UICollectionViewCell {
    
    var horasDelDia = UILabel()
    var horasBloaqueadas = UILabel()
    var disponible = UILabel()
}
