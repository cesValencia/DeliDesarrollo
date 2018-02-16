//
//  FullTrivias.swift
//  Deli
//
//  Created by David Valencia on 27/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import SDWebImage

class FullTrivias: UIViewController, UIScrollViewDelegate {
    
    var detailContainer: UIScrollView?
    var secondScroll: UIScrollView?
    var container1: UIView?
    var container2: UIView?
    var showRestaurant: Restaurant?
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var navBar: UIView?
    var backButton: UIButton?
    var shareB: UIButton?
    var imgPrincipalT: String?
    var vigenciaT: String?
    var nombreT: String?
    var incluyeT: String?
    var questionArrayT111 = [String]()
    var r1ArrayT111 = [String]()
    var r2ArrayT111 = [String]()
    var r3ArrayT111 = [String]()
    var questionArrayT222 = [String]()
    var r1ArrayT222 = [String]()
    var r2ArrayT222 = [String]()
    var r3ArrayT222 = [String]()
    var questionArrayT333 = [String]()
    var r1ArrayT333 = [String]()
    var r2ArrayT333 = [String]()
    var r3ArrayT333 = [String]()
    var questionArrayT444 = [String]()
    var r1ArrayT444 = [String]()
    var r2ArrayT444 = [String]()
    var r3ArrayT444 = [String]()
    var questionArrayT555 = [String]()
    var r1ArrayT555 = [String]()
    var r2ArrayT555 = [String]()
    var r3ArrayT555 = [String]()
    var indexSelected2: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.questionArrayT111)
        print(self.r1ArrayT111)
        print(self.r2ArrayT111)
        print(self.r3ArrayT111)
        print(self.questionArrayT222)
        print(self.r1ArrayT222)
        print(self.r2ArrayT222)
        print(self.r3ArrayT222)
        print(self.questionArrayT333)
        print(self.r1ArrayT333)
        print(self.r2ArrayT333)
        print(self.r3ArrayT333)
        print(self.questionArrayT444)
        print(self.r1ArrayT444)
        print(self.r2ArrayT444)
        print(self.r3ArrayT444)
        print(self.questionArrayT555)
        print(self.r1ArrayT555)
        print(self.r2ArrayT555)
        print(self.r3ArrayT555)
        
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
        UIApplication.shared.statusBarStyle = .lightContent
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
            backButton?.tintColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
            shareB?.tintColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1)
        } else {
            statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            UIApplication.shared.statusBarStyle = .lightContent
            navBar?.backgroundColor = UIColor.black.withAlphaComponent(0)
            backButton?.tintColor = .white
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
        let originalBackImage = #imageLiteral(resourceName: "backTNew")
        let tintedBackImage = originalBackImage.withRenderingMode(.alwaysTemplate)
        backButton?.tintColor = .white
        backButton?.setBackgroundImage(tintedBackImage, for: UIControlState.normal)
        backButton?.addTarget(self, action: #selector(backPressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(backButton!)
        
        shareB = UIButton(type: UIButtonType.system)
        shareB?.frame = CGRect(x: wScreen * 0.9, y: hScreen * 0.05, width: wScreen * 0.044, height: wScreen * 0.06)
        let originalShareImage = #imageLiteral(resourceName: "shareNew")
        let tintedShareImage = originalShareImage.withRenderingMode(.alwaysTemplate)
        shareB?.setBackgroundImage(tintedShareImage, for: UIControlState.normal)
        shareB?.tintColor = .white
        shareB?.addTarget(self, action: #selector(sharePressed), for: UIControlEvents.touchUpInside)
        navBar?.addSubview(shareB!)
        
        container1 = UIView(frame: detailContainer!.frame)
        container1?.backgroundColor = UIColor.black
        detailContainer?.addSubview(container1!)
        
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        
        background.image = #imageLiteral(resourceName: "maxresdefault")
        if let url = URL(string: "http://104.236.10.17" + (imgPrincipalT)!) {
            //            background.image = UIImage(data: data)
            background.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)


        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            background.image = #imageLiteral(resourceName: "sin-back")
        }

        
        container1?.addSubview(background)
        
        let fecha = UILabel(frame: CGRect(x: wScreen * 0.06, y: hScreen * 0.37, width: wScreen * 0.4, height: hScreen * 0.05))
        fecha.text = vigenciaT
        fecha.textColor = UIColor.white
        fecha.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 13)
        container1?.addSubview(fecha)
        
        let nombreL = UITextView(frame: CGRect(x: wScreen * 0.05, y: fecha.frame.maxY, width: wScreen * 0.5, height: 0));
        nombreL.text = nombreT
        nombreL.textColor = UIColor.white
        nombreL.font = UIFont(name: "Roboto-Bold", size: 34)
        nombreL.isEditable = false
        nombreL.isScrollEnabled = false
        nombreL.sizeToFit()
        nombreL.backgroundColor = UIColor.white.withAlphaComponent(0)
        container1?.addSubview(nombreL)
        
        let contenidoL = UITextView(frame: CGRect(x: wScreen * 0.05, y: nombreL.frame.maxY, width: wScreen * 0.7, height: 0));
        contenidoL.text = incluyeT
        contenidoL.textColor = UIColor.white
        contenidoL.font = UIFont(name: "PlayfairDisplay-Regular", size: 17)
        contenidoL.isEditable = false
        contenidoL.isScrollEnabled = false
        contenidoL.sizeToFit()
        contenidoL.backgroundColor = UIColor.white.withAlphaComponent(0)
        container1?.addSubview(contenidoL)
        
        let btnParticipa = UIButton(type: .custom)
        btnParticipa.setImage(#imageLiteral(resourceName: "btnParticipar"), for: .normal)
        btnParticipa.addTarget(self, action: #selector(btnParticipaPressed), for: .touchUpInside)
        btnParticipa.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.85, width: wScreen * 0.45, height: hScreen * 0.061)
        container1?.addSubview(btnParticipa)
        
        let logoR = UIImageView(frame: CGRect(x: wScreen * 0.65, y: hScreen * 0.84, width: wScreen * 0.25, height: hScreen * 0.07))
        logoR.image = #imageLiteral(resourceName: "logoBlancoFake")
//        //        logoR.contentMode = .scaleAspectFit
//
//        if let url = URL(string: "http://104.236.10.17" + (logo)!) {
//            //            logoR.image = UIImage(data: data)
//            logoR.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-imagen"), options: .refreshCached)
//        } else {
//            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
//
//        }
        container1?.addSubview(logoR)
        
        let leyendaL = UILabel(frame: CGRect(x: wScreen * 0.225, y: hScreen * 0.965, width: wScreen * 0.55, height: wScreen * 0.03))
        leyendaL.text = "DESLIZA HACIA ABAJO PARA VER PREMIOS"
        leyendaL.textAlignment = .center
        leyendaL.font = UIFont(name: "SourceSansPro-Regular", size: 11)
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
        let titulo = UILabel(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.11, width: wScreen * 0.4, height: hScreen * 0.05))
        titulo.text = "Premios"
        titulo.font = UIFont(name: "Roboto-Black", size: 35)
        secondScroll?.addSubview(titulo)
        
        let lugares = UILabel(frame: CGRect(x: wScreen * 0.05, y: titulo.frame.maxY, width: wScreen * 0.4, height: hScreen * 0.04))
        lugares.text = "Para 1º, 2º y 3º lugar"
        lugares.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        lugares.textColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)
        secondScroll?.addSubview(lugares)
        
        let orangeLine = UIView(frame: CGRect(x: wScreen * 0.05, y: lugares.frame.maxY + hScreen * 0.05, width: wScreen * 0.008, height: hScreen * 0.11))
        orangeLine.backgroundColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        secondScroll?.addSubview(orangeLine)
        
        let categoria = UILabel(frame: CGRect(x: orangeLine.frame.maxX + wScreen * 0.035, y: lugares.frame.maxY + hScreen * 0.056, width: wScreen * 0.15, height: wScreen * 0.04))
        categoria.text = "DIAMANTE"
        categoria.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 13)
        categoria.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        secondScroll?.addSubview(categoria)
        
        let escudo = UIImageView(frame: CGRect(x: categoria.frame.maxX + wScreen * 0.06, y: lugares.frame.maxY + hScreen * 0.056, width: wScreen * 0.031, height: wScreen * 0.04))
        escudo.image = #imageLiteral(resourceName: "escudo")
        secondScroll?.addSubview(escudo)
        
        let firstPlace = UILabel(frame: CGRect(x: escudo.frame.maxX + wScreen * 0.01, y: lugares.frame.maxY + hScreen * 0.056, width: wScreen * 0.2, height: wScreen * 0.035))
        firstPlace.text = "1º Lugar"
        firstPlace.textColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        firstPlace.font = UIFont(name: "HelveticaNeue-Medium", size: 11.5)
        secondScroll?.addSubview(firstPlace)
        
        let nombrePremio = UITextView(frame: CGRect(x: orangeLine.frame.maxX + wScreen * 0.023, y: categoria.frame.maxY + hScreen * 0.01, width: wScreen * 0.5, height: wScreen * 0.11))
        nombrePremio.text = "Puntarena, cocina de autor mediterránea"
        nombrePremio.font = UIFont(name: "Roboto-Bold", size: 16)
        nombrePremio.sizeToFit()
        nombrePremio.isScrollEnabled = false
        nombrePremio.textColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        secondScroll?.addSubview(nombrePremio)
        
        let imgPremio = UIImageView(frame: CGRect(x: wScreen * 0.73, y: lugares.frame.maxY + hScreen * 0.05, width: wScreen * 0.22, height: wScreen * 0.22))
        imgPremio.layer.cornerRadius = 3.0
        imgPremio.layer.masksToBounds = true
        imgPremio.image = #imageLiteral(resourceName: "ranaFake")
        secondScroll?.addSubview(imgPremio)
        
        let descripcion = UITextView(frame: CGRect(x: wScreen * 0.05, y: imgPremio.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: hScreen * 0.1))
        descripcion.text = "Crema de camaron, ensalada de manzana, salmón con corteza de parmesano con brócoli rostizado."
        descripcion.font = UIFont(name: "Roboto-Light", size: 16)
        descripcion.sizeToFit()
        descripcion.isScrollEnabled = false
        descripcion.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        secondScroll?.addSubview(descripcion)
        
        let lineBreak = UIView(frame: CGRect(x: 0, y: descripcion.frame.maxY + hScreen * 0.05, width: wScreen, height: 0.5))
        lineBreak.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        secondScroll?.addSubview(lineBreak)
        
        let orangeLine2 = UIView(frame: CGRect(x: wScreen * 0.05, y: lineBreak.frame.maxY + hScreen * 0.05, width: wScreen * 0.008, height: hScreen * 0.11))
        orangeLine2.backgroundColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        secondScroll?.addSubview(orangeLine2)
        
        let categoria2 = UILabel(frame: CGRect(x: orangeLine2.frame.maxX + wScreen * 0.035, y: lineBreak.frame.maxY + hScreen * 0.056, width: wScreen * 0.15, height: wScreen * 0.04))
        categoria2.text = "DIAMANTE"
        categoria2.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 13)
        categoria2.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        secondScroll?.addSubview(categoria2)
        
        let escudo2 = UIImageView(frame: CGRect(x: categoria.frame.maxX + wScreen * 0.06, y: lineBreak.frame.maxY + hScreen * 0.056, width: wScreen * 0.031, height: wScreen * 0.04))
        escudo2.image = #imageLiteral(resourceName: "escudo")
        secondScroll?.addSubview(escudo2)
        
        let firstPlace2 = UILabel(frame: CGRect(x: escudo2.frame.maxX + wScreen * 0.01, y: lineBreak.frame.maxY + hScreen * 0.056, width: wScreen * 0.2, height: wScreen * 0.035))
        firstPlace2.text = "2º Lugar"
        firstPlace2.textColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        firstPlace2.font = UIFont(name: "HelveticaNeue-Medium", size: 11.5)
        secondScroll?.addSubview(firstPlace2)
        
        let nombrePremio2 = UITextView(frame: CGRect(x: orangeLine2.frame.maxX + wScreen * 0.023, y: categoria2.frame.maxY + hScreen * 0.01, width: wScreen * 0.5, height: wScreen * 0.11))
        nombrePremio2.text = "Puntarena, cocina de autor mediterránea"
        nombrePremio2.font = UIFont(name: "Roboto-Bold", size: 16)
        nombrePremio2.sizeToFit()
        nombrePremio2.isScrollEnabled = false
        nombrePremio2.textColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        secondScroll?.addSubview(nombrePremio2)
        
        let imgPremio2 = UIImageView(frame: CGRect(x: wScreen * 0.73, y: lineBreak.frame.maxY + hScreen * 0.05, width: wScreen * 0.22, height: wScreen * 0.22))
        imgPremio2.layer.cornerRadius = 3.0
        imgPremio2.layer.masksToBounds = true
        imgPremio2.image = #imageLiteral(resourceName: "ranaFake")
        secondScroll?.addSubview(imgPremio2)
        
        let descripcion2 = UITextView(frame: CGRect(x: wScreen * 0.05, y: imgPremio2.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: hScreen * 0.1))
        descripcion2.text = "Crema de camaron, ensalada de manzana, salmón con corteza de parmesano con brócoli rostizado."
        descripcion2.font = UIFont(name: "Roboto-Light", size: 16)
        descripcion2.sizeToFit()
        descripcion2.isScrollEnabled = false
        descripcion2.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        secondScroll?.addSubview(descripcion2)
        
        let lineBreak2 = UIView(frame: CGRect(x: 0, y: descripcion2.frame.maxY + hScreen * 0.05, width: wScreen, height: 0.5))
        lineBreak2.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        secondScroll?.addSubview(lineBreak2)
        
        let orangeLine3 = UIView(frame: CGRect(x: wScreen * 0.05, y: lineBreak2.frame.maxY + hScreen * 0.05, width: wScreen * 0.008, height: hScreen * 0.11))
        orangeLine3.backgroundColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        secondScroll?.addSubview(orangeLine3)
        
        let categoria3 = UILabel(frame: CGRect(x: orangeLine3.frame.maxX + wScreen * 0.035, y: lineBreak2.frame.maxY + hScreen * 0.056, width: wScreen * 0.15, height: wScreen * 0.04))
        categoria3.text = "DIAMANTE"
        categoria3.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 13)
        categoria3.textColor = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        secondScroll?.addSubview(categoria3)
        
        let escudo3 = UIImageView(frame: CGRect(x: categoria3.frame.maxX + wScreen * 0.06, y: lineBreak2.frame.maxY + hScreen * 0.056, width: wScreen * 0.031, height: wScreen * 0.04))
        escudo3.image = #imageLiteral(resourceName: "escudo")
        secondScroll?.addSubview(escudo3)
        
        let firstPlace3 = UILabel(frame: CGRect(x: escudo3.frame.maxX + wScreen * 0.01, y: lineBreak2.frame.maxY + hScreen * 0.056, width: wScreen * 0.2, height: wScreen * 0.035))
        firstPlace3.text = "3º Lugar"
        firstPlace3.textColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        firstPlace3.font = UIFont(name: "HelveticaNeue-Medium", size: 11.5)
        secondScroll?.addSubview(firstPlace3)
        
        let nombrePremio3 = UITextView(frame: CGRect(x: orangeLine3.frame.maxX + wScreen * 0.023, y: categoria3.frame.maxY + hScreen * 0.01, width: wScreen * 0.5, height: wScreen * 0.11))
        nombrePremio3.text = "Puntarena, cocina de autor mediterránea"
        nombrePremio3.font = UIFont(name: "Roboto-Bold", size: 16)
        nombrePremio3.sizeToFit()
        nombrePremio3.isScrollEnabled = false
        nombrePremio3.textColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        secondScroll?.addSubview(nombrePremio3)
        
        let imgPremio3 = UIImageView(frame: CGRect(x: wScreen * 0.73, y: lineBreak2.frame.maxY + hScreen * 0.05, width: wScreen * 0.22, height: wScreen * 0.22))
        imgPremio3.layer.cornerRadius = 3.0
        imgPremio3.layer.masksToBounds = true
        imgPremio3.image = #imageLiteral(resourceName: "ranaFake")
        secondScroll?.addSubview(imgPremio3)
        
        let descripcion3 = UITextView(frame: CGRect(x: wScreen * 0.05, y: imgPremio3.frame.maxY + hScreen * 0.03, width: wScreen * 0.9, height: hScreen * 0.1))
        descripcion3.text = "Crema de camaron, ensalada de manzana, salmón con corteza de parmesano con brócoli rostizado."
        descripcion3.font = UIFont(name: "Roboto-Light", size: 16)
        descripcion3.sizeToFit()
        descripcion3.isScrollEnabled = false
        descripcion3.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        secondScroll?.addSubview(descripcion3)
        
        let space = UILabel(frame: CGRect(x: 0, y: descripcion3.frame.maxY, width: wScreen, height: hScreen * 0.05))
        secondScroll?.addSubview(space)
        
        secondScroll?.contentSize = CGSize(width: wScreen, height: space.frame.maxY)
        //----------------
        
        detailContainer?.contentSize = CGSize(width: wScreen, height: container2!.frame.maxY)
    }
    
    @objc func btnParticipaPressed() {
        let triviaScreen = Preguntas()
        triviaScreen.nombreTrivia = nombreT
        triviaScreen.questionArrayT1111 = questionArrayT111
        triviaScreen.r1ArrayT1111 = r1ArrayT111
        triviaScreen.r2ArrayT1111 = r2ArrayT111
        triviaScreen.r3ArrayT1111 = r3ArrayT111
        triviaScreen.questionArrayT2222 = questionArrayT222
        triviaScreen.r1ArrayT2222 = r1ArrayT222
        triviaScreen.r2ArrayT2222 = r2ArrayT222
        triviaScreen.r3ArrayT2222 = r3ArrayT222
        triviaScreen.questionArrayT3333 = questionArrayT333
        triviaScreen.r1ArrayT3333 = r1ArrayT333
        triviaScreen.r2ArrayT3333 = r2ArrayT333
        triviaScreen.r3ArrayT3333 = r3ArrayT333
        triviaScreen.questionArrayT4444 = questionArrayT444
        triviaScreen.r1ArrayT4444 = r1ArrayT444
        triviaScreen.r2ArrayT4444 = r2ArrayT444
        triviaScreen.r3ArrayT4444 = r3ArrayT444
        triviaScreen.questionArrayT5555 = questionArrayT555
        triviaScreen.r1ArrayT5555 = r1ArrayT555
        triviaScreen.r2ArrayT5555 = r2ArrayT555
        triviaScreen.r3ArrayT5555 = r3ArrayT555
        triviaScreen.indexSelected3 = indexSelected2

        navigationController?.pushViewController(triviaScreen, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }

    
    @objc func backPressed() {
        
        navigationController?.popViewController(animated: true)
        view.removeFromSuperview()
        
    }
    
    @objc func sharePressed() {
        
        let activityController = UIActivityViewController(activityItems: ["Trivia del Mes. Descarga la app ya! \n http://somosdeli.com"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
