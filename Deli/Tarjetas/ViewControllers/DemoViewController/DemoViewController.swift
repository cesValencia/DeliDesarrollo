//
//  DemoViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoViewController: ExpandingViewController {
  
     typealias ItemInfo = (imageName: String, title: String, texto: String, texto3: String, texto4: String)
  fileprivate var cellsIsOpen = [Bool]()

    
    fileprivate var items: [ItemInfo] = [("expc1", "Compra individual", "Experiencia", "", ""),
                                         ("Expc2", "Compra por paquete", "Ruta Menú", "", ""),
                                         ("Expc5", "Del mes", "Trivias", "", "")]
  
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
    
    var menuBG = UIView()
    var menuContent = UIView()
    var swipeGesture: UISwipeGestureRecognizer?
    var username: UILabel?
    var usermail: UILabel?
    var tapGesture: UITapGestureRecognizer?
    
  var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var avatarImg: UIImageView?
    
    var triviaIds = [String]()
    var triviaNames = [String]()
    var triviaStatus = [String]()
    var triviaFecha = [String]()
    var triviaIncluye = [String]()
    var triviaVigencia = [String]()
    var triviaPremio = [String]()
    var triviaLogoB = [String]()
    var triviaLogoN = [String]()
    var triviaImgP = [String]()
    var questionArrayT1 = [String]()
    var r1ArrayT1 = [String]()
    var r2ArrayT1 = [String]()
    var r3ArrayT1 = [String]()
    var questionArrayT2 = [String]()
    var r1ArrayT2 = [String]()
    var r2ArrayT2 = [String]()
    var r3ArrayT2 = [String]()
    var questionArrayT3 = [String]()
    var r1ArrayT3 = [String]()
    var r2ArrayT3 = [String]()
    var r3ArrayT3 = [String]()
    var questionArrayT4 = [String]()
    var r1ArrayT4 = [String]()
    var r2ArrayT4 = [String]()
    var r3ArrayT4 = [String]()
    var questionArrayT5 = [String]()
    var r1ArrayT5 = [String]()
    var r2ArrayT5 = [String]()
    var r3ArrayT5 = [String]()
    var prueba = [NSDictionary]()
    var centinela = 1
}

// MARK: - Lifecycle 🌎
extension DemoViewController {
  
    
  override func viewDidLoad() {
    itemSize = CGSize(width: 256, height: 357)
    super.viewDidLoad()
    
    statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
    UIApplication.shared.statusBarStyle = .lightContent
    
    /*Transparent navigation bar*/
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    let search = UIButton(type: .custom)
    search.frame = CGRect(x: wScreen * 0.06, y: hScreen * 0.05, width: wScreen * 0.88, height: hScreen * 0.056)
    search.setImage(#imageLiteral(resourceName: "busb"), for: .normal)
    search.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    view.addSubview(search)
    
    let markerBtn = UIButton(type: .custom)
    markerBtn.frame = CGRect(x: view.frame.width - 110, y: view.frame.height - 110, width: 90, height: 90)
    markerBtn.setImage(#imageLiteral(resourceName: "buscl"), for: .normal)
    markerBtn.addTarget(self, action: #selector(markerPressed), for: .touchUpInside)
    view.addSubview(markerBtn)
    
    let tituloMenu = UILabel(frame: CGRect(x: wScreen * 0.35, y: hScreen * 0.93, width: wScreen * 0.3, height: wScreen * 0.05))
    tituloMenu.text = "M E N Ú"
    tituloMenu.textAlignment = .center
    tituloMenu.textColor = UIColor.white
    tituloMenu.font = UIFont(name: "Roboto-Bold", size: 12)
//    tituloMenu.backgroundColor = .black
    view.addSubview(tituloMenu)
    
    let menu = UIButton(type: .custom)
    menu.frame = CGRect(x: wScreen * 0.3, y: hScreen * 0.78, width: wScreen * 0.4, height: hScreen * 0.3)
    menu.setImage(#imageLiteral(resourceName: "menurt"), for: .normal)
    menu.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
    view.addSubview(menu)
    
    getData()
    loadMenu()
    registerCell()
    fillCellIsOpenArray()
    addGesture(to: collectionView!)
    configureNavBar()
  }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        


    }
    
    //Serializando JSON
    func getData() {
        let url = URL(string: "http://104.236.10.17/api/trivias/") // se convirete el string url a untipo de dato URL
        
        var request = URLRequest(url: url!) //inicializacion del Request
        request.httpMethod = "GET" //tipo de peticion
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
                print("Ocurrio un error al obtener el json")
            }
            
            do{
                //control de errores desconocidos (TRY) en la serializacion del json
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Any> {
                    for obj in json {
                        let objAux = obj as! NSDictionary
                        
                        if let id = objAux["id"] as? String {
                            self.triviaIds.append(id)
                        }
                        if let name = objAux["name"] as? String {
                            self.triviaNames.append(name)
                        }
                        if let status = objAux["status"] as? String {
                            self.triviaStatus.append(status)
                        }
                        if let fecha = objAux["fecha"] as? String {
                            self.triviaFecha.append(fecha)
                        }
                        if let incluye = objAux["incluye"] as? String {
                            self.triviaIncluye.append(incluye)
                        }
                        if let vigencia = objAux["vigencia"] as? String {
                            self.triviaVigencia.append(vigencia)
                        }
                        if let premio = objAux["premio"] as? String {
                            self.triviaPremio.append(premio)
                        }
                        if let logoB = objAux["logoB"] as? String {
                            self.triviaLogoB.append(logoB)
                        }
                        if let logoN = objAux["logoN"] as? String {
                            self.triviaLogoN.append(logoN)
                        }
                        if let imgP = objAux["imgP"] as? String {
                            self.triviaImgP.append(imgP)
                        }
                        
                        if let p = objAux["content"] as? NSDictionary {
                            self.prueba.append(p)
                        }
                        
                    }
                    
                    for triv in self.prueba {
                        
                        let s = triv
                        
                        if self.centinela == 1 {
                            
                            var contador = 1
                            
                            while contador <= 10 {
                                
                                if let pre = s[String(contador)] as? NSDictionary {
                                    
                                    if let quest = pre["question"] as? String {
                                        self.questionArrayT1.append(quest)
                                    }
                                    if let re1 = pre["asw1"] as? String {
                                        self.r1ArrayT1.append(re1)
                                    }
                                    if let re2 = pre["asw2"] as? String {
                                        self.r2ArrayT1.append(re2)
                                    }
                                    if let re3 = pre["asw3"] as? String {
                                        self.r3ArrayT1.append(re3)
                                    }
                                }
                                
                                contador += 1
                            }
                        } else if self.centinela == 2 {
                            
                            var contador2 = 1
                            
                            while contador2 <= 10 {
                                
                                if let pre = s[String(contador2)] as? NSDictionary {
                                    
                                    if let quest = pre["question"] as? String {
                                        self.questionArrayT2.append(quest)
                                    }
                                    if let re1 = pre["asw1"] as? String {
                                        self.r1ArrayT2.append(re1)
                                    }
                                    if let re2 = pre["asw2"] as? String {
                                        self.r2ArrayT2.append(re2)
                                    }
                                    if let re3 = pre["asw3"] as? String {
                                        self.r3ArrayT2.append(re3)
                                    }
                                }
                                
                                contador2 += 1
                            }
                        } else if self.centinela == 3 {
                            
                            var contador3 = 1
                            
                            while contador3 <= 10 {
                                
                                if let pre = s[String(contador3)] as? NSDictionary {
                                    
                                    if let quest = pre["question"] as? String {
                                        self.questionArrayT3.append(quest)
                                    }
                                    if let re1 = pre["asw1"] as? String {
                                        self.r1ArrayT3.append(re1)
                                    }
                                    if let re2 = pre["asw2"] as? String {
                                        self.r2ArrayT3.append(re2)
                                    }
                                    if let re3 = pre["asw3"] as? String {
                                        self.r3ArrayT3.append(re3)
                                    }
                                }
                                
                                contador3 += 1
                            }
                        } else if self.centinela == 4 {
                            
                            var contador4 = 1
                            
                            while contador4 <= 10 {
                                
                                if let pre = s[String(contador4)] as? NSDictionary {
                                    
                                    if let quest = pre["question"] as? String {
                                        self.questionArrayT4.append(quest)
                                    }
                                    if let re1 = pre["asw1"] as? String {
                                        self.r1ArrayT4.append(re1)
                                    }
                                    if let re2 = pre["asw2"] as? String {
                                        self.r2ArrayT4.append(re2)
                                    }
                                    if let re3 = pre["asw3"] as? String {
                                        self.r3ArrayT4.append(re3)
                                    }
                                }
                                
                                contador4 += 1
                            }
                        } else if self.centinela == 5 {
                            
                            var contador5 = 1
                            
                            while contador5 <= 10 {
                                
                                if let pre = s[String(contador5)] as? NSDictionary {
                                    
                                    if let quest = pre["question"] as? String {
                                        self.questionArrayT5.append(quest)
                                    }
                                    if let re1 = pre["asw1"] as? String {
                                        self.r1ArrayT5.append(re1)
                                    }
                                    if let re2 = pre["asw2"] as? String {
                                        self.r2ArrayT5.append(re2)
                                    }
                                    if let re3 = pre["asw3"] as? String {
                                        self.r3ArrayT5.append(re3)
                                    }
                                }
                                
                                contador5 += 1
                            }
                        }
                        
                        self.centinela += 1
                        
                    }
                    
                }
               
                print(self.questionArrayT1)
                print(self.r1ArrayT1)
                print(self.r2ArrayT1)
                print(self.r3ArrayT1)
                print(self.questionArrayT2)
                print(self.r1ArrayT2)
                print(self.r2ArrayT2)
                print(self.r3ArrayT2)
                print(self.questionArrayT3)
                print(self.r1ArrayT3)
                print(self.r2ArrayT3)
                print(self.r3ArrayT3)
                print(self.questionArrayT4)
                print(self.r1ArrayT4)
                print(self.r2ArrayT4)
                print(self.r3ArrayT4)
                print(self.questionArrayT5)
                print(self.r1ArrayT5)
                print(self.r2ArrayT5)
                print(self.r3ArrayT5)
            }
            catch{
                print("Error Serializando del Json")
            }
            }.resume() //ejecuta el URLSession
        
    }
    
    
    func loadMenu() {
        
        //Menu de la aplicación
        
        //Vista de fondo transparente
        menuBG = UIView(frame: view.frame)
        menuBG.alpha = 0
        menuBG.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(menuBG)
        
        //Contenedor de las opciones del menú
        menuContent = UIView(frame: CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen * 0.545))
        menuContent.layer.cornerRadius = 20.0
        menuContent.backgroundColor = UIColor.white
        view.addSubview(menuContent)
        
        // Swipe Gesture
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(sender:)))
        swipeGesture?.direction = .down
        view.addGestureRecognizer(swipeGesture!)
        
        // Adorno del contenedor del menú
        let adorno = UIView(frame: CGRect(x: wScreen * 0.425, y: hScreen * 0.015, width: wScreen * 0.15, height: hScreen * 0.005))
        adorno.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        adorno.layer.cornerRadius = 3.0
        menuContent.addSubview(adorno)
        
        // Imagen de perfil
        avatarImg = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.04, width: wScreen * 0.14, height: wScreen * 0.14))
        avatarImg?.image = UIImage(data: userAvatar as Data)
        avatarImg?.layer.cornerRadius = avatarImg!.frame.width/2
        avatarImg?.layer.masksToBounds = true
        menuContent.addSubview(avatarImg!)
        
        // Username
        username = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.03, y: hScreen * 0.05, width: wScreen * 0.35, height: wScreen * 0.05))
        username?.textColor = .black
        username?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        menuContent.addSubview(username!)
        
        usermail = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.03, y: username!.frame.maxY, width: wScreen * 0.4, height: wScreen * 0.05))
        usermail?.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        usermail?.font = UIFont(name: "HelveticaNeue", size: 11)
        menuContent.addSubview(usermail!)
        
        let verPerfilBtn = UIButton(type: .custom)
        verPerfilBtn.frame = CGRect(x: wScreen * 0.68, y: hScreen * 0.05, width: wScreen * 0.27, height: wScreen * 0.087)
        verPerfilBtn.setImage(#imageLiteral(resourceName: "verPerfl"), for: .normal)
        verPerfilBtn.addTarget(self, action: #selector(verPerfilPressed), for: .touchUpInside)
        menuContent.addSubview(verPerfilBtn)
        
        let lineSeparation = UIView(frame: CGRect(x: 0, y: hScreen * 0.14, width: wScreen, height: 0.5))
        lineSeparation.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        menuContent.addSubview(lineSeparation)
        
        let m1Btn = UIButton(type: .custom)
        m1Btn.frame = CGRect(x: wScreen * 0.05, y: lineSeparation.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m1Btn.setImage(#imageLiteral(resourceName: "m1"), for: .normal)
        m1Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m1Btn.tag = 1
        menuContent.addSubview(m1Btn)
        
        let m2Btn = UIButton(type: .custom)
        m2Btn.frame = CGRect(x: m1Btn.frame.maxX + wScreen * 0.05, y: lineSeparation.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m2Btn.setImage(#imageLiteral(resourceName: "m2"), for: .normal)
        m2Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m2Btn.tag = 2
        menuContent.addSubview(m2Btn)
        
        let m3Btn = UIButton(type: .custom)
        m3Btn.frame = CGRect(x: wScreen * 0.05, y: m2Btn.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m3Btn.setImage(#imageLiteral(resourceName: "m3"), for: .normal)
        m3Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m3Btn.tag = 3
        menuContent.addSubview(m3Btn)
        
        let m4Btn = UIButton(type: .custom)
        m4Btn.frame = CGRect(x: m1Btn.frame.maxX + wScreen * 0.05, y: m2Btn.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m4Btn.setImage(#imageLiteral(resourceName: "m4"), for: .normal)
        m4Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m4Btn.tag = 4
        menuContent.addSubview(m4Btn)
        
        let m5Btn = UIButton(type: .custom)
        m5Btn.frame = CGRect(x: wScreen * 0.05, y: m3Btn.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m5Btn.setImage(#imageLiteral(resourceName: "m5"), for: .normal)
        m5Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m5Btn.tag = 5
        menuContent.addSubview(m5Btn)
        
        let m6Btn = UIButton(type: .custom)
        m6Btn.frame = CGRect(x: m1Btn.frame.maxX + wScreen * 0.05, y: m3Btn.frame.maxY + wScreen * 0.05, width: wScreen * 0.425, height: wScreen * 0.119)
        m6Btn.setImage(#imageLiteral(resourceName: "m6"), for: .normal)
        m6Btn.addTarget(self, action: #selector(optionPressed(sender:)), for: .touchUpInside)
        m6Btn.tag = 6
        menuContent.addSubview(m6Btn)
        
        let footerMenu = UIView(frame: CGRect(x: 0, y: menuContent.frame.height - hScreen * 0.085, width: wScreen, height: hScreen * 0.085))
        footerMenu.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        menuContent.addSubview(footerMenu)
        
        let closeSession = UIButton(type: .system)
        closeSession.frame = CGRect(x: wScreen * 0.05, y: 0, width: wScreen * 0.25, height: hScreen * 0.085)
        closeSession.setTitle("Cerrar sesión", for: .normal)
        closeSession.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        closeSession.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .normal)
        closeSession.addTarget(self, action: #selector(closeS), for: .touchUpInside)
        footerMenu.addSubview(closeSession)
        
        let avisoPrivacidad = UIButton(type: .system)
        avisoPrivacidad.frame = CGRect(x: wScreen * 0.7, y: 0, width: wScreen * 0.25, height: hScreen * 0.085)
        avisoPrivacidad.setTitle("Legal V.1.0", for: .normal)
        avisoPrivacidad.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        avisoPrivacidad.setTitleColor(UIColor.black, for: .normal)
        avisoPrivacidad.addTarget(self, action: #selector(avisoP), for: .touchUpInside)
        footerMenu.addSubview(avisoPrivacidad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.isNavigationBarHidden = true
        
        // UserDefaults para obtener nombre y correo del usuario
        if let nombre = UserDefaults.standard.object(forKey: "userName") {
            
            username?.text = nombre as? String
        }
        
        if let mailU = UserDefaults.standard.object(forKey: "userMail") {
            
            usermail?.text = mailU as? String
        }
        
        // Implementación de userDefaults para cargar imagen de usuario
        if (UserDefaults.standard.object(forKey: "savedImage") as? NSData) != nil{
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarImg?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarImg?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
        
        // UserDefaults para obtener nombre y correo del usuario
        if let nombre = UserDefaults.standard.object(forKey: "userName") {
            
            username?.text = nombre as? String
        }
        
        if let mailU = UserDefaults.standard.object(forKey: "userMail") {
            
            usermail?.text = mailU as? String
        }
        
        // Implementación de userDefaults para cargar imagen de usuario
        if (UserDefaults.standard.object(forKey: "savedImage") as? NSData) != nil{
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarImg?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarImg?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    //Selector Marker
    @objc func markerPressed() {
        
        self.navigationController?.pushViewController(DeliMap(), animated: true)
    }
    
    @objc func searchPressed() {
        
        self.navigationController?.pushViewController(Search(), animated: true)
    }
    
    //Selectores Menú
    @objc func menuPressed() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.menuBG.alpha = 1
        }) { (true) in
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.menuContent.frame = CGRect(x: 0, y: hScreen - self.menuContent.frame.height, width: wScreen, height: hScreen * 0.545)
            }, completion: { (true) in
                
            })
        }
    }
    
    @objc func swipeDetected(sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.menuContent.frame = CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen * 0.545)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.menuBG.alpha = 0
            })
        }
    }
    
    @objc func verPerfilPressed() {
        
        let perfilVC = Perfil3()
        navigationController?.pushViewController(perfilVC, animated: true)
    }
    
    @objc func optionPressed(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            navigationController?.pushViewController(Noticias(), animated: true)
        case 1:
            navigationController?.pushViewController(Noticias(), animated: true)
        case 1:
            navigationController?.pushViewController(Noticias(), animated: true)
        case 1:
            navigationController?.pushViewController(Noticias(), animated: true)
        case 1:
            navigationController?.pushViewController(Noticias(), animated: true)
        default:
            navigationController?.pushViewController(Noticias(), animated: true)
        }
    }
    
    @objc func closeS() {
        
    }
    
    @objc func avisoP() {
        
    }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    guard let titleView = navigationItem.titleView else { return }
    let center = UIScreen.main.bounds.midX
    let diff = center - titleView.frame.midX
    titleImageViewXConstraint.constant = diff
  }
  
}

// MARK: Helpers
extension DemoViewController {
  
  fileprivate func registerCell() {
    
    let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
    collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
  }
  
  fileprivate func fillCellIsOpenArray() {
    cellsIsOpen = Array(repeating: false, count: items.count)
  }
  
  fileprivate func getViewController() -> ExpandingTableViewController {
    let storyboard = UIStoryboard(storyboard: .Main)
    let toViewController: DemoTableViewController = storyboard.instantiateViewController()
    return toViewController
  }

    fileprivate func getViewController2() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController2 = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func getViewController3() -> ExpandingTableViewController {
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController3 = storyboard.instantiateViewController()
        toViewController.triviaIds1 = triviaIds
        toViewController.triviaNames1 = triviaNames
        toViewController.triviaStatus1 = triviaStatus
        toViewController.triviaFecha1 = triviaFecha
        toViewController.triviaIncluye1 = triviaIncluye
        toViewController.triviaVigencia1 = triviaVigencia
        toViewController.triviaPremio1 = triviaPremio
        toViewController.triviaLogoB1 = triviaLogoB
        toViewController.triviaLogoN1 = triviaLogoN
        toViewController.triviaImgP1 = triviaImgP
        toViewController.questionArrayT11 = questionArrayT1
        toViewController.r1ArrayT11 = r1ArrayT1
        toViewController.r2ArrayT11 = r2ArrayT1
        toViewController.r3ArrayT11 = r3ArrayT1
        toViewController.questionArrayT22 = questionArrayT2
        toViewController.r1ArrayT22 = r1ArrayT2
        toViewController.r2ArrayT22 = r2ArrayT2
        toViewController.r3ArrayT22 = r3ArrayT2
        toViewController.questionArrayT33 = questionArrayT3
        toViewController.r1ArrayT33 = r1ArrayT3
        toViewController.r2ArrayT33 = r2ArrayT3
        toViewController.r3ArrayT33 = r3ArrayT3
        toViewController.questionArrayT44 = questionArrayT4
        toViewController.r1ArrayT44 = r1ArrayT4
        toViewController.r2ArrayT44 = r2ArrayT4
        toViewController.r3ArrayT44 = r3ArrayT4
        toViewController.questionArrayT55 = questionArrayT5
        toViewController.r1ArrayT55 = r1ArrayT5
        toViewController.r2ArrayT55 = r2ArrayT5
        toViewController.r3ArrayT55 = r3ArrayT5
        
        return toViewController
    }
  
  fileprivate func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
  
}

/// MARK: Gesture
extension DemoViewController {
  
  fileprivate func addGesture(to view: UIView) {
    let upGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
      $0.direction = .up
    }
    
    let downGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
      $0.direction = .down
    }
    view.addGestureRecognizer(upGesture)
    view.addGestureRecognizer(downGesture)
  }


    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
    let indexPath = IndexPath(row: currentIndex, section: 0)
    guard let cell  = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }

    
    if(currentIndex == 0){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController())
            
            tarjetaActiva = 0
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 1){
    
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController2())
            
            tarjetaActiva = 1
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 2){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController3())
            
            tarjetaActiva = 2
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }

  }
 
  
}



// MARK: UIScrollViewDelegate
extension DemoViewController {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    pageLabel.text = "\(currentIndex+1)/\(items.count)"
    
    
    if(currentIndex == 0){
   
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 191.00/255, green: 191.00/255, blue: 181.00/255, alpha: 1.00);
            let BG = UIImageView(frame: self.view.frame)
            BG.image = UIImage(named: "ec1")
              
            
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 1){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 93.00/255, green: 105.00/255, blue: 185.00/255, alpha: 1.00);
            let BG = UIImageView(frame: self.view.frame)
            BG.image = UIImage(named: "ec2")
            
            
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 2){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 238/255, green: 164/255, blue: 153/255, alpha: 1.00);
            let BG = UIImageView(frame: self.view.frame)
            BG.image = UIImage(named: "ec3")
            
            
        }, completion: { (true) in
            
        })
    }

  }
  
}

// MARK: UICollectionViewDataSource
extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    guard let cell = cell as? DemoCollectionViewCell else { return }

    let index = indexPath.row % items.count
    let info = items[index]
    cell.backgroundImageView?.image = UIImage(named: info.imageName)
    cell.customTitle.text = info.title
    cell.texto2.text = info.texto
    cell.texto3.text = info.texto3
    cell.texto4.text = info.texto4
    cell.cellIsOpen(cellsIsOpen[index], animated: false)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell, currentIndex == indexPath.row else { return }
    
    if(indexPath.row == 0){
    
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController())
            tarjetaActiva = 0
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(indexPath.row == 1){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController2())
            tarjetaActiva = 1
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(indexPath.row == 2){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController3())
            tarjetaActiva = 2
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }


  }
  
}

// MARK: UICollectionViewDataSource
extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath)
  }
  
}
