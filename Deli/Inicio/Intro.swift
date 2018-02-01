//
//  Intro.swift
//  Deli
//
//  Created by David Valencia on 02/12/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import AVKit

class Intro: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, URL_SessionDelegate{
    
    var videoPLayer: AVPlayerViewController?
    var languageSelect: UIView?
    var tuIdioma: UILabel?
    var espBtn: UIButton?
    var enBtn: UIButton?
    var tutorialContainer: UIScrollView?
    var v1: UIView?
    var v2: UIView?
    var v3: UIView?
    var v4: UIView?
    var swipeGesture: UISwipeGestureRecognizer?
    var signView: UIView?
    var logo: UIImageView?
    var userTF: UITextField?
    var mailTF: UITextField?
    var passwordTF: UITextField?
    var l1: UIView?
    var l2: UIView?
    var l3: UIView?
    var inBtn: UIButton?
    var upBtn: UIButton?
    var fbBtn: UIButton?
    var terminos: UILabel?
    var tienes: UILabel?
    var noTienes: UILabel?
    var toIn: UIButton?
    var toUp: UIButton?
    var pageController: UIPageControl?
    var blurEffect: UIBlurEffect?
    var blurEffectView: UIVisualEffectView?
    var borderView: UIView?
    var botView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cambiando color de statusbar
        UIApplication.shared.statusBarStyle = .lightContent
        
        loadUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUI() {
        
        //Cargando videoBackground
        videoPLayer = AVPlayerViewController()
        videoPLayer?.view.frame = view.frame
        
        let videoPath = Bundle.main.path(forResource: "deli", ofType: "mov")
        let urlPath = URL(fileURLWithPath: videoPath!)
        
        videoPLayer?.player = AVPlayer(url: urlPath)
        videoPLayer?.showsPlaybackControls = false
        videoPLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        videoPLayer?.player?.actionAtItemEnd = .pause
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPLayer!.player!.currentItem!)
        view.addSubview(videoPLayer!.view)
        videoPLayer?.player?.play()
        //Cargando videBackground
        
        // Blur Effect
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0
        view.addSubview(blurEffectView!)
        // Blur Effect
        
        //Vista que contiene la selección de lenguaje
        languageSelect = UIView(frame: view.frame)
        languageSelect?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(languageSelect!)
        //Vista que contiene la selección de lenguaje
        
        //Botones de selección de idioma
        tuIdioma = UILabel(frame: CGRect(x: wScreen * 0.1, y: hScreen * 0.8, width: wScreen * 0.2, height: hScreen * 0.03))
        tuIdioma?.textColor = UIColor.white
        tuIdioma?.text = "TU IDIOMA"
        tuIdioma?.font = UIFont(name: "Didot-Bold", size: 12)
        languageSelect?.addSubview(tuIdioma!)
        
        espBtn = UIButton(type: UIButtonType.system)
        espBtn?.frame = CGRect(x: wScreen * 0.1, y: tuIdioma!.frame.maxY + 9, width: wScreen * 0.33, height: hScreen * 0.05)
        espBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        espBtn?.setTitle("español", for: UIControlState.normal)
        espBtn?.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 30)
        espBtn?.addTarget(self, action: #selector(espBtnP), for: UIControlEvents.touchUpInside)
        languageSelect?.addSubview(espBtn!)
        
        enBtn = UIButton(type: UIButtonType.system)
        enBtn?.frame = CGRect(x: espBtn!.frame.maxX + 15, y: tuIdioma!.frame.maxY + 9, width: wScreen * 0.3, height: hScreen * 0.05)
        enBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        enBtn?.setTitle("english", for: UIControlState.normal)
        enBtn?.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 30)
        enBtn?.addTarget(self, action: #selector(enBtnP), for: UIControlEvents.touchUpInside)
        languageSelect?.addSubview(enBtn!)
        //Botones de selección de idioma
        
        //Contenedor de las vistas del tutorial
        tutorialContainer = UIScrollView(frame: view.frame)
        tutorialContainer?.delegate = self
        tutorialContainer?.isPagingEnabled = true
        tutorialContainer?.bounces = false
        tutorialContainer?.alpha = 0
        view.addSubview(tutorialContainer!)
        //Contenedor de las vistas del tutorial
        
        // UIPageControl
        pageController = UIPageControl(frame: CGRect(x: view.frame.width * 0.7, y: view.frame.height * 0.8, width: 100, height: 200))
        pageController?.currentPage = 0
        pageController?.numberOfPages = 4
        view.addSubview(pageController!)
        
        //Vistas del tutorial
        v1 = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        tutorialContainer?.addSubview(v1!)
        
        let rubro1 = UILabel(frame: CGRect(x: wScreen * 0.1, y: hScreen * 0.65, width: wScreen * 0.4, height: hScreen * 0.03))
        rubro1.text = "TU ELIGES"
        rubro1.textColor = UIColor.white
        rubro1.font = UIFont(name: "Didot-Bold", size: 13)
        v1?.addSubview(rubro1)
        
        let mensaje1 = UILabel(frame: CGRect(x: wScreen * 0.1, y: rubro1.frame.maxY, width: wScreen * 0.7, height: hScreen * 0.15))
        mensaje1.text = "Experiencia, ruta o trivia del mes?"
        mensaje1.textColor = UIColor.white
        mensaje1.font = UIFont(name: "Montserrat-Bold", size: 30)
        mensaje1.numberOfLines = 0
        mensaje1.adjustsFontSizeToFitWidth = true
        v1?.addSubview(mensaje1)
        
        let parrafo1 = UILabel(frame: CGRect(x: wScreen * 0.1, y: mensaje1.frame.maxY, width: wScreen * 0.5, height: hScreen * 0.05))
        parrafo1.text = "Disfruta de un 50% off los 365 días del año."
        parrafo1.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        parrafo1.textColor = UIColor.white
        parrafo1.adjustsFontSizeToFitWidth = true
        parrafo1.numberOfLines = 0
        v1?.addSubview(parrafo1)
        
        v2 = UIView(frame: CGRect(x: v1!.frame.maxX, y: 0, width: wScreen, height: hScreen))
        tutorialContainer?.addSubview(v2!)
        
        let rubro2 = UILabel(frame: CGRect(x: wScreen * 0.1, y: hScreen * 0.65, width: wScreen * 0.4, height: hScreen * 0.03))
        rubro2.text = "GEOLOCALIZACIÓN"
        rubro2.textColor = UIColor.white
        rubro2.font = UIFont(name: "Didot-Bold", size: 13)
        v2?.addSubview(rubro2)
        
        let mensaje2 = UILabel(frame: CGRect(x: wScreen * 0.1, y: rubro2.frame.maxY, width: wScreen * 0.7, height: hScreen * 0.15))
        mensaje2.text = "Encuentra cerca de ti"
        mensaje2.textColor = UIColor.white
        mensaje2.font = UIFont(name: "Montserrat-Bold", size: 30)
        mensaje2.numberOfLines = 0
        mensaje2.adjustsFontSizeToFitWidth = true
        v2?.addSubview(mensaje2)
        
        let parrafo2 = UILabel(frame: CGRect(x: wScreen * 0.1, y: mensaje2.frame.maxY, width: wScreen * 0.5, height: hScreen * 0.05))
        parrafo2.text = "Activando tu geolocalización disfruta lo mejor."
        parrafo2.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        parrafo2.textColor = UIColor.white
        parrafo2.adjustsFontSizeToFitWidth = true
        parrafo2.numberOfLines = 0
        v2?.addSubview(parrafo2)
        
        v3 = UIView(frame: CGRect(x: v2!.frame.maxX, y: 0, width: wScreen, height: hScreen))
        tutorialContainer?.addSubview(v3!)
        
        let rubro3 = UILabel(frame: CGRect(x: wScreen * 0.1, y: hScreen * 0.65, width: wScreen * 0.4, height: hScreen * 0.03))
        rubro3.text = "REGALOS"
        rubro3.textColor = UIColor.white
        rubro3.font = UIFont(name: "Didot-Bold", size: 13)
        v3?.addSubview(rubro3)
        
        let mensaje3 = UILabel(frame: CGRect(x: wScreen * 0.1, y: rubro3.frame.maxY, width: wScreen * 0.7, height: hScreen * 0.15))
        mensaje3.text = "Envía y recibe los mejores regalos"
        mensaje3.textColor = UIColor.white
        mensaje3.font = UIFont(name: "Montserrat-Bold", size: 30)
        mensaje3.numberOfLines = 0
        mensaje3.adjustsFontSizeToFitWidth = true
        v3?.addSubview(mensaje3)
        
        let parrafo3 = UILabel(frame: CGRect(x: wScreen * 0.1, y: mensaje3.frame.maxY, width: wScreen * 0.5, height: hScreen * 0.05))
        parrafo3.text = "Activando tu geolocalización disfruta lo mejor."
        parrafo3.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        parrafo3.textColor = UIColor.white
        parrafo3.adjustsFontSizeToFitWidth = true
        parrafo3.numberOfLines = 0
        v3?.addSubview(parrafo3)
        
        v4 = UIView(frame: CGRect(x: v3!.frame.maxX, y: 0, width: wScreen, height: hScreen))
        tutorialContainer?.addSubview(v4!)
        
        let rubro4 = UILabel(frame: CGRect(x: wScreen * 0.1, y: hScreen * 0.65, width: wScreen * 0.4, height: hScreen * 0.03))
        rubro4.text = "TRIVIAS"
        rubro4.textColor = UIColor.white
        rubro4.font = UIFont(name: "Didot-Bold", size: 13)
        v4?.addSubview(rubro4)
        
        let mensaje4 = UILabel(frame: CGRect(x: wScreen * 0.1, y: rubro4.frame.maxY, width: wScreen * 0.7, height: hScreen * 0.15))
        mensaje4.text = "Participa en las trivias del mes"
        mensaje4.textColor = UIColor.white
        mensaje4.font = UIFont(name: "Montserrat-Bold", size: 30)
        mensaje4.numberOfLines = 0
        mensaje4.adjustsFontSizeToFitWidth = true
        v4?.addSubview(mensaje4)
        
        let parrafo4 = UILabel(frame: CGRect(x: wScreen * 0.1, y: mensaje4.frame.maxY, width: wScreen * 0.5, height: hScreen * 0.05))
        parrafo4.text = "Activando tu geolocalización disfruta lo mejor."
        parrafo4.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        parrafo4.textColor = UIColor.white
        parrafo4.adjustsFontSizeToFitWidth = true
        parrafo4.numberOfLines = 0
        v4?.addSubview(parrafo4)
        
        tutorialContainer?.contentSize = CGSize(width: v4!.frame.maxX, height: hScreen)
        //Vistas del tutorial
        
        //Gesto qeu finaliza tutorial
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipePressed))
        swipeGesture?.direction = .left
        
        //Gesto que finaliza tutorial
        
        //Vista de SignIn/SingUp
        signView = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        signView?.alpha = 0
        view.addSubview(signView!)
        
        logo = UIImageView(frame: CGRect(x: wScreen * 0.275, y: hScreen * 0.13, width: wScreen * 0.42, height: wScreen * 0.24))
        logo?.image = #imageLiteral(resourceName: "logoini")
        signView?.addSubview(logo!)
        
        userTF = UITextField(frame: CGRect(x: wScreen * 0.1, y: logo!.frame.maxY + hScreen * 0.08, width: wScreen * 0.8, height: hScreen * 0.05))
        userTF?.attributedPlaceholder = NSAttributedString(string: "Nombre de Usuario", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        userTF?.font = UIFont(name: "SourceSansPro-Regular", size: 14)
        userTF?.delegate = self
        userTF?.keyboardType = .alphabet
        userTF?.keyboardAppearance = .dark
        userTF?.returnKeyType = .next
        userTF?.borderStyle = .roundedRect
        userTF?.textColor = UIColor.white
        userTF?.backgroundColor = UIColor.white.withAlphaComponent(0)
        userTF?.borderStyle = .none
        userTF?.clearsOnBeginEditing = true
        signView?.addSubview(userTF!)
        
        l1 = UIView(frame: CGRect(x: wScreen * 0.1, y: userTF!.frame.maxY + wScreen * 0.02, width: wScreen * 0.8, height: 1))
        l1?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        signView?.addSubview(l1!)
        
        mailTF = UITextField(frame: CGRect(x: wScreen * 0.1, y: l1!.frame.maxY + hScreen * 0.03, width: wScreen * 0.8, height: hScreen * 0.05))
        mailTF?.attributedPlaceholder = NSAttributedString(string: "Correo Electrónico", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        mailTF?.font = UIFont(name: "SourceSansPro-Regular", size: 14)
        mailTF?.delegate = self
        mailTF?.keyboardType = .emailAddress
        mailTF?.autocapitalizationType = .none
        mailTF?.keyboardAppearance = .dark
        mailTF?.returnKeyType = .next
        mailTF?.borderStyle = .roundedRect
        mailTF?.textColor = UIColor.white
        mailTF?.backgroundColor = UIColor.white.withAlphaComponent(0)
        mailTF?.borderStyle = .none
        signView?.addSubview(mailTF!)
        
        l2 = UIView(frame: CGRect(x: wScreen * 0.1, y: mailTF!.frame.maxY + wScreen * 0.02, width: wScreen * 0.8, height: 1))
        l2?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        signView?.addSubview(l2!)
        
        passwordTF = UITextField(frame: CGRect(x: wScreen * 0.1, y: l2!.frame.maxY + hScreen * 0.03, width: wScreen * 0.8, height: hScreen * 0.05))
        passwordTF?.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        passwordTF?.font = UIFont(name: "SourceSansPro-Regular", size: 14)
        passwordTF?.delegate = self
        passwordTF?.keyboardType = .alphabet
        passwordTF?.keyboardAppearance = .dark
        passwordTF?.returnKeyType = .next
        passwordTF?.borderStyle = .roundedRect
        passwordTF?.textColor = UIColor.white
        passwordTF?.isSecureTextEntry = true
        passwordTF?.backgroundColor = UIColor.white.withAlphaComponent(0)
        passwordTF?.borderStyle = .none
        signView?.addSubview(passwordTF!)
        
        l3 = UIView(frame: CGRect(x: wScreen * 0.1, y: passwordTF!.frame.maxY + wScreen * 0.02, width: wScreen * 0.8, height: 1))
        l3?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        signView?.addSubview(l3!)
        
        inBtn = UIButton(type: UIButtonType.custom)
        inBtn?.frame = CGRect(x: wScreen * 0.1, y: l3!.frame.maxY + hScreen * 0.06, width: wScreen * 0.8, height: hScreen * 0.08)
        inBtn?.setImage(#imageLiteral(resourceName: "btnsl2"), for: UIControlState.normal)
        inBtn?.addTarget(self, action: #selector(inPressed), for: UIControlEvents.touchUpInside)
        inBtn?.alpha = 0
        signView?.addSubview(inBtn!)
        
        upBtn = UIButton(type: UIButtonType.custom)
        upBtn?.frame = CGRect(x: wScreen * 0.1, y: l3!.frame.maxY + hScreen * 0.06, width: wScreen * 0.8, height: hScreen * 0.08)
        upBtn?.setImage(#imageLiteral(resourceName: "btnsl1"), for: UIControlState.normal)
        upBtn?.addTarget(self, action: #selector(upPressed), for: UIControlEvents.touchUpInside)
        signView?.addSubview(upBtn!)
        
        fbBtn = UIButton(type: UIButtonType.custom)
        fbBtn?.frame = CGRect(x: wScreen * 0.1, y: inBtn!.frame.maxY + hScreen * 0.02, width: wScreen * 0.8, height: hScreen * 0.08)
        fbBtn?.setImage(#imageLiteral(resourceName: "btnfc"), for: UIControlState.normal)
        fbBtn?.addTarget(self, action: #selector(fbPressed), for: UIControlEvents.touchUpInside)
        signView?.addSubview(fbBtn!)
        
        terminos = UILabel(frame: CGRect(x: wScreen * 0.25, y: fbBtn!.frame.maxY + hScreen * 0.027, width: wScreen * 0.5, height: hScreen * 0.02))
        terminos?.text = "Acepto Términos y Condiciones de Uso"
        terminos?.font = UIFont(name: "Montserrat-Bold", size: 12.8)
        terminos?.textColor = UIColor.white.withAlphaComponent(0.8)
        terminos?.adjustsFontSizeToFitWidth = true
        signView?.addSubview(terminos!)
        
        borderView = UIView(frame: CGRect(x: 0, y: hScreen * 0.919, width: wScreen, height: hScreen * 0.001))
        borderView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        signView?.addSubview(borderView!)
        
        botView = UIView(frame: CGRect(x: 0, y: borderView!.frame.maxY, width: wScreen, height: hScreen * 0.08))
        botView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        signView?.addSubview(botView!)
        
        toUp = UIButton(type: UIButtonType.system)
        toUp?.frame = CGRect(x: 0, y: 0, width: wScreen * 0.5, height: hScreen * 0.08)
        toUp?.setTitle("Crear cuenta", for: UIControlState.normal)
        toUp?.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 13.5)
        toUp?.titleLabel?.font = toUp?.titleLabel?.font.withSize(12)
        toUp?.setTitleColor(toSignColor, for: UIControlState.normal)
        toUp?.addTarget(self, action: #selector(toUpPressed), for: UIControlEvents.touchUpInside)
        toUp?.titleLabel?.sizeToFit()
        toUp?.titleLabel?.textColor = UIColor.white
        botView?.addSubview(toUp!)
        
        toIn = UIButton(type: UIButtonType.system)
        toIn?.frame = CGRect(x: toUp!.frame.maxX, y: 0, width: wScreen * 0.5, height: hScreen * 0.08)
        toIn?.setTitle("Ya tengo cuenta", for: UIControlState.normal)
        toIn?.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 13.5)
        toIn?.titleLabel?.font = toIn?.titleLabel?.font.withSize(12)
        toIn?.setTitleColor(toSignColor.withAlphaComponent(0.3), for: UIControlState.normal)
        toIn?.addTarget(self, action: #selector(toInPressed), for: UIControlEvents.touchUpInside)
        toIn?.titleLabel?.sizeToFit()
        botView?.addSubview(toIn!)
        //Vista de SignIn/SingUp
        
    }
    
    
    // Funciones de protocolo para realizar el POST a la base de datos
    func connectionFinishWithError(session: URL_Session, error: Error) {
        print(error.localizedDescription)
    }
    
    func connectionFinishSuccessfull(session: URL_Session, response: NSDictionary) {
        print(response)
        
        let mensaje = response["msg"] as? String ?? "El correo ya ha sido registrado, inténtelo nuevamente!"
        let token = response["token"] as? String ?? "El token ya ha sido asignado"
        
        print(token)
        print(mensaje)
        
        if mensaje == "Usuario logueado satisfactoriamente" || mensaje == "Usuario agregado con exito!!!" {
            
            let nextVc = TipoComida()
            //            nextVc.pass = token
            present(nextVc, animated: true, completion: nil)
        } else {
            
            let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        
        
    }
    // Funciones de protocolo para realizar el POST a la base de datos
    
    //Función que permite la reproducción en ciclo del video
    @objc func videoDidFinish(notification: Notification) {
        
        let playerItem = notification.object as? AVPlayerItem
        playerItem?.seek(to: kCMTimeZero)
        videoPLayer?.player?.isMuted = true
    }
    //Función que permite la reproducción en ciclo del video
    
    //Función para bloquear el scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == UIScreen.main.bounds.width * 0 {
            pageController?.currentPage = 0
        } else if scrollView.contentOffset.x == UIScreen.main.bounds.width * 1 {
            pageController?.currentPage = 1
        } else if scrollView.contentOffset.x == UIScreen.main.bounds.width * 2 {
            pageController?.currentPage = 2
        } else if scrollView.contentOffset.x == UIScreen.main.bounds.width * 3 {
            pageController?.currentPage = 3
            scrollView.isScrollEnabled = false
            tutorialContainer?.addGestureRecognizer(swipeGesture!)
        }
            

    }
    //Función para bloquear el scroll
    
    //Función de botones de español e inglés
    @objc func espBtnP() {
        
        UIView.animate(withDuration: 1, animations: {
            self.languageSelect?.alpha = 0
            
        }) { (true) in
            
            UIView.animate(withDuration: 1, animations: {
                self.tutorialContainer?.alpha = 1
            }, completion: { (true) in
                
            })
        }
        
    }
    
    @objc func enBtnP() {
        
    }
    
    @objc func swipePressed() {
        
//        UIView.animate(withDuration: 1, animations: {
//            self.tutorialContainer?.alpha = 0
//            self.pageController?.removeFromSuperview()
//
//        }) { (true) in
//
//            UIView.animate(withDuration: 1, animations: {
//                self.signView?.alpha = 1
//                self.blurEffectView?.alpha = 0.2
//
//            }, completion: { (true) in
//
//            })
//        }
        videoPLayer?.player?.pause()
        let loginController = Login()
        self.present(loginController, animated: true, completion: nil)
        
    }
    //Función de botones de español
    
    //Función para los focos de los textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTF {
            mailTF?.becomeFirstResponder() //becomeFirstResponder da el foco al elemento
        } else if textField == mailTF{
            passwordTF?.becomeFirstResponder()
        } else {
            passwordTF?.resignFirstResponder() //resignFirstResponder desiste de ser el foco
        }
        
        return true
    }
    //Función para los focos de los textfield
    
    //Funciones los botones de SignIn y SignUp
    @objc func inPressed() {
        
        //Almacenando y enviando los datos ingresados para el login
        let miMail: String? = mailTF?.text
        let token: String? = passwordTF?.text
        
        let networkLogin = URL_Session()
        networkLogin.delegate = self
        networkLogin.logear(con: token!, con: miMail!)
        
        mailTF?.text = ""
        passwordTF?.text = ""
        
        videoPLayer?.player?.pause()

        //Almacenando y enviando los datos ingresados para el login
    }
    
    @objc func upPressed() {
        
        //Almacenando y enviando los datos ingresados para el registro
        let newUser: String? = userTF?.text
        let newMail: String? = mailTF?.text
        let newPass: String? = passwordTF?.text
        
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        
        
        if (newPass?.count)! < 5 {
            
            let mensaje = "La contraseña no debe contener menos de 5 caracteres"
            
            let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        } else if newUser?.count == 0 || newMail?.count == 0 || newPass?.count == 0 {
            
            let mensaje = "Todos los campos son obligatorios"
            
            let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        } else if emailTest.evaluate(with: newMail) == false {
            
            let mensaje = "El correo es inválido"
            
            let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        } else {
            
            let networkManager = URL_Session()
            networkManager.delegate = self
            networkManager.registrar(para: newUser!, con: newPass!, con: newMail!)
            
            userTF?.text = ""
            mailTF?.text = ""
            passwordTF?.text = ""
        }
        
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    // MARK: Funciones de Protocolo de FBSDKButtonDelegate

    // MARK: Funciones de Protocolo de FBSDKButtonDelegate
    
    @objc func fbPressed() {
        
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    self.videoPLayer?.player?.pause()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    
                    print(result ?? "")
                    let newVC = TipoComida()
                    self.present(newVC, animated: true, completion: nil)
                }

            })
        }
    }
    
    @objc func toInPressed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.userTF?.frame = CGRect(x: wScreen * 0.1, y: self.l1!.frame.maxY + hScreen * 0.03, width: wScreen * 0.8, height: hScreen * 0.05)
            self.l1?.frame = CGRect(x: wScreen * 0.1, y: self.mailTF!.frame.maxY + wScreen * 0.02, width: wScreen * 0.8, height: 1)
            self.userTF?.alpha = 0
            self.l1?.alpha = 0
            self.noTienes?.alpha = 1
            self.inBtn?.alpha = 1
            self.upBtn?.alpha = 0
            self.toIn?.setTitleColor(toSignColor, for: .normal)
            self.toUp?.setTitleColor(toSignColor.withAlphaComponent(0.3), for: .normal)
        }) { (true) in
            
        }
    }
    
    @objc func toUpPressed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.userTF?.frame = CGRect(x: wScreen * 0.1, y: self.logo!.frame.maxY + hScreen * 0.08, width: wScreen * 0.8, height: hScreen * 0.05)
            self.l1?.frame = CGRect(x: wScreen * 0.1, y: self.userTF!.frame.maxY + wScreen * 0.02, width: wScreen * 0.8, height: 1)
            self.userTF?.alpha = 1
            self.l1?.alpha = 1
            self.inBtn?.alpha = 0
            self.upBtn?.alpha = 1
            self.toIn?.setTitleColor(toSignColor.withAlphaComponent(0.3), for: .normal)
            self.toUp?.setTitleColor(toSignColor, for: .normal)
        }) { (true) in
            
        }
    }
    //Funciones los botones de SignIn y SignUp
}
