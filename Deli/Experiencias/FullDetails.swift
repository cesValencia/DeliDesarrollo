//
//  FullDetails.swift
//  PagingMenu
//
//  Created by David Valencia on 27/11/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit
import SDWebImage

class FullDetails: UIViewController, UIScrollViewDelegate {
    
    var imagen_principal: String?
    var tipo_comida: String?
    var name_restaurant: String?
    var incluye: String?
    var img_price: String?
    var precio: String?
    var logo: String?
    var introduccion: String?
    var p1: String?
    var link_video: String?
    var p2: String?
    var imagen_2: String?
    var frase: String?
    var p3: String?
    var imagen_3: String?
    var logo_editorial: String?
    var editorial: String?
    var id_restaurant: String?
    var category: String?
    var zona: String?
    var direccion: String?
    var tolerancia: String?

    var detailContainer: UIScrollView?
    var secondScroll: UIScrollView?
    var container1: UIView?
    var container2: UIView?
    var showRestaurant: Restaurant?
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var navBar: UIView?
    var backButton: UIButton?
    var locationB: UIButton?
    var likeB: UIButton?
    var shareB: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("Paso1")
        view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        loadInterface()
        NSLog("Paso2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if detailContainer?.contentOffset.y == UIScreen.main.bounds.height * 1 {
            statusBar.backgroundColor = UIColor.white.withAlphaComponent(1)
            UIApplication.shared.statusBarStyle = .default
            navBar?.backgroundColor = UIColor.white
            backButton?.tintColor = .black
            locationB?.tintColor = .black
            likeB?.tintColor = .black
            shareB?.tintColor = .black
        } else {
            statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            UIApplication.shared.statusBarStyle = .lightContent
            navBar?.backgroundColor = UIColor.black.withAlphaComponent(0)
            backButton?.tintColor = .white
            locationB?.tintColor = .white
            likeB?.tintColor = .white
            shareB?.tintColor = .white
        }
    }
    
    func loadInterface() {
        
        detailContainer = UIScrollView(frame: view.frame)
        detailContainer?.delegate = self
        detailContainer?.alwaysBounceHorizontal = false
        detailContainer?.bounces = false
        detailContainer?.isPagingEnabled = true
        detailContainer?.isScrollEnabled = true
        detailContainer?.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            detailContainer?.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(detailContainer!)
        
        navBar = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.1))
        navBar?.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(navBar!)
        
        backButton = UIButton(type: UIButtonType.system)
        backButton?.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.05)
        let originalBackImage = #imageLiteral(resourceName: "back_icon")
        let tintedBackImage = originalBackImage.withRenderingMode(.alwaysTemplate)
        backButton?.tintColor = .white
        backButton?.setBackgroundImage(tintedBackImage, for: UIControlState.normal)
        backButton?.addTarget(self, action: #selector(backPressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(backButton!)
        
        locationB = UIButton(type: UIButtonType.system)
        locationB?.frame = CGRect(x: wScreen * 0.63, y: hScreen * 0.05, width: wScreen * 0.046, height: wScreen * 0.06)
        let originalLocationImage = #imageLiteral(resourceName: "Shape")
        let tintedLocationImage = originalLocationImage.withRenderingMode(.alwaysTemplate)
        locationB?.tintColor = .white
        locationB?.setBackgroundImage(tintedLocationImage, for: UIControlState.normal)
        locationB?.addTarget(self, action: #selector(locationPressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(locationB!)
        
        
        likeB = UIButton(type: UIButtonType.system)
        likeB?.frame = CGRect(x: locationB!.frame.maxX + wScreen * 0.072, y: hScreen * 0.05, width: wScreen * 0.06, height: wScreen * 0.06)
        let originalLikeImage = #imageLiteral(resourceName: "heart")
        let tintedLikeImage = originalLikeImage.withRenderingMode(.alwaysTemplate)
        likeB?.tintColor = .white
        likeB?.setBackgroundImage(tintedLikeImage, for: UIControlState.normal)
        likeB?.addTarget(self, action: #selector(likePressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(likeB!)
        
        
        shareB = UIButton(type: UIButtonType.system)
        shareB?.frame = CGRect(x: likeB!.frame.maxX + wScreen * 0.072, y: hScreen * 0.05, width: wScreen * 0.044, height: wScreen * 0.06)
        let originalShareImage = #imageLiteral(resourceName: "Share")
        let tintedShareImage = originalShareImage.withRenderingMode(.alwaysTemplate)
        shareB?.setBackgroundImage(tintedShareImage, for: UIControlState.normal)
        shareB?.tintColor = .white
        shareB?.addTarget(self, action: #selector(sharePressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(shareB!)
        
        container1 = UIView(frame: detailContainer!.frame)
        container1?.backgroundColor = UIColor.black
        detailContainer?.addSubview(container1!)
        
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        
        NSLog("BAJAR IMAGEN 1")
        if let url = URL(string: "http://104.236.10.17" + (imagen_principal)!) {
//            background.image = UIImage(data: data)
            background.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
            NSLog("BAJAR IMAGEN 2")

        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        NSLog("BAJAR IMAGEN 3")

        container1?.addSubview(background)
        
        let tipo_comidaL = UILabel(frame: CGRect(x: wScreen * 0.06, y: hScreen - hScreen * 0.63, width: wScreen * 0.3, height: hScreen * 0.05))
        tipo_comidaL.text = tipo_comida
        tipo_comidaL.textColor = UIColor.white
        tipo_comidaL.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 17)
        
        container1?.addSubview(tipo_comidaL)
        
        let nombreL = UITextView(frame: CGRect(x: wScreen * 0.05, y: hScreen - hScreen * 0.585, width: wScreen * 0.9, height: 0));
        nombreL.text = name_restaurant
        nombreL.textColor = UIColor.white
        nombreL.font = UIFont(name: "Roboto-Bold", size: 34)
        nombreL.isEditable = false
        nombreL.isScrollEnabled = false
        nombreL.sizeToFit()
        nombreL.backgroundColor = UIColor(red: 255.00/255, green: 255.00/255, blue: 255.00/255, alpha: 0.00);
        container1?.addSubview(nombreL)
        
        let contenidoL = UITextView(frame: CGRect(x: wScreen * 0.05, y: hScreen - hScreen * 0.34, width: wScreen * 0.85, height: 0));
        contenidoL.text = incluye
        contenidoL.textColor = UIColor.white
        contenidoL.font = UIFont(name: "PlayfairDisplay-Regular", size: 17)
        contenidoL.isEditable = false
        contenidoL.isScrollEnabled = false
        contenidoL.sizeToFit()
        contenidoL.backgroundColor = UIColor(red: 255.00/255, green: 255.00/255, blue: 255.00/255, alpha: 0.00);
        container1?.addSubview(contenidoL)
        
        let imgCompra = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen - hScreen * 0.25, width: wScreen * 0.42, height: hScreen * 0.27))
        imgCompra.contentMode = .scaleAspectFit
        
        if let url = URL(string: "http://104.236.10.17" + (img_price)!) {
//            imgCompra.image = UIImage(data: data)
            imgCompra.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-imagen"), options: .refreshCached)
        } else {
            
        }
        container1?.addSubview(imgCompra)
        
        let btnCompra = UIButton(type: .custom)
        btnCompra.addTarget(self, action: #selector(btnCompraPressed), for: .touchUpInside)
        btnCompra.frame = CGRect(x: wScreen * 0.05, y: hScreen - hScreen * 0.25, width: wScreen * 0.42, height: hScreen * 0.27)
        container1?.addSubview(btnCompra)
        
        let logoR = UIImageView(frame: CGRect(x: wScreen - (wScreen * 0.4), y: hScreen - hScreen * 0.18, width: wScreen * 0.32, height: hScreen * 0.13))
//        logoR.contentMode = .scaleAspectFit
        
        if let url = URL(string: "http://104.236.10.17" + (logo)!) {
//            logoR.image = UIImage(data: data)
            logoR.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-imagen"), options: .refreshCached)
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        container1?.addSubview(logoR)

        let leyendaL = UILabel(frame: CGRect(x: wScreen * 0.05, y: hScreen - hScreen * 0.045, width: wScreen * 0.9, height: hScreen * 0.025))
        leyendaL.text = "DESLIZA HACIA ABAJO PARA MÁS INFORMACIÓN"
        leyendaL.textAlignment = .center
        leyendaL.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        leyendaL.textColor = UIColor.white.withAlphaComponent(0.4)
        container1?.addSubview(leyendaL)
        
        container2 = UIView(frame: CGRect(x: 0, y: container1!.frame.maxY, width: wScreen, height: hScreen))
        container2?.backgroundColor = UIColor.red
        detailContainer?.addSubview(container2!)
        
        secondScroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        secondScroll?.delegate = self
        secondScroll?.alwaysBounceHorizontal = false
        secondScroll?.bounces = false
        secondScroll?.isScrollEnabled = true
        secondScroll?.isPagingEnabled = false
        secondScroll?.backgroundColor = UIColor.white
        container2?.addSubview(secondScroll!)
        
        //----------------
        let introL = UITextView(frame: CGRect(x: wScreen * 0.05, y: navBar!.frame.maxY, width: wScreen * 0.9, height: 0));
        introL.text = introduccion
        introL.textColor = UIColor.black
        introL.font = UIFont(name: "Roboto-Bold", size: 22)
        introL.sizeToFit()
        introL.isEditable = false
        introL.isSelectable = false
        introL.isScrollEnabled = false
        secondScroll?.addSubview(introL)
        
        let purpleLine = UIImageView(frame: CGRect(x: wScreen * 0.05, y: introL.frame.maxY + hScreen * 0.03, width: 100, height: 2.5))
        purpleLine.image = UIImage(named: "purpleLine")
        secondScroll?.addSubview(purpleLine)
        
        let p1L = UITextView(frame: CGRect(x: wScreen * 0.05, y: purpleLine.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: 0));
        p1L.text = showRestaurant?.p1
        p1L.textColor = UIColor.black
        p1L.font = UIFont(name: "Roboto-Light", size: 16)
        p1L.sizeToFit()
        p1L.isEditable = false
        p1L.isSelectable = false
        p1L.isScrollEnabled = false
        secondScroll?.addSubview(p1L)
        
        let vimeoVideo = UIWebView(frame: CGRect(x: 0, y: p1L.frame.maxY + hScreen * 0.03, width: wScreen, height: hScreen * 0.3))
        
        if URL(string: link_video ?? "") != nil {
            vimeoVideo.loadRequest(URLRequest(url: URL(string: "https://player.vimeo.com/video/221530265")!))
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
        }
        secondScroll?.addSubview(vimeoVideo)
        
        let p2L = UITextView(frame: CGRect(x: wScreen * 0.05, y: vimeoVideo.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: 0));
        p2L.text = p2
        p2L.textColor = UIColor.black
        p2L.font = UIFont(name: "Roboto-Light", size: 16)
        p2L.sizeToFit()
        p2L.isEditable = false
        p2L.isSelectable = false
        p2L.isScrollEnabled = false
        secondScroll?.addSubview(p2L)
        
        //Aquí va imagen2
        let imagen2 = UIImageView(frame: CGRect(x: 0, y: p2L.frame.maxY + hScreen * 0.03, width: wScreen, height: hScreen * 0.4))
        imagen2.contentMode = .scaleAspectFit
        if let url = URL(string: "http://104.236.10.17" + (imagen_2)!) {
//            imagen2.image = UIImage(data: data)
            imagen2.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        secondScroll?.addSubview(imagen2)
        
        let fraseL = UITextView(frame: CGRect(x: wScreen * 0.1, y: imagen2.frame.maxY + hScreen * 0.03, width: wScreen * 0.8, height: 0));
        fraseL.text = "\"\"" + frase! + "\"\""
        fraseL.textColor = UIColor.black
        fraseL.font = UIFont(name: "Roboto-Light", size: 21)
        fraseL.sizeToFit()
        fraseL.isEditable = false
        secondScroll?.addSubview(fraseL)
        
        let p3L = UITextView(frame: CGRect(x: wScreen * 0.05, y: fraseL.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: 0));
        p3L.text = p3
        p3L.textColor = UIColor.black
        p3L.font = UIFont(name: "Roboto-Light", size: 16)
        p3L.sizeToFit()
        p3L.isEditable = false
        p3L.isSelectable = false
        p3L.isScrollEnabled = false
        secondScroll?.addSubview(p3L)
        
        let imagen3 = UIImageView(frame: CGRect(x: 0, y: p3L.frame.maxY + hScreen * 0.03, width: wScreen, height: hScreen * 0.4))
        imagen3.contentMode = .scaleAspectFit
        
        if let url = URL(string: "http://104.236.10.17" + (imagen_3)! ) {
//            imagen3.image = UIImage(data: data)
            imagen3.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        secondScroll?.addSubview(imagen3)
        
        let logoEditorial = UIImageView(frame: CGRect(x: wScreen * 0.4, y: imagen3.frame.maxY + hScreen * 0.03, width: wScreen * 0.2, height: wScreen * 0.2))
        logoEditorial.contentMode = .scaleAspectFit
        if let url = URL(string: "http://104.236.10.17" + (logo_editorial)!) {
//            logoEditorial.image = UIImage(data: data)
            logoEditorial.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        secondScroll?.addSubview(logoEditorial)
        
        let editorialL = UILabel(frame: CGRect(x: wScreen * 0.35, y: logoEditorial.frame.maxY, width: wScreen * 0.3, height: hScreen * 0.05));
        editorialL.text = editorial
        editorialL.textColor = UIColor.black
        editorialL.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        editorialL.textAlignment = .center
        editorialL.adjustsFontSizeToFitWidth = true
        secondScroll?.addSubview(editorialL)
        
        let notaEd = UITextView(frame: CGRect(x: wScreen * 0.125, y: editorialL.frame.maxY + hScreen * 0.03, width: wScreen * 0.8, height: 0));
        notaEd.text = "Para leer la nota completa vista nuestras redes sociales y suígenos!"
        notaEd.textColor = UIColor.lightGray
        notaEd.textAlignment = .center
        notaEd.font = UIFont(name: "Helvetica-Light", size: 16)
        notaEd.sizeToFit()
        notaEd.isEditable = false
        notaEd.isSelectable = false
        notaEd.isScrollEnabled = false
        secondScroll?.addSubview(notaEd)
        
        let btnVisitar = UIButton(type: .custom)
        btnVisitar.setImage(#imageLiteral(resourceName: "visitarBtn"), for: .normal)
        btnVisitar.addTarget(self, action: #selector(btnVisitarPressed), for: .touchUpInside)
        btnVisitar.frame = CGRect(x: wScreen * 0.275, y: notaEd.frame.maxY + hScreen * 0.03, width: wScreen * 0.45, height: hScreen * 0.06)
        secondScroll?.addSubview(btnVisitar)
        
        
        let laÑera = UIImageView(frame: CGRect(x: 0, y: btnVisitar.frame.maxY + hScreen * 0.03, width: wScreen, height: hScreen * 0.4))
        laÑera.image = UIImage(named: "footer-exp")
        secondScroll?.addSubview(laÑera)
        
        let random = UILabel(frame: CGRect(x: 0, y: laÑera.frame.maxY, width: wScreen, height: 30))
        secondScroll?.addSubview(random)
        
        secondScroll?.contentSize = CGSize(width: wScreen, height: random.frame.maxY)
        //----------------
        
        detailContainer?.contentSize = CGSize(width: wScreen, height: container2!.frame.maxY)
    }
    
    @objc func btnCompraPressed() {
        
        let view1 = Pagos()
        view1.rest2 = showRestaurant
        view1.place = name_restaurant
        view1.price = precio
        view1.concept = category
        view1.zone = zona
        view1.tolerance = tolerancia
        
        navigationController?.pushViewController(view1, animated: true)
    }
    
    @objc func btnVisitarPressed() {
        
        let Username =  "hotbook" // Your Instagram Username here
        let appURL = NSURL(string: "instagram://user?username=\(Username)")!
        let webURL = NSURL(string: "https://instagram.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    @objc func backPressed() {
        
        navigationController?.popViewController(animated: true)
        view.removeFromSuperview()

    }
    
    @objc func locationPressed() {
        
        let alert = UIAlertController(title: "Deseas abrir dirección con Google Maps", message: showRestaurant?.direccion ?? "Dirección no disponible", preferredStyle: .alert)
        
        let clearAction = UIAlertAction(title: "Cancelar", style: .destructive) { (alert: UIAlertAction!) -> Void in
            
        }
        let cancelAction = UIAlertAction(title: "Permitir", style: .default) { (alert: UIAlertAction!) -> Void in
            
            
            if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
            {
    
                UIApplication.shared.openURL(NSURL(string:
                    "https://www.google.com.mx/maps/place/Mercado+del+Carmen/@19.346168,-99.1927645,17z/data=!3m1!4b1!4m5!3m4!1s0x85d200029a1dc1f7:0x8a1bdfc7e21a6408!8m2!3d19.346168!4d-99.1905758")! as URL)

            }
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)

    }
    
    @objc func likePressed() {
        
    }
    
    @objc func sharePressed() {
        
        let activityController = UIActivityViewController(activityItems: ["Comiendo en " + (showRestaurant?.nombre)! + ". " + "Descarga la app ya! \n http://somosdeli.com"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
