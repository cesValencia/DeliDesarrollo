//
//  FullTrivias.swift
//  Deli
//
//  Created by David Valencia on 27/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class FullTrivias: UIViewController {
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        cargarInterfaz()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func btnCompraPressed(){
    
        UIApplication.shared.statusBarStyle = .default
        
        let id = "test"
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)//instanciamos nuestro story
        
        let siguienteViewController = storyBoard.instantiateViewController(withIdentifier: id)
        
        //self.present(siguienteViewController, animated: true, completion: nil)//mostrar nuestro viewcontroller
        
        self.navigationController?.pushViewController(siguienteViewController, animated: true)
        
    }
    
    @objc func backPressed() {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likePressed() {
        print("Like")
    }
    
    @objc func sharePressed() {
        print("Share")
        
        let activityController = UIActivityViewController(activityItems: ["Participa en la trivia Deli para ganar experiencias gratis " + "Descarga la app ya! \n http://somosdeli.com"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func cargarInterfaz() {
        view.backgroundColor = UIColor.white
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView?.alwaysBounceVertical = false
        scrollView?.bounces = false
        view.addSubview(scrollView!)
        
        let widthFactor = view.frame.width
        let heightFractor = view.frame.height
        
        let background = UIImageView(frame: view.frame)
        background.image = UIImage(named: "TRIV-FONDO")
        scrollView?.addSubview(background)
        
        //
        let tipo_comidaL = UILabel(frame: CGRect(x: 38, y: 230, width: widthFactor-30, height: 30))
        tipo_comidaL.text = "Marzo - Mayo 2018."
        tipo_comidaL.textColor = UIColor.white
        tipo_comidaL.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 17)!
        scrollView?.addSubview(tipo_comidaL)
        //

        let nombreL = UITextView(frame: CGRect(x: 30, y: tipo_comidaL.frame.maxY + 20, width: widthFactor-60, height: 0));
        nombreL.text = "influencia inglesa en la cocina mexicana"
        nombreL.textColor = UIColor.white
        nombreL.font = UIFont(name: "Montserrat-SemiBold", size: 34)!
        nombreL.isEditable = false
        nombreL.isScrollEnabled = false
        nombreL.sizeToFit()
        nombreL.backgroundColor = UIColor(red: 255.00/255, green: 255.00/255, blue: 255.00/255, alpha: 0.00);
        scrollView?.addSubview(nombreL)
        
        let contenidoL = UITextView(frame: CGRect(x: 30, y: nombreL.frame.maxY + 15, width: widthFactor-135, height: 0));
        contenidoL.text = "Tres experiencias para 2 personas en restaurantes y bistrò participantes, patrocinada por Jhonnie Walker Blue Label."
        contenidoL.textColor = UIColor.white
        contenidoL.font = UIFont(name: "HelveticaNeue-Light", size: 17)!
        contenidoL.isEditable = false
        contenidoL.isScrollEnabled = false
        contenidoL.sizeToFit()
        contenidoL.backgroundColor = UIColor(red: 255.00/255, green: 255.00/255, blue: 255.00/255, alpha: 0.00);
        scrollView?.addSubview(contenidoL)
        
        //nombreL.layer.borderWidth = 1
        //nombreL.layer.borderColor = UIColor.black.cgColor
        
        //contenidoL.layer.borderWidth = 1
        //contenidoL.layer.borderColor = UIColor.black.cgColor
        
        //Boton precio prueba
        //let btnCompra = UIImageView(frame: CGRect(x: 30, y: contenidoL.frame.maxY + 70, width: 170, height: 40))
        //purpleLine.contentMode = .scaleAspectFit
        
        //btnCompra.image = UIImage(named: "BotonPlatino")
        
        //scrollView?.addSubview(btnCompra)
        
        let imgCompra = UIImageView(frame: CGRect(x: 30, y: contenidoL.frame.maxY + 70, width: 170, height: 43))
        imgCompra.contentMode = .scaleAspectFit
        imgCompra.image = UIImage(named: "Botontriv")
        scrollView?.addSubview(imgCompra)
        
        let btnCompra = UIButton(type: .custom)
        btnCompra.addTarget(self, action: #selector(btnCompraPressed), for: .touchUpInside)
        btnCompra.frame = CGRect(x: 30, y: contenidoL.frame.maxY + 70, width: 170, height: 43)
        scrollView?.addSubview(btnCompra)
        //Boton precio prueba
        
        let logoR = UIImageView(frame: CGRect(x: btnCompra.frame.maxX + 46, y: contenidoL.frame.maxY + 27, width: 135, height: 110))
        logoR.contentMode = .scaleAspectFit
        logoR.image = UIImage(named: "trivlogo")
        scrollView?.addSubview(logoR)

        
        let leyendaL = UILabel(frame: CGRect(x: 30, y: heightFractor-60, width: widthFactor-30, height: 30))
        leyendaL.text = "Desliza hacia abajo para más información"
        leyendaL.font = UIFont(name: "Source Sans Pro", size: 14)!
        leyendaL.textColor = UIColor.white
        scrollView?.addSubview(leyendaL)
        
        /*let back = UIButton(type: .custom)
        back.frame = CGRect(x: 20, y: 20, width: 24, height: 22)
        back.setImage(#imageLiteral(resourceName: "helpBack"), for: .normal)
        back.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        scrollView?.addSubview(back)*/
        
        //Texto 1
        let texto1 = UILabel(frame: CGRect(x: 27, y: leyendaL.frame.maxY + 58, width: 250, height: 65))
        texto1.text = "Participantes"
        
        texto1.font = UIFont(name: "Montserrat-Bold", size: 30)
        texto1.textColor = UIColor.black
        scrollView?.addSubview(texto1)
        
        //Caja 1
        let caja1 = UIView(frame: CGRect(x: 0, y: texto1.frame.maxY + 33, width: widthFactor, height: 208))
        caja1.backgroundColor = UIColor.white
        caja1.layer.borderWidth = 0.5
        caja1.layer.borderColor = UIColor.init(red:208/255, green:208/255.0, blue:208/255, alpha: 1).cgColor
        scrollView?.addSubview(caja1)
        
        //L1
        let l1 = UIView(frame: CGRect(x: 30, y: 30, width: 3, height: 75))
        l1.backgroundColor = UIColor(red: 225/255, green: 117/255, blue: 109/255, alpha: 1)
        caja1.addSubview(l1)
        
        //Título1
        let titulo1 = UILabel(frame: CGRect(x: l1.frame.maxX + 15, y: 30, width: 125, height: 18))
        titulo1.text = "DIAMANTE"
        titulo1.textColor = UIColor.lightGray
        titulo1.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 14)
        caja1.addSubview(titulo1)
        
        //Subtitulo1
        let subtitulo1 = UILabel(frame: CGRect(x: l1.frame.maxX + 15, y: titulo1.frame.maxY + 3, width: 184, height: 38))
        subtitulo1.text = "Puntarena, cocina de autor mediterránea"
        subtitulo1.numberOfLines = 2
        subtitulo1.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        subtitulo1.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        caja1.addSubview(subtitulo1)
        
        //Valor Original 1
        let valorReal1 = UILabel(frame: CGRect(x: l1.frame.maxX + 15, y: subtitulo1.frame.maxY + 9, width: 198, height: 16))
        valorReal1.text = "Para 1º Lugar"
        valorReal1.textColor = UIColor.lightGray
        valorReal1.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        caja1.addSubview(valorReal1)
        
        //Imagen de caja 1
        let imgCaja1 = UIImageView(frame: CGRect(x: valorReal1.frame.maxX + 50, y: 30, width: 82, height: 82))
        imgCaja1.layer.cornerRadius = 5.0
        imgCaja1.image = UIImage(named: "tro1")
        caja1.addSubview(imgCaja1)
        
        //Incluye 1
        let incluye1 = UILabel(frame: CGRect(x: widthFactor/2 - (widthFactor - 65)/2 + 3, y: valorReal1.frame.maxY + 25, width: widthFactor - 65, height: 41))
        incluye1.text = "Crema de camaron, ensalada de manzana, salmón con corteza de parmesano con brócoli rostizado."
        incluye1.numberOfLines = 2
        incluye1.textColor = UIColor.black
        incluye1.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        caja1.addSubview(incluye1)
        
        //Caja 2
        let caja2 = UIView(frame: CGRect(x: 0, y: caja1.frame.maxY, width: widthFactor, height: 208))
        caja2.backgroundColor = UIColor.white
        caja2.layer.borderWidth = 0.5
        caja2.layer.borderColor = UIColor.init(red:208/255, green:208/255.0, blue:208/255, alpha: 1).cgColor
        scrollView?.addSubview(caja2)
        
        //L2
        let l2 = UIView(frame: CGRect(x: 30, y: 30, width: 3, height: 75))
        l2.backgroundColor = UIColor(red: 225/255, green: 117/255, blue: 109/255, alpha: 1)
        caja2.addSubview(l2)
        
        //Título2
        let titulo2 = UILabel(frame: CGRect(x: l2.frame.maxX + 15, y: 30, width: 125, height: 18))
        titulo2.text = "DIAMANTE"
        titulo2.textColor = UIColor.lightGray
        titulo2.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 14)
        caja2.addSubview(titulo2)
        
        //Subtitulo2
        let subtitulo2 = UILabel(frame: CGRect(x: l2.frame.maxX + 15, y: titulo2.frame.maxY + 3, width: 184, height: 38))
        subtitulo2.text = "De Costa a Costa, marisquería estilo ingelsa"
        subtitulo2.numberOfLines = 2
        subtitulo2.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        subtitulo2.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        caja2.addSubview(subtitulo2)
        
        //Valor Original 2
        let valorReal2 = UILabel(frame: CGRect(x: l2.frame.maxX + 15, y: subtitulo2.frame.maxY + 9, width: 198, height: 16))
        valorReal2.text = "Para 2º Lugar"
        valorReal2.textColor = UIColor.lightGray
        valorReal2.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        caja2.addSubview(valorReal2)
        
        //Imagen de caja 1
        let imgCaja2 = UIImageView(frame: CGRect(x: valorReal2.frame.maxX + 50, y: 30, width: 82, height: 82))
        imgCaja2.layer.cornerRadius = 5.0
        imgCaja2.image = UIImage(named: "tro2")
        caja2.addSubview(imgCaja2)
        
        //Incluye 1
        let incluye2 = UILabel(frame: CGRect(x: widthFactor/2 - (widthFactor - 65)/2 + 3, y: valorReal2.frame.maxY + 25, width: widthFactor - 65, height: 41))
        incluye2.text = "Calamares rebosados bañados en deep de queso roquefort y una orden de langosta al vapor."
        incluye2.numberOfLines = 2
        incluye2.textColor = UIColor.black
        incluye2.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        caja2.addSubview(incluye2)
        
        //Caja 3
        let caja3 = UIView(frame: CGRect(x: 0, y: caja2.frame.maxY, width: widthFactor, height: 208))
        caja3.backgroundColor = UIColor.white
        caja3.layer.borderWidth = 0.5
        caja3.layer.borderColor = UIColor.init(red:208/255, green:208/255.0, blue:208/255, alpha: 1).cgColor
        scrollView?.addSubview(caja3)
        
        //L3
        let l3 = UIView(frame: CGRect(x: 30, y: 30, width: 3, height: 75))
        l3.backgroundColor = UIColor(red: 225/255, green: 117/255, blue: 109/255, alpha: 1)
        caja3.addSubview(l3)
        
        //Título3
        let titulo3 = UILabel(frame: CGRect(x: l3.frame.maxX + 15, y: 30, width: 125, height: 18))
        titulo3.text = "DIAMANTE"
        titulo3.textColor = UIColor.lightGray
        titulo3.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 14)
        caja3.addSubview(titulo3)
        
        //Subtitulo3
        let subtitulo3 = UILabel(frame: CGRect(x: l3.frame.maxX + 15, y: titulo3.frame.maxY + 3, width: 184, height: 38))
        subtitulo3.text = "Coyote Wings Snack Bar, cocina americana en tu mesa"
        subtitulo3.numberOfLines = 2
        subtitulo3.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        subtitulo3.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        caja3.addSubview(subtitulo3)
        
        //Valor Original 3
        let valorReal3 = UILabel(frame: CGRect(x: l3.frame.maxX + 15, y: subtitulo3.frame.maxY + 9, width: 198, height: 16))
        valorReal3.text = "Para 3º Lugar"
        valorReal3.textColor = UIColor.lightGray
        valorReal3.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        caja3.addSubview(valorReal3)
        
        //Imagen de caja 3
        let imgCaja3 = UIImageView(frame: CGRect(x: valorReal3.frame.maxX + 50, y: 30, width: 82, height: 82))
        imgCaja3.layer.cornerRadius = 5.0
        imgCaja3.image = UIImage(named: "tro3")
        caja3.addSubview(imgCaja3)
        
        //Incluye 3
        let incluye3 = UILabel(frame: CGRect(x: widthFactor/2 - (widthFactor - 65)/2 + 3, y: valorReal3.frame.maxY + 25, width: widthFactor - 65, height: 41))
        incluye3.text = "Una orden de alitas de buffalo y coctail de gin con jugo de maracuyá."
        incluye3.numberOfLines = 2
        incluye3.textColor = UIColor.black
        incluye3.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        caja3.addSubview(incluye3)
        
        //Footer
        let footerRuta = UIImageView(frame: CGRect(x: 0, y: caja3.frame.maxY, width: widthFactor, height: 163))
        footerRuta.image = UIImage(named: "triviFooter")
        scrollView?.addSubview(footerRuta)
        
        let random = UILabel(frame: CGRect(x: 0, y: footerRuta.frame.maxY, width: widthFactor, height: 30))
        
        scrollView?.addSubview(random)
        
        //último
        scrollView?.contentSize = CGSize(width: widthFactor, height: random.frame.maxY)
        
        //NavigationBar
        
        let backButton = UIButton(type: UIButtonType.system)
        backButton.frame = CGRect(x: 20, y: 20, width: 24, height: 22)
        backButton.tintColor = .white
        backButton.setBackgroundImage(#imageLiteral(resourceName: "back_icon"), for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(backPressed), for: UIControlEvents.touchUpInside)
        scrollView?.addSubview(backButton)
        

        
        
        let likeB = UIButton(type: UIButtonType.system)
        likeB.frame = CGRect(x: widthFactor-100, y: 20, width: 25, height: 25)
        let originalLikeImage = #imageLiteral(resourceName: "heart")
        let tintedLikeImage = originalLikeImage.withRenderingMode(.alwaysTemplate)
        likeB.tintColor = .white
        likeB.setBackgroundImage(tintedLikeImage, for: UIControlState.normal)
        likeB.addTarget(self, action: #selector(likePressed), for: UIControlEvents.touchUpInside)
        scrollView?.addSubview(likeB)
        
        
        let shareB = UIButton(type: UIButtonType.system)
        shareB.frame = CGRect(x: likeB.frame.maxX+31, y: 20, width: 18, height: 25)
        let originalShareImage = #imageLiteral(resourceName: "Share")
        let tintedShareImage = originalShareImage.withRenderingMode(.alwaysTemplate)
        shareB.setBackgroundImage(tintedShareImage, for: UIControlState.normal)
        shareB.tintColor = .white
        shareB.addTarget(self, action: #selector(sharePressed), for: UIControlEvents.touchUpInside)
        scrollView?.addSubview(shareB)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        statusBar.backgroundColor = UIColor.black.withAlphaComponent(1)
        view.addSubview(statusBar)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

