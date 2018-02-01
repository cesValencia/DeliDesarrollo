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
  /*fileprivate var items: [ItemInfo] = [("Platino", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Mixologia", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Platino", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Plata", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Antojo", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Licoreria", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Postres", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida"),
                                       ("Verde", "Lo mejor de CDMX", "México", "", "Compra individual por tipo de comida")]*/
    
    fileprivate var items: [ItemInfo] = [("expc1", "Compra individual", "Experiencia", "", ""),
                                         ("Expc2", "Compra por paquete", "Ruta Menú", "", ""),
                                         ("Expc5", "Del mes", "Trivias", "", "")]
  
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
    
    var menuBG = UIView()
    var menuContent = UIView()
    var swipeGesture: UISwipeGestureRecognizer?
    
  var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var avatarImg: UIImageView?
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
//    UIApplication.shared.statusBarStyle = .lightContent
    
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
    
    let menu = UIButton(type: .custom)
    menu.frame = CGRect(x: wScreen * 0.3, y: hScreen * 0.78, width: wScreen * 0.4, height: hScreen * 0.3)
    menu.setImage(#imageLiteral(resourceName: "menurt"), for: .normal)
    menu.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
    view.addSubview(menu)
    
    //Menú
    loadMenu()
    registerCell()
    fillCellIsOpenArray()
    addGesture(to: collectionView!)
    configureNavBar()
  }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        if (UserDefaults.standard.object(forKey: "savedImage") as! NSData) != nil {
//
//            avatarImg?.image = UIImage(data: userAvatar as Data)
//        } else {
//            avatarImg?.image = #imageLiteral(resourceName: "avatar")
//        }
        userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        avatarImg?.image = UIImage(data: userAvatar as Data)
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
        let username = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.03, y: hScreen * 0.05, width: wScreen * 0.35, height: wScreen * 0.05))
        username.text = "David Valencia"
        username.textColor = .black
        username.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        menuContent.addSubview(username)
        
        let usermail = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.03, y: username.frame.maxY, width: wScreen * 0.35, height: wScreen * 0.05))
        usermail.text = "David Valencia"
        usermail.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        usermail.font = UIFont(name: "HelveticaNeue", size: 11)
        menuContent.addSubview(usermail)
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    //Selector Marker
    @objc func markerPressed() {
        
        self.navigationController?.pushViewController(DeliMap(), animated: true)
    }
    
    @objc func searchPressed() {
        
        self.navigationController?.pushViewController(Busqueda(), animated: true)
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
        return toViewController
    }
    
    /*fileprivate func getViewController4() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController4 = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func getViewController5() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController5 = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func getViewController6() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController6 = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func getViewController7() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController7 = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func getViewController8() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController8 = storyboard.instantiateViewController()
        return toViewController
    }*/
  
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
    }/*else if(currentIndex == 3){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController4())
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 4){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController5())
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 5){
        
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController6())
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 6){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController7())
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }else if(currentIndex == 7){
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            
            
            
            pushToViewController(getViewController8())
            
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
                
                
            }
        }
        
        
        
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }*/

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
    /*else if(currentIndex == 3){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 146.00/255, green: 147.00/255, blue: 151.00/255, alpha: 1.00);

            self.controlerPages.currentPage = 3
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 4){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 182.00/255, green: 177.00/255, blue: 143.00/255, alpha: 1.00);

            self.controlerPages.currentPage = 4
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 5){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 148.00/255, green: 137.00/255, blue: 180.00/255, alpha: 1.00);

            self.controlerPages.currentPage = 5
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 6){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 91.00/255, green: 92.00/255, blue: 118.00/255, alpha: 1.00);

            self.controlerPages.currentPage = 6
        }, completion: { (true) in
            
        })
    }
    else if(currentIndex == 7){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor(red: 183.00/255, green: 191.00/255, blue: 134.00/255, alpha: 1.00);

            self.controlerPages.currentPage = 7
        }, completion: { (true) in
            
        })
    }*/
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
    
    if(currentIndex == 0){
    
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController())
            tarjetaActiva = 0
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 1){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController2())
            tarjetaActiva = 1
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 2){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController3())
            tarjetaActiva = 2
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }/*else if(currentIndex == 3){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController4())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 4){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController5())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 5){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController6())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 6){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController7())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }else if(currentIndex == 7){
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController8())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }*/


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
