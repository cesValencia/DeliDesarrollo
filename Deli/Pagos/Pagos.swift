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
    var nextBtn1: UIButton?
    var nextBtn2: UIButton?
    var nextBtn3: UIButton?
    var rest2: Restaurant?
    var dia0: Int = 0
    var dataSource = [Horarios]()
    var horario: Horarios?
    var blockedHrs = [String]()
    
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
    var calendarImg: UIImageView?
    var titleLabel: UILabel?
    var hoyLabel: UILabel?
    var fecha: UILabel?
    var dates: [Date] = [Date]()
    var picker: UIPickerView?
    var lastText: UILabel?
    // Variables de pagos1
    
    // Variables de pagos2
    var backBtn2: UIButton?
    var calendarImg2: UIImageView?
    var titleLabel2: UILabel?
    var hoyLabel2: UILabel?
    var fecha2: UILabel?
    var horas = [String]()
    var blocked = [String]()
    var tablaHorarios: UICollectionView?
    var horaSelected: String?
    // Variables de pagos2
    
    // Variables de pagos3
    var backBtn3: UIButton?
    var calendarImg3: UIImageView?
    var titleLabel3: UILabel?
    var hoyLabel3: UILabel?
    var fecha3: UILabel?
    var imgCarrito: UIImageView?
    // Variables de pagos3
    
    // Variables de pagos4
    var backBtn4: UIButton?
    var calendarImg4: UIImageView?
    var titleLabel4: UILabel?
    var hoyLabel4: UILabel?
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
    
    func loadInterface() {
        
        // Obteniendo los componentes de la fecha actual
        let currentDate = Date()
        let calendar = Calendar.current

        myDay = String(calendar.component(.day, from: currentDate))
        let year = String(calendar.component(.year, from: currentDate))
        let month = calendar.component(.month, from: currentDate)
//        let day = String(calendar.component(.day, from: currentDate))
        
        // Color de fondo de la vista
        view.backgroundColor = .white
        
        // Vista de pagos1
        pagos1 = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos1?.backgroundColor = bgPagos
        view.addSubview(pagos1!)
        
        backBtn = UIButton(type: .custom)
        backBtn?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn?.tag = 1
        backBtn?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos1?.addSubview(backBtn!)
        
        calendarImg = UIImageView(frame: CGRect(x: wScreen * 0.06, y: backBtn!.frame.maxY + hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.06))
        calendarImg?.image = #imageLiteral(resourceName: "miniCalendar")
        pagos1?.addSubview(calendarImg!)
        
        titleLabel = UILabel(frame: CGRect(x: calendarImg!.frame.maxX + wScreen * 0.03, y: backBtn!.frame.maxY + hScreen * 0.038, width: wScreen * 0.4, height: hScreen * 0.055))
        titleLabel?.text = "elige día"
        titleLabel?.font = UIFont(name: "Roboto-Bold", size: 33)
        titleLabel?.textColor = .white
        pagos1?.addSubview(titleLabel!)
        
        let backPurple = UIView(frame: CGRect(x: wScreen * 0.06, y: calendarImg!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        backPurple.backgroundColor = purpleBG
        backPurple.layer.cornerRadius = 5.0
        backPurple.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        backPurple.layer.shadowOpacity = 0.8
        backPurple.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        backPurple.layer.shadowRadius = 3.0
        pagos1?.addSubview(backPurple)
        
        hoyLabel = UILabel(frame: CGRect(x: wScreen * 0.06, y: calendarImg!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        hoyLabel?.text = "Hoy"
        hoyLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        hoyLabel?.textAlignment = .center
        hoyLabel?.textColor = .white
        hoyLabel?.backgroundColor = purpleBG.withAlphaComponent(0)
        pagos1?.addSubview(hoyLabel!)
        
        fecha = UILabel(frame: CGRect(x: hoyLabel!.frame.maxX + wScreen * 0.05, y: calendarImg!.frame.maxY + hScreen * 0.03, width: wScreen * 0.4, height: hScreen * 0.04))
        fecha?.text = "15 de mayo"
        fecha?.font = UIFont(name: "Roboto-Bold", size: 15)
        fecha?.textColor = dateGray
        pagos1?.addSubview(fecha!)
        
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
        
        picker = UIPickerView(frame: CGRect(x: 0, y: fecha!.frame.maxY + hScreen * 0.1, width: wScreen, height: hScreen * 0.3))
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
        pagos2?.backgroundColor = bgPagos
        view.addSubview(pagos2!)
        
        backBtn2 = UIButton(type: .custom)
        backBtn2?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn2?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn2?.tag = 2
        backBtn2?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos2?.addSubview(backBtn2!)
        
        calendarImg2 = UIImageView(frame: CGRect(x: wScreen * 0.06, y: backBtn2!.frame.maxY + hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.06))
        calendarImg2?.image = #imageLiteral(resourceName: "miniCalendar")
        pagos2?.addSubview(calendarImg2!)
        
        titleLabel2 = UILabel(frame: CGRect(x: calendarImg2!.frame.maxX + wScreen * 0.03, y: backBtn2!.frame.maxY + hScreen * 0.038, width: wScreen * 0.5, height: hScreen * 0.055))
        titleLabel2?.text = "elige horario"
        titleLabel2?.font = UIFont(name: "Roboto-Bold", size: 33)
        titleLabel2?.textColor = .white
        pagos2?.addSubview(titleLabel2!)
        
        let backPurple2 = UIView(frame: CGRect(x: wScreen * 0.06, y: calendarImg2!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        backPurple2.backgroundColor = purpleBG
        backPurple2.layer.cornerRadius = 5.0
        backPurple2.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        backPurple2.layer.shadowOpacity = 0.8
        backPurple2.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        backPurple2.layer.shadowRadius = 3.0
        pagos2?.addSubview(backPurple2)
        
        hoyLabel2 = UILabel(frame: CGRect(x: wScreen * 0.06, y: calendarImg2!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        hoyLabel2?.text = "Hoy"
        hoyLabel2?.font = UIFont(name: "Roboto-Bold", size: 15)
        hoyLabel2?.textAlignment = .center
        hoyLabel2?.textColor = .white
        hoyLabel2?.backgroundColor = purpleBG.withAlphaComponent(0)
        pagos2?.addSubview(hoyLabel2!)
        
        fecha2 = UILabel(frame: CGRect(x: hoyLabel2!.frame.maxX + wScreen * 0.05, y: calendarImg2!.frame.maxY + hScreen * 0.03, width: wScreen * 0.4, height: hScreen * 0.04))
        fecha2?.text = "15 de mayo"
        fecha2?.font = UIFont(name: "Roboto-Bold", size: 15)
        fecha2?.textColor = dateGray
        pagos2?.addSubview(fecha2!)
        
        tablaHorarios = UICollectionView(frame: CGRect(x: wScreen * 0.05, y: fecha2!.frame.maxY + hScreen * 0.07, width: wScreen * 0.9, height: hScreen * 0.5), collectionViewLayout: UICollectionViewFlowLayout())
        tablaHorarios?.backgroundColor = UIColor.white.withAlphaComponent(0)
        tablaHorarios?.register(ContentPagos.self, forCellWithReuseIdentifier: "hourCell")
        tablaHorarios?.dataSource = self
        tablaHorarios?.delegate = self
        pagos2?.addSubview(tablaHorarios!)
        // Vista de pagos2
        
        // Vista de pagos3
        pagos3 = UIView(frame: CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88))
        pagos3?.backgroundColor = bgPagos
        view.addSubview(pagos3!)
        
        backBtn3 = UIButton(type: .custom)
        backBtn3?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn3?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn3?.tag = 3
        backBtn3?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos3?.addSubview(backBtn3!)
        
        calendarImg3 = UIImageView(frame: CGRect(x: wScreen * 0.06, y: backBtn3!.frame.maxY + hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.06))
        calendarImg3?.image = #imageLiteral(resourceName: "miniCalendar")
        pagos3?.addSubview(calendarImg3!)
        
        titleLabel3 = UILabel(frame: CGRect(x: calendarImg3!.frame.maxX + wScreen * 0.03, y: backBtn3!.frame.maxY + hScreen * 0.038, width: wScreen * 0.5, height: hScreen * 0.055))
        titleLabel3?.text = "confirmar"
        titleLabel3?.font = UIFont(name: "Roboto-Bold", size: 33)
        titleLabel3?.textColor = .white
        pagos3?.addSubview(titleLabel3!)
        
        let backPurple3 = UIView(frame: CGRect(x: wScreen * 0.06, y: calendarImg3!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        backPurple3.backgroundColor = purpleBG
        backPurple3.layer.cornerRadius = 5.0
        backPurple3.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        backPurple3.layer.shadowOpacity = 0.8
        backPurple3.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        backPurple3.layer.shadowRadius = 3.0
        pagos3?.addSubview(backPurple3)
        
        hoyLabel3 = UILabel(frame: CGRect(x: wScreen * 0.06, y: calendarImg3!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        hoyLabel3?.text = "Hoy"
        hoyLabel3?.font = UIFont(name: "Roboto-Bold", size: 15)
        hoyLabel3?.textAlignment = .center
        hoyLabel3?.textColor = .white
        hoyLabel3?.backgroundColor = purpleBG.withAlphaComponent(0)
        pagos3?.addSubview(hoyLabel3!)
        
        fecha3 = UILabel(frame: CGRect(x: hoyLabel3!.frame.maxX + wScreen * 0.05, y: calendarImg3!.frame.maxY + hScreen * 0.03, width: wScreen * 0.4, height: hScreen * 0.04))
        fecha3?.text = "15 de mayo"
        fecha3?.font = UIFont(name: "Roboto-Bold", size: 15)
        fecha3?.textColor = dateGray
        pagos3?.addSubview(fecha3!)
        
        let imgPrice = UIImageView(frame: CGRect(x: wScreen * 0.125, y: fecha3!.frame.maxY + hScreen * 0.05, width: wScreen * 0.75, height: hScreen * 0.1))
        imgPrice.image = #imageLiteral(resourceName: "precioFake")
        pagos3?.addSubview(imgPrice)
        
        let realPrice = UILabel(frame: CGRect(x: wScreen * 0.125, y: fecha3!.frame.maxY + hScreen * 0.05, width: wScreen * 0.75, height: hScreen * 0.1))
        realPrice.text = price! + " mxn"
        realPrice.font = UIFont(name: "Montserrat-Bold", size: 29)
        realPrice.textAlignment = .center
        realPrice.textColor = UIColor(red: 63/255, green: 60/255, blue: 78/255, alpha: 1)
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
        pagos4?.backgroundColor = bgPagos
        view.addSubview(pagos4!)
        
        backBtn4 = UIButton(type: .custom)
        backBtn4?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.05, height: wScreen * 0.045)
        backBtn4?.setImage(#imageLiteral(resourceName: "backFromPagos"), for: .normal)
        backBtn4?.tag = 4
        backBtn4?.addTarget(self, action: #selector(backPressed(sender:)), for: .touchUpInside)
        pagos4?.addSubview(backBtn4!)
        
        calendarImg4 = UIImageView(frame: CGRect(x: wScreen * 0.06, y: backBtn4!.frame.maxY + hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.06))
        calendarImg4?.image = #imageLiteral(resourceName: "miniCalendar")
        pagos4?.addSubview(calendarImg4!)
        
        titleLabel4 = UILabel(frame: CGRect(x: calendarImg4!.frame.maxX + wScreen * 0.03, y: backBtn4!.frame.maxY + hScreen * 0.038, width: wScreen * 0.5, height: hScreen * 0.055))
        titleLabel4?.text = "confirmado"
        titleLabel4?.font = UIFont(name: "Roboto-Bold", size: 33)
        titleLabel4?.textColor = .white
        pagos4?.addSubview(titleLabel4!)
        
        let backPurple4 = UIView(frame: CGRect(x: wScreen * 0.06, y: calendarImg4!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        backPurple4.backgroundColor = purpleBG
        backPurple4.layer.cornerRadius = 5.0
        backPurple4.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        backPurple4.layer.shadowOpacity = 0.8
        backPurple4.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        backPurple4.layer.shadowRadius = 3.0
        pagos4?.addSubview(backPurple4)
        
        hoyLabel4 = UILabel(frame: CGRect(x: wScreen * 0.06, y: calendarImg4!.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: hScreen * 0.04))
        hoyLabel4?.text = "Hoy"
        hoyLabel4?.font = UIFont(name: "Roboto-Bold", size: 15)
        hoyLabel4?.textAlignment = .center
        hoyLabel4?.textColor = .white
        hoyLabel4?.backgroundColor = purpleBG.withAlphaComponent(0)
        pagos4?.addSubview(hoyLabel4!)
        
        fecha4 = UILabel(frame: CGRect(x: hoyLabel4!.frame.maxX + wScreen * 0.05, y: calendarImg4!.frame.maxY + hScreen * 0.03, width: wScreen * 0.4, height: hScreen * 0.04))
        fecha4?.text = "15 de mayo"
        fecha4?.font = UIFont(name: "Roboto-Bold", size: 15)
        fecha4?.textColor = dateGray
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
        pagos4?.addSubview(gracias)
        // Vista de pagos4
        
        botPurple = UIView(frame: CGRect(x: wScreen - wScreen * 0.025, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12))
        botPurple?.backgroundColor = purpleProgress
        view.addSubview(botPurple!)
        
        botContainer = UIView(frame: CGRect(x: 0, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12))
        botContainer?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(botContainer!)
        
        seleccionaL = UILabel(frame: CGRect(x: wScreen * 0.06, y: botContainer!.frame.height/2 - (hScreen * 0.05/2), width: wScreen * 0.2, height: hScreen * 0.05))
        seleccionaL?.text = "Selecciona"
        seleccionaL?.textColor = .black
        seleccionaL?.font = UIFont(name: "Roboto-Bold", size: 16)
        botContainer?.addSubview(seleccionaL!)
        
        fraseL = UILabel(frame: CGRect(x: seleccionaL!.frame.maxX + wScreen * 0.05, y: botContainer!.frame.height/2 - (hScreen * 0.05/2), width: wScreen * 0.5, height: hScreen * 0.05))
        fraseL?.text = "el día de tu visita"
        fraseL?.textColor = grayFrase
        fraseL?.font = UIFont(name: "Roboto-Bold", size: 16)
        botContainer?.addSubview(fraseL!)
        
        nextBtn1 = UIButton(type: .custom)
        nextBtn1?.frame = CGRect(x: wScreen - wScreen * 0.09, y: botContainer!.frame.height/2 - (wScreen * 0.05/2), width: wScreen * 0.031, height: wScreen * 0.05)
        nextBtn1?.setImage(#imageLiteral(resourceName: "nextInPagos2"), for: .normal)
        nextBtn1?.tintColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        nextBtn1?.tag = 1
        nextBtn1?.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        botContainer?.addSubview(nextBtn1!)
        
        nextBtn2 = UIButton(type: .custom)
        nextBtn2?.frame = CGRect(x: wScreen - wScreen * 0.09, y: botContainer!.frame.height/2 - (wScreen * 0.05/2), width: wScreen * 0.031, height: wScreen * 0.05)
        nextBtn2?.setImage(#imageLiteral(resourceName: "nextInPagos"), for: .normal)
        nextBtn2?.tintColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        nextBtn2?.tag = 2
        nextBtn2?.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        nextBtn2?.alpha = 0
        botContainer?.addSubview(nextBtn2!)
        
        imgCarrito = UIImageView(frame: CGRect(x: wScreen * 0.751, y: botContainer!.frame.height * 0.4, width: wScreen * 0.16, height: wScreen * 0.04))
        imgCarrito?.image = #imageLiteral(resourceName: "nextInPagos3.pdf")
        imgCarrito?.alpha = 0
        botContainer?.addSubview(imgCarrito!)
        
        nextBtn3 = UIButton(type: .custom)
        nextBtn3?.frame = CGRect(x: wScreen - wScreen * 0.3, y: botContainer!.frame.height * 0.1, width: wScreen * 0.25, height: botContainer!.frame.height * 0.8)
        nextBtn3?.tintColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        nextBtn3?.tag = 3
        nextBtn3?.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        nextBtn3?.alpha = 0
        botContainer?.addSubview(nextBtn3!)
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
                UIApplication.shared.statusBarStyle = .lightContent
                self.navigationController?.popViewController(animated: true)
            case 2:
                UIView.animate(withDuration: 0.5, animations: {
                    self.pagos1?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.pagos2?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.025, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                    self.seleccionaL?.text = "Selecciona"
                    self.fraseL?.text = "el día de tu visita"
                    self.nextBtn2?.alpha = 0
                    self.nextBtn1?.alpha = 1
                }, completion: { (true) in
                    
                })
            case 3:
                UIView.animate(withDuration: 0.5, animations: {
                    self.pagos2?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.pagos3?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                    self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.25, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                    self.fraseL?.text = "el horario de tu visita"
                    self.nextBtn3?.alpha = 0
                    self.imgCarrito?.alpha = 0
                    self.nextBtn2?.alpha = 1
                }) { (true) in
                    
            }
        default:
            UIView.animate(withDuration: 0.5, animations: {
                self.pagos3?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                self.pagos4?.frame = CGRect(x: wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.35, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                self.seleccionaL?.text = "MXN $" + self.price!
                self.fraseL?.text = "total IVA incluido"
                self.nextBtn2?.alpha = 0
                self.nextBtn3?.alpha = 1
                self.imgCarrito?.alpha = 1
            }, completion: { (true) in
                
            })
        }
    }
    
    @objc func nextPressed(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            getJsonFromUrl()

        case 2:
            UIView.animate(withDuration: 0.5, animations: {
                self.pagos2?.frame = CGRect(x: -wScreen, y: 0, width: wScreen, height: hScreen * 0.88)
                self.pagos3?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.88)
                self.botPurple?.frame = CGRect(x: wScreen - wScreen * 0.35, y: hScreen * 0.88, width: wScreen, height: hScreen * 0.12)
                self.seleccionaL?.text = "MXN $" + self.price!
                self.fraseL?.text = "total IVA incluido"
                self.nextBtn2?.alpha = 0
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
                self.nextBtn3?.alpha = 0
                self.imgCarrito?.alpha = 0
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
            cell.layer.borderColor = UIColor(red: 19/255, green: 18/255, blue: 24/255, alpha: 1).cgColor
        }
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5.0
        
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
                collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor(red: 19/255, green: 18/255, blue: 24/255, alpha: 1).cgColor

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
        collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor(red: 19/255, green: 18/255, blue: 24/255, alpha: 1).cgColor

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
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .lightContent
    }

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
