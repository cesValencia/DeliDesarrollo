//
//  DemoTableViewController3.swift
//  TestCollectionView
//
//  Created by Alex K. on 24/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoTableViewController3: ExpandingTableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //VARIABLES PARA EL ARRASTRAR VARIABLES AL SIGUIENTE CONTROLLADOR
    //Urls
    var c1 = Paging()
    var c2 = Paging()
    var c3 = Paging()
    var c4 = Paging()
    var c5 = Paging()
    var c6 = Paging()
    var c7 = Paging()
    var c8 = Paging()
    var cColor1: UIColor?
    var cColor2: UIColor?
    var cColor3: UIColor?
    var cColor4: UIColor?
    var cColor5: UIColor?
    var cColor6: UIColor?
    var cColor7: UIColor?
    var cColor8: UIColor?
    var boton: UIButton?
    var boton2: UIButton?
    var boton3: UIButton?
    var boton4: UIButton?
    var boton5: UIButton?
    var boton6: UIButton?
    var boton7: UIButton?
    var boton8: UIButton?
    var btnArray = [UIButton]()
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    
    var triviaIds1 = [String]()
    var triviaNames1 = [String]()
    var triviaStatus1 = [String]()
    var triviaFecha1 = [String]()
    var triviaIncluye1 = [String]()
    var triviaVigencia1 = [String]()
    var triviaPremio1 = [String]()
    var triviaLogoB1 = [String]()
    var triviaLogoN1 = [String]()
    var triviaImgP1 = [String]()
    var questionArrayT11 = [String]()
    var r1ArrayT11 = [String]()
    var r2ArrayT11 = [String]()
    var r3ArrayT11 = [String]()
    var questionArrayT22 = [String]()
    var r1ArrayT22 = [String]()
    var r2ArrayT22 = [String]()
    var r3ArrayT22 = [String]()
    var questionArrayT33 = [String]()
    var r1ArrayT33 = [String]()
    var r2ArrayT33 = [String]()
    var r3ArrayT33 = [String]()
    var questionArrayT44 = [String]()
    var r1ArrayT44 = [String]()
    var r2ArrayT44 = [String]()
    var r3ArrayT44 = [String]()
    var questionArrayT55 = [String]()
    var r1ArrayT55 = [String]()
    var r2ArrayT55 = [String]()
    var r3ArrayT55 = [String]()
    
    //Arreglos que muestran contenido del carrusel de experiencias
    var imgA = [UIImage]()
    var precioA = [UIImage]()
    var tituloA = [String]()
    var subtituloA = [String]()
    var realA = [String]()
    var botonArray = [String]()
    
    // Vista de imagen destacados
    var destacadosView: UIImageView?
    
    //Caruusel Ex 2 arreglo
    var sugeridosC = [UIImage]()
    
    //Nombre de los collectionViews
    var collectionEx: UICollectionView?
    var collectionEx2: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var layout2: UICollectionViewFlowLayout?
    
    var identifiers = ["201", "202", "203", "204", "205", "206", "207", "208", "209", "210"]
    
    var indexSelected: Int = 0
    
    @IBOutlet weak var containerView: UIView!
    
    //fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.questionArrayT11)
        print(self.r1ArrayT11)
        print(self.r2ArrayT11)
        print(self.r3ArrayT11)
        print(self.questionArrayT22)
        print(self.r1ArrayT22)
        print(self.r2ArrayT22)
        print(self.r3ArrayT22)
        print(self.questionArrayT33)
        print(self.r1ArrayT33)
        print(self.r2ArrayT33)
        print(self.r3ArrayT33)
        print(self.questionArrayT44)
        print(self.r1ArrayT44)
        print(self.r2ArrayT44)
        print(self.r3ArrayT44)
        print(self.questionArrayT55)
        print(self.r1ArrayT55)
        print(self.r2ArrayT55)
        print(self.r3ArrayT55)
        // Status bar
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
        
        //NUEVAS VARIABLES
        
        cColor1 = headColor1
        
        botones()
        
        btnArray = [boton!, boton2!, boton3!, boton4!, boton5!, boton6!, boton7!, boton8!]
        
        
        
        //Contenido de los arreglos de carrusel de experiencias
        imgA = [#imageLiteral(resourceName: "tFake1"), #imageLiteral(resourceName: "tFake2"), #imageLiteral(resourceName: "tFake1"), #imageLiteral(resourceName: "tFake2"), #imageLiteral(resourceName: "tFake1"), #imageLiteral(resourceName: "tFake2"), #imageLiteral(resourceName: "tFake1"), #imageLiteral(resourceName: "tFake2")]
        precioA = [UIImage(named: "ppostres")!, UIImage(named: "pbares")!, UIImage(named: "pantojo")!, UIImage(named: "pverde")!, UIImage(named: "pplata")!, UIImage(named: "pmixo")!, UIImage(named: "pplatino")!, UIImage(named: "pdiamante")!]
        tituloA = ["Postres", "Bares", "Antojo", "Verde", "Plata", "Mixología", "Platino", "Diamante"]
        subtituloA = ["café, pasteles & helados", "pubs, bares & cantinas", "antojerías y snacks", "vegana & vegetariana", "restaurantes & pubs", "lounges & bares", "restaurantes & bistrò", "restaurantes & bistrò"]
        realA = ["Valor en sucursal      70$", "Valor en sucursal   106$", "Valor en sucursal   106$", "Valor en sucursal   116$", "Valor en sucursal   180$", "Valor en sucursal   180$", "Valor en sucursal   310$", "Valor en sucursal  1,060$"]
        botonArray = ["Postres", "Bares", "Antojo", "Verde", "Plata", "Mixologia", "Platino", "Diamante"]
        
        //Contenido arreglo ex2
        sugeridosC = [#imageLiteral(resourceName: "caja1Fake"), #imageLiteral(resourceName: "caja2Fake"), #imageLiteral(resourceName: "caja1Fake"), #imageLiteral(resourceName: "caja2Fake")]
        
        //Layout del collection view
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        
        layout2 = UICollectionViewFlowLayout()
        layout2?.scrollDirection = .horizontal
        
        //CollectionView
        collectionEx = UICollectionView(frame: CGRect(x: wScreen * 0.025, y: hScreen * 0.02, width: wScreen * 0.975, height: hScreen * 0.4), collectionViewLayout: layout!)
        collectionEx?.register(CollectionViewEx5.self, forCellWithReuseIdentifier: "cell")
        collectionEx?.bounces = true
        collectionEx?.backgroundColor = UIColor.white
        collectionEx?.delegate = self
        collectionEx?.dataSource = self
        containerView.addSubview(collectionEx!)
        
        destacadosView = UIImageView(frame: CGRect(x: 0, y: collectionEx!.frame.maxY + 10, width: wScreen * 0.115, height: wScreen * 0.35))
        destacadosView?.image = #imageLiteral(resourceName: "destacados")
        containerView.addSubview(destacadosView!)
        
        //CollectionView2
        collectionEx2 = UICollectionView(frame: CGRect(x: wScreen - (wScreen * 0.85), y: collectionEx!.frame.maxY + 10, width: wScreen * 0.85, height: wScreen * 0.35), collectionViewLayout: layout2!)
        collectionEx2?.register(CollectionViewEx6.self, forCellWithReuseIdentifier: "cell2")
        collectionEx2?.bounces = true
        collectionEx2?.backgroundColor = UIColor.white
        collectionEx2?.delegate = self
        collectionEx2?.dataSource = self
        containerView.addSubview(collectionEx2!)
        
        
        configureNavBar()
        //    let image1 = Asset.backgroundImage.image
        //    tableView.backgroundView = UIImageView(image: image1)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    func botones() {
        
        boton = UIButton(type: UIButtonType.system)
        boton?.setTitle("", for: UIControlState.normal)
        boton?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton?.addTarget(self, action: #selector(pressed), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton!)
        
        boton2 = UIButton(type: UIButtonType.system)
        boton2?.setTitle("", for: UIControlState.normal)
        boton2?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton2?.addTarget(self, action: #selector(pressed2), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton2!)
        
        boton3 = UIButton(type: UIButtonType.system)
        boton3?.setTitle("", for: UIControlState.normal)
        boton3?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton3?.addTarget(self, action: #selector(pressed3), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton3!)
        
        boton4 = UIButton(type: UIButtonType.system)
        boton4?.setTitle("", for: UIControlState.normal)
        boton4?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton4?.addTarget(self, action: #selector(pressed4), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton4!)
        
        boton5 = UIButton(type: UIButtonType.system)
        boton5?.setTitle("", for: UIControlState.normal)
        boton5?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton5?.addTarget(self, action: #selector(pressed5), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton5!)
        
        boton6 = UIButton(type: UIButtonType.system)
        boton6?.setTitle("", for: UIControlState.normal)
        boton6?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton6?.addTarget(self, action: #selector(pressed6), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton6!)
        
        boton7 = UIButton(type: UIButtonType.system)
        boton7?.setTitle("", for: UIControlState.normal)
        boton7?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton7?.addTarget(self, action: #selector(pressed7), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton7!)
        
        boton8 = UIButton(type: UIButtonType.system)
        boton8?.setTitle("", for: UIControlState.normal)
        boton8?.backgroundColor = UIColor.white.withAlphaComponent(0)
        boton8?.addTarget(self, action: #selector(pressed8), for: UIControlEvents.touchUpInside)
        //        view.addSubview(boton8!)
    }
    
    @objc func pressed() {
        
        self.navigationController?.pushViewController(c1, animated: true)
    }
    
    @objc func pressed2() {
        
        self.navigationController?.pushViewController(c2, animated: true)
    }
    
    @objc func pressed3() {
        
        self.navigationController?.pushViewController(c3, animated: true)
    }
    
    @objc func pressed4() {
        
        self.navigationController?.pushViewController(c4, animated: true)
    }
    
    @objc func pressed5() {
        
        self.navigationController?.pushViewController(c5, animated: true)
    }
    
    @objc func pressed6() {
        
        self.navigationController?.pushViewController(c6, animated: true)
    }
    
    @objc func pressed7() {
        
        self.navigationController?.pushViewController(c7, animated: true)
    }
    
    @objc func pressed8() {
        
        self.navigationController?.pushViewController(c8, animated: true)
    }
    
    
    /*DashboardView*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionEx {
            
            return self.triviaIds1.count
        }else {
            
            return sugeridosC.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionEx {
            let details = FullTrivias()
            details.imgPrincipalT = triviaImgP1[indexPath.row]
            details.vigenciaT = triviaVigencia1[indexPath.row]
            details.nombreT = triviaNames1[indexPath.row]
            details.incluyeT = triviaIncluye1[indexPath.row]
            details.questionArrayT111 = questionArrayT11
            details.r1ArrayT111 = r1ArrayT11
            details.r2ArrayT111 = r2ArrayT11
            details.r3ArrayT111 = r3ArrayT11
            details.questionArrayT222 = questionArrayT22
            details.r1ArrayT222 = r1ArrayT22
            details.r2ArrayT222 = r2ArrayT22
            details.r3ArrayT222 = r3ArrayT22
            details.questionArrayT333 = questionArrayT33
            details.r1ArrayT333 = r1ArrayT33
            details.r2ArrayT333 = r2ArrayT33
            details.r3ArrayT333 = r3ArrayT33
            details.questionArrayT444 = questionArrayT44
            details.r1ArrayT444 = r1ArrayT44
            details.r2ArrayT444 = r2ArrayT44
            details.r3ArrayT444 = r3ArrayT44
            details.questionArrayT555 = questionArrayT55
            details.r1ArrayT555 = r1ArrayT55
            details.r2ArrayT555 = r2ArrayT55
            details.r3ArrayT555 = r3ArrayT55
            
            indexSelected = indexPath.row
            details.indexSelected2 = indexSelected
            
            navigationController?.pushViewController(details, animated: true)
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionEx{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewEx5
            
            cell.setCellSubviews()
            
            if let url = URL(string: "http://104.236.10.17" + (triviaLogoN1[indexPath.row])) {
                //            background.image = UIImage(data: data)
                cell.imgTriv.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
                NSLog("BAJAR IMAGEN 2")
                
            } else {
                //Imagen por default.... sugiero poner una imagen default por si algo sale mal
                cell.imgTriv.image = #imageLiteral(resourceName: "sin-back")
            }
            cell.mes.text = self.triviaVigencia1[indexPath.row]
            cell.trivia.text = self.triviaNames1[indexPath.row]
            cell.valorPremio.text = "Valor de premio ganador 2,030$"
            
            cell.backgroundColor = UIColor.white
            
            return cell
        }else{
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewEx6
            
            cell2.sugeridos.frame = CGRect(x: 0, y: 0, width: cell2.frame.width * 0.95, height: wScreen * 0.28)
            cell2.sugeridos.image = sugeridosC[indexPath.row]
            cell2.backgroundColor = UIColor.white
            cell2.layer.cornerRadius = 3.0
            cell2.contentView.addSubview(cell2.sugeridos)
            
            cell2.pinMarker.frame = CGRect(x: cell2.frame.width * 0.01, y: cell2.sugeridos.frame.maxY + cell2.frame.height * 0.08, width: cell2.frame.width * 0.038, height: cell2.frame.width * 0.047)
            cell2.pinMarker.image = #imageLiteral(resourceName: "purpleMarker")
            cell2.contentView.addSubview(cell2.pinMarker)
            
            cell2.restAddress.frame = CGRect(x: cell2.pinMarker.frame.maxX + cell2.frame.width * 0.02, y: cell2.sugeridos.frame.maxY + cell2.frame.height * 0.05, width: cell2.frame.width * 0.8, height: cell2.frame.width * 0.085)
            cell2.restAddress.text = "Amargura 35, Colonia San Ángel CDMX."
            cell2.restAddress.font = UIFont(name: "Roboto-Regular", size: 11.5)
            cell2.restAddress.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
            cell2.contentView.addSubview(cell2.restAddress)
            
            return cell2
        }
        
    }
    
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
    
}



// MARK: - Lifecycle
extension DemoTableViewController3 {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let titleView = navigationItem.titleView else { return }
        let center = UIScreen.main.bounds.midX
        let diff = center - titleView.frame.midX
        titleImageViewXConstraint.constant = diff
    }
    
}

// MARK: Helpers
extension DemoTableViewController3 {
    
    fileprivate func configureNavBar() {
        
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
}

// MARK: Actions
extension DemoTableViewController3 {
    
    @IBAction func backButtonHandler(_ sender: AnyObject) {
        // buttonAnimation
        let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        
        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate
extension DemoTableViewController3 {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //    if scrollView.contentOffset.y < -25 {
        //      // buttonAnimation
        //      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        //
        //      for viewController in viewControllers {
        //        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        //          rightButton.animationSelected(false)
        //        }
        //      }
        //      popTransitionAnimation()
        //    }
        //
        //    scrollOffsetY = scrollView.contentOffset.y
    }
}

extension DemoTableViewController3: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionEx {
            let cellWidth = wScreen * 0.38
            
            return CGSize(width: cellWidth, height: collectionEx!.frame.height * 0.93)
        } else {
            
            let cellWidth = wScreen * 0.7
            
            return CGSize(width: cellWidth, height: collectionEx2!.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
}

