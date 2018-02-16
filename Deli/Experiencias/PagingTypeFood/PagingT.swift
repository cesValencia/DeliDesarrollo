//
//  PagingT.swift
//  Deli
//
//  Created by David Valencia on 15/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit

class PagingT: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var container: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var lastContentOffset: CGFloat = 0.0
    var header: UIView?
    var options: UIScrollView?
    var foco: UIImageView?
    var opc1: UIView?
    var opc2: UIView?
    var opc3: UIView?
    var opc4: UIView?
    var opc5: UIView?
    var opc6: UIView?
    var opc7: UIView?
    var opc8: UIView?
    var option1: UIButton?
    var option2: UIButton?
    var option3: UIButton?
    var option4: UIButton?
    var option5: UIButton?
    var option6: UIButton?
    var option7: UIButton?
    var option8: UIButton?
    var vcControllers = [UIViewController]()
    var vc1: ControllerT1?
    var vc2: ControllerT2?
    var vc3: ControllerT3?
    var vc4: ControllerT4?
    var vc5: ControllerT5?
    var vc6: ControllerT6?
    var vc7: ControllerT7?
    var vc8: ControllerT8?
    var urlJson: String?
    var topColor: UIColor?
    var categoryName: String?
    var categoryDesc: String?
    var zoneName1: UILabel?
    var zoneName2: UILabel?
    var zoneName3: UILabel?
    var zoneName4: UILabel?
    var zoneName5: UILabel?
    var zoneName6: UILabel?
    var zoneName7: UILabel?
    var zoneName8: UILabel?
    var todosBtn: UIButton?
    var filtroBtn: UIButton?
    var titulo: UILabel?
    var subtitulo: UILabel?
    var filtroView: UIView?
    var typeFoodView: UIView?
    var typeFoodContainer: UIScrollView?
    var swipeGesture: UISwipeGestureRecognizer?
    var regSwipe: UISwipeGestureRecognizer?
    var filtroTitle: UILabel?
    var regContainer: UIView?
    var regView: UIView?
    var regImg: UIImageView?
    var shareLabel: UILabel?
    var legendLabel: UILabel?
    var regCard: UIImageView?
    var regPayBtn: UIButton?
    var regBackBtn: UIButton?
//    var dataSourceForDiamond2 = [Restaurant]()
//    var dataSourceForPlatinum2 = [Restaurant]()
//    var dataSourceForMixology2 = [Restaurant]()
//    var dataSourceForSilver2 = [Restaurant]()
//    var dataSourceForGreen2 = [Restaurant]()
//    var dataSourceForSnacks2 = [Restaurant]()
//    var dataSourceForPubs2 = [Restaurant]()
//    var dataSourceForCakes2 = [Restaurant]()
    var dataSourceForCarnes2 = [Restaurant]()
    var dataSourceForMariscos2 = [Restaurant]()
    var dataSourceForPastas2 = [Restaurant]()
    var dataSourceForSnack2 = [Restaurant]()
    var dataSourceForOriental2 = [Restaurant]()
    var dataSourceForMexicana2 = [Restaurant]()
    var dataSourceForEuropea2 = [Restaurant]()
    var dataSourceForSaludable2 = [Restaurant]()
    var avatarImg: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .default
        
        // Implementación de userDefaults para cargar imagen de usuario
        if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarImg?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarImg?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Implementación de userDefaults para cargar imagen de usuario
        if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
            
            userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            avatarImg?.image = UIImage(data: userAvatar as Data)
        } else {
            avatarImg?.image = #imageLiteral(resourceName: "user-foto")
        }
    }
    
    func loadInterface() {
        
        view.backgroundColor = UIColor.white
        
        
        
        header = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.19))
        header?.backgroundColor = headColor1
        view.addSubview(header!)
        
        titulo = UILabel(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.077, width: wScreen * 0.45, height: hScreen * 0.060))
        titulo?.text = categoryName
        titulo?.textAlignment = .left
        titulo?.font = UIFont(name: "roboto-black", size: 37)
        titulo?.textColor = UIColor(red: 40/255, green: 39/255, blue: 45/255, alpha: 1)
        header?.addSubview(titulo!)
        
        subtitulo = UILabel(frame: CGRect(x: wScreen * 0.05, y: titulo!.frame.maxY, width: wScreen * 0.43, height: hScreen * 0.028))
        subtitulo?.text = categoryDesc
        subtitulo?.textAlignment = .left
        subtitulo?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        subtitulo?.textColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 0.6)
        header?.addSubview(subtitulo!)
        
        todosBtn = UIButton(type: .custom)
        todosBtn?.frame = CGRect(x: titulo!.frame.maxX + wScreen * 0.02, y: titulo!.frame.maxY - 15, width: wScreen * 0.28, height: hScreen * 0.065 )
        todosBtn?.setImage(#imageLiteral(resourceName: "regBtn2"), for: .normal)
        todosBtn?.addTarget(self, action: #selector(regalaPressed), for: .touchUpInside)
        header?.addSubview(todosBtn!)
        
        filtroBtn = UIButton(type: .custom)
        filtroBtn?.frame = CGRect(x: todosBtn!.frame.maxX + wScreen * 0.01, y: titulo!.frame.maxY - 12, width: wScreen * 0.2, height: hScreen * 0.04)
        filtroBtn?.setTitle("filtrar", for: .normal)
        filtroBtn?.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 17)
        filtroBtn?.setTitleColor(UIColor(red: 255/255, green: 137/255, blue: 137/255, alpha: 1), for: .normal)
        filtroBtn?.addTarget(self, action: #selector(filtroPressed), for: .touchUpInside)
        header?.addSubview(filtroBtn!)
        
        let regala = UIButton(type: UIButtonType.custom)
        regala.frame = CGRect(x: wScreen * 0.63, y: hScreen * 0.065, width: wScreen * 0.13, height: wScreen * 0.13)
        regala.setImage(#imageLiteral(resourceName: "regaloIcon"), for: UIControlState.normal)
        regala.addTarget(self, action: #selector(regalaPressed), for: UIControlEvents.touchUpInside)
        //        header?.addSubview(regala)
        
        let closeimg = UIImageView(frame: CGRect(x: wScreen - wScreen * 0.08, y: hScreen * 0.05, width: wScreen * 0.04, height: wScreen * 0.04))
        closeimg.image = #imageLiteral(resourceName: "closeCategory")
        header?.addSubview(closeimg)
        
        let backBtn = UIButton(type: UIButtonType.system)
        backBtn.frame = CGRect(x: wScreen - wScreen * 0.2, y: hScreen * 0.04, width: wScreen * 0.2, height: wScreen * 0.12)
        backBtn.addTarget(self, action: #selector(backPressed), for: UIControlEvents.touchUpInside)
        header?.addSubview(backBtn)
        
        options = UIScrollView(frame: CGRect(x: 0, y: header!.frame.maxY, width: wScreen, height: hScreen * 0.15))
        options?.backgroundColor = UIColor.white
        options?.isScrollEnabled = true
        options?.isPagingEnabled = true
        options?.bounces = false
        options?.alwaysBounceHorizontal = false
        options?.delegate = self
        view.addSubview(options!)
        
        opc1 = UIView(frame: CGRect(x: 0, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc1!)
        
        opc2 = UIView(frame: CGRect(x: opc1!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc2!)
        
        opc3 = UIView(frame: CGRect(x: opc2!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc3!)
        
        opc4 = UIView(frame: CGRect(x: opc3!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc4!)
        
        opc5 = UIView(frame: CGRect(x: opc4!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc5!)
        
        opc6 = UIView(frame: CGRect(x: opc5!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc6!)
        
        opc7 = UIView(frame: CGRect(x: opc6!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc7!)
        
        opc8 = UIView(frame: CGRect(x: opc7!.frame.maxX, y: 0, width: wScreen/4, height: hScreen * 0.15))
        options?.addSubview(opc8!)
        
        foco = UIImageView(frame: CGRect(x: (opc1!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19))
        foco?.image = #imageLiteral(resourceName: "aro")
        options?.addSubview(foco!)
        
        option1 = UIButton(frame: CGRect(x: (opc1!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option1?.setImage(#imageLiteral(resourceName: "icarne"), for: UIControlState.normal)
        option1?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option1?.addTarget(self, action: #selector(op1Pressed), for: UIControlEvents.touchUpInside)
        opc1?.addSubview(option1!)
        
        zoneName1 = UILabel(frame: CGRect(x: opc1!.frame.width * 0.05, y: option1!.frame.maxY + 5, width: opc1!.frame.width * 0.9, height: opc1!.frame.height * 0.15))
        zoneName1?.text = "Carnes"
        zoneName1?.textAlignment = .center
        zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc1?.addSubview(zoneName1!)
        
        option2 = UIButton(frame: CGRect(x: (opc2!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option2?.setImage(#imageLiteral(resourceName: "imariscos"), for: UIControlState.normal)
        option2?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option2?.addTarget(self, action: #selector(op2Pressed), for: UIControlEvents.touchUpInside)
        opc2?.addSubview(option2!)
        
        zoneName2 = UILabel(frame: CGRect(x: opc2!.frame.width * 0.05, y: option2!.frame.maxY + 5, width: opc2!.frame.width * 0.9, height: opc1!.frame.height * 0.15))
        zoneName2?.text = "Mariscos"
        zoneName2?.textAlignment = .center
        zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc2?.addSubview(zoneName2!)
        
        option3 = UIButton(frame: CGRect(x: (opc3!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option3?.setImage(#imageLiteral(resourceName: "ipastas"), for: UIControlState.normal)
        option3?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option3?.addTarget(self, action: #selector(op3Pressed), for: UIControlEvents.touchUpInside)
        opc3?.addSubview(option3!)
        
        zoneName3 = UILabel(frame: CGRect(x: opc3!.frame.width * 0.05, y: option3!.frame.maxY + 5, width: opc3!.frame.width * 0.9, height: opc3!.frame.height * 0.15))
        zoneName3?.text = "Pastas"
        zoneName3?.textAlignment = .center
        zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc3?.addSubview(zoneName3!)
        
        option4 = UIButton(frame: CGRect(x: (opc4!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option4?.setImage(#imageLiteral(resourceName: "isnacks"), for: UIControlState.normal)
        option4?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option4?.addTarget(self, action: #selector(op4Pressed), for: UIControlEvents.touchUpInside)
        opc4?.addSubview(option4!)
        
        zoneName4 = UILabel(frame: CGRect(x: opc4!.frame.width * 0.05, y: option4!.frame.maxY + 5, width: opc4!.frame.width * 0.9, height: opc3!.frame.height * 0.15))
        zoneName4?.text = "Snacks"
        zoneName4?.textAlignment = .center
        zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc4?.addSubview(zoneName4!)
        
        option5 = UIButton(frame: CGRect(x: (opc5!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option5?.setImage(#imageLiteral(resourceName: "ioriental"), for: UIControlState.normal)
        option5?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option5?.addTarget(self, action: #selector(op5Pressed), for: UIControlEvents.touchUpInside)
        opc5?.addSubview(option5!)
        
        zoneName5 = UILabel(frame: CGRect(x: opc5!.frame.width * 0.05, y: option5!.frame.maxY + 5, width: opc5!.frame.width * 0.9, height: opc3!.frame.height * 0.15))
        zoneName5?.text = "Oriental"
        zoneName5?.textAlignment = .center
        zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc5?.addSubview(zoneName5!)
        
        option6 = UIButton(frame: CGRect(x: (opc6!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option6?.setImage(#imageLiteral(resourceName: "AntojoC"), for: UIControlState.normal)
        option6?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option6?.addTarget(self, action: #selector(op6Pressed), for: UIControlEvents.touchUpInside)
        opc6?.addSubview(option6!)
        
        zoneName6 = UILabel(frame: CGRect(x: opc6!.frame.width * 0.05, y: option6!.frame.maxY + 5, width: opc6!.frame.width * 0.9, height: opc3!.frame.height * 0.15))
        zoneName6?.text = "Mexicana"
        zoneName6?.textAlignment = .center
        zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc6?.addSubview(zoneName6!)
        
        option7 = UIButton(frame: CGRect(x: (opc7!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option7?.setImage(#imageLiteral(resourceName: "BaresC"), for: UIControlState.normal)
        option7?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option7?.addTarget(self, action: #selector(op7Pressed), for: UIControlEvents.touchUpInside)
        opc7?.addSubview(option7!)
        
        zoneName7 = UILabel(frame: CGRect(x: opc7!.frame.width * 0.05, y: option7!.frame.maxY + 5, width: opc7!.frame.width * 0.9, height: opc3!.frame.height * 0.15))
        zoneName7?.text = "Europea"
        zoneName7?.textAlignment = .center
        zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc7?.addSubview(zoneName7!)
        
        option8 = UIButton(frame: CGRect(x: (opc8!.frame.width/2) - (wScreen * 0.17)/2, y: hScreen * 0.006, width: wScreen * 0.17, height: wScreen * 0.17))
        option8?.setImage(#imageLiteral(resourceName: "PostresC"), for: UIControlState.normal)
        option8?.setTitleColor(UIColor.white, for: UIControlState.normal)
        option8?.addTarget(self, action: #selector(op8Pressed), for: UIControlEvents.touchUpInside)
        opc8?.addSubview(option8!)
        
        zoneName8 = UILabel(frame: CGRect(x: opc8!.frame.width * 0.05, y: option8!.frame.maxY + 5, width: opc8!.frame.width * 0.9, height: opc8!.frame.height * 0.15))
        zoneName8?.text = "Saludable"
        zoneName8?.textAlignment = .center
        zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
        zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
        opc8?.addSubview(zoneName8!)
        
        //        foco = UIView(frame: CGRect(x: opc1!.frame.width * 0.25, y: options!.frame.height * 0.92, width: opc1!.frame.width * 0.5, height: options!.frame.height * 0.01))
        //        foco?.backgroundColor = UIColor.black.withAlphaComponent(0)
        //        options?.addSubview(foco!)
        
        options?.contentSize = CGSize(width: opc8!.frame.maxX, height: hScreen * 0.1)
        
        //Layout del collection view
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        
        container = UICollectionView(frame: CGRect(x: 0, y: options!.frame.maxY, width: wScreen, height: hScreen * 0.66), collectionViewLayout: layout!)
        container?.register(GridsContainerT.self, forCellWithReuseIdentifier: "CellGrid")
        container?.isScrollEnabled = true
        container?.isPagingEnabled = true
        container?.bounces = false
        container?.alwaysBounceHorizontal = false
        container?.backgroundColor = UIColor.white
        container?.delegate = self
        container?.dataSource = self
        
        switch self.categoryName?.lowercased() {
        case "saludable"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 7
        case "europea"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 6
        case "mexicana"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 5
        case "oriental"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 4
        case "snacks"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 3
        case "pastas"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 2
        case "mariscos"?:
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 1
        default:
            container?.contentOffset.x = UIScreen.main.bounds.width * 0
        }
        
        view.addSubview(container!)
        
        vc1 = ControllerT1()
        vc1?.parentController = self
        vc1?.urlC = urlJson
        vc1?.dataSource = dataSourceForCarnes2
        vc1?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc1?.view.backgroundColor = UIColor.red
        //        container?.addSubview(vc1!.view)
        
        vc2 = ControllerT2()
        vc2?.parentController = self
        vc2?.urlC = urlJson
        vc2?.dataSourceForMariscos3 = dataSourceForMariscos2
        vc2?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc2?.view.backgroundColor = UIColor.blue
        //        container?.addSubview(vc2!.view)
        
        vc3 = ControllerT3()
        vc3?.parentController = self
        vc3?.urlC = urlJson
        vc3?.dataSourceForPastas3 = dataSourceForPastas2
        vc3?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc3?.view.backgroundColor = UIColor.yellow
        //        container?.addSubview(vc3!.view)
        
        vc4 = ControllerT4()
        vc4?.parentController = self
        vc4?.urlC = urlJson
        vc4?.dataSourceForSnack3 = dataSourceForSnack2
        vc4?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc4?.view.backgroundColor = UIColor.purple
        //        container?.addSubview(vc4!.view)
        
        vc5 = ControllerT5()
        vc5?.parentController = self
        vc5?.urlC = urlJson
        vc5?.dataSourceForOriental3 = dataSourceForOriental2
        vc5?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc5?.view.backgroundColor = UIColor.green
        //        container?.addSubview(vc5!.view)
        
        vc6 = ControllerT6()
        vc6?.parentController = self
        vc6?.urlC = urlJson
        vc6?.dataSourceForMexicana3 = dataSourceForMexicana2
        vc6?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc6?.view.backgroundColor = UIColor.black
        //        container?.addSubview(vc6!.view)
        
        vc7 = ControllerT7()
        vc7?.parentController = self
        vc7?.urlC = urlJson
        vc7?.dataSourceForEuropea3 = dataSourceForEuropea2
        vc7?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc7?.view.backgroundColor = UIColor.black
        //        container?.addSubview(vc7!.view)
        
        vc8 = ControllerT8()
        vc8?.parentController = self
        vc8?.urlC = urlJson
        vc8?.dataSourceForSaludable3 = dataSourceForSaludable2
        vc8?.view.frame = CGRect(x: 0, y: 0, width: container!.frame.width, height: container!.frame.height)
        vc8?.view.backgroundColor = UIColor.black
        //        container?.addSubview(vc8!.view)
        
        vcControllers = [vc1!, vc2!, vc3!, vc4!, vc5!, vc6!, vc7!, vc8!]
        
        filtroView = UIView(frame: CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen))
        filtroView?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.addSubview(filtroView!)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(sender:)))
        swipeGesture?.direction = .down
        filtroView?.addGestureRecognizer(swipeGesture!)
        
        typeFoodView = UIView(frame: CGRect(x: 0, y: hScreen * 0.5, width: wScreen, height: hScreen))
        typeFoodView?.backgroundColor = UIColor.white
        typeFoodView?.layer.cornerRadius = 10.0
        filtroView?.addSubview(typeFoodView!)
        
        let viewTop = UIView(frame: CGRect(x: wScreen * 0.41, y: hScreen * 0.015, width: wScreen * 0.18, height: wScreen * 0.01))
        viewTop.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        viewTop.layer.cornerRadius = 2.0
        typeFoodView?.addSubview(viewTop)
        
        avatarImg = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.04, width: wScreen * 0.15, height: wScreen * 0.15))
        avatarImg?.layer.cornerRadius = avatarImg!.frame.width/2
        avatarImg?.layer.masksToBounds = true
        typeFoodView?.addSubview(avatarImg!)
        
        let visualizarText = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.03, y: hScreen * 0.065, width: wScreen * 0.3, height: hScreen * 0.03))
        visualizarText.text = "Visualizar por"
        visualizarText.font = UIFont(name: "roboto-black", size: 18)
        typeFoodView?.addSubview(visualizarText)
        
        let typeText = UILabel(frame: CGRect(x: avatarImg!.frame.maxX + wScreen * 0.04, y: visualizarText.frame.maxY + 1, width: wScreen * 0.3, height: hScreen * 0.02))
        typeText.text = "tipo de comida"
        typeText.font = UIFont(name: "HelveticaNeue", size: 12)
        typeText.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        typeFoodView?.addSubview(typeText)
        
        let btnToMaps = UIButton(type: .custom)
        btnToMaps.frame = CGRect(x: wScreen - wScreen * 0.33, y: hScreen * 0.057, width: wScreen * 0.28, height: hScreen * 0.052)
        btnToMaps.setImage(#imageLiteral(resourceName: "cercaEx2"), for: .normal)
        btnToMaps.addTarget(self, action: #selector(goMaps), for: .touchUpInside)
        typeFoodView?.addSubview(btnToMaps)
        
        let separacion = UIView(frame: CGRect(x: 0, y: avatarImg!.frame.maxY + hScreen * 0.025, width: wScreen, height: 1))
        separacion.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        typeFoodView?.addSubview(separacion)
        
        let carnesBtn = UIButton(type: .custom)
        carnesBtn.frame = CGRect(x: wScreen * 0.07, y: separacion.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        carnesBtn.setImage(#imageLiteral(resourceName: "carnes"), for: .normal)
        carnesBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        carnesBtn.tag = 1
        typeFoodView?.addSubview(carnesBtn)
        
        let mariscosBtn = UIButton(type: .custom)
        mariscosBtn.frame = CGRect(x: carnesBtn.frame.maxX + wScreen * 0.073, y: separacion.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        mariscosBtn.setImage(#imageLiteral(resourceName: "mariscos"), for: .normal)
        mariscosBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(mariscosBtn)
        
        let pastasBtn = UIButton(type: .custom)
        pastasBtn.frame = CGRect(x: mariscosBtn.frame.maxX + wScreen * 0.073, y: separacion.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        pastasBtn.setImage(#imageLiteral(resourceName: "pastas"), for: .normal)
        pastasBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(pastasBtn)
        
        let snacksBtn = UIButton(type: .custom)
        snacksBtn.frame = CGRect(x: pastasBtn.frame.maxX + wScreen * 0.073, y: separacion.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        snacksBtn.setImage(#imageLiteral(resourceName: "snacks"), for: .normal)
        snacksBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(snacksBtn)
        
        let orientalBtn = UIButton(type: .custom)
        orientalBtn.frame = CGRect(x: wScreen * 0.07, y: snacksBtn.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        orientalBtn.setImage(#imageLiteral(resourceName: "oriental"), for: .normal)
        orientalBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        orientalBtn.tag = 1
        typeFoodView?.addSubview(orientalBtn)
        
        let mexicanaBtn = UIButton(type: .custom)
        mexicanaBtn.frame = CGRect(x: orientalBtn.frame.maxX + wScreen * 0.073, y: snacksBtn.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        mexicanaBtn.setImage(#imageLiteral(resourceName: "mexicana"), for: .normal)
        mexicanaBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(mexicanaBtn)
        
        let europeaBtn = UIButton(type: .custom)
        europeaBtn.frame = CGRect(x: mexicanaBtn.frame.maxX + wScreen * 0.073, y: snacksBtn.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        europeaBtn.setImage(#imageLiteral(resourceName: "europea"), for: .normal)
        europeaBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(europeaBtn)
        
        let saludableBtn = UIButton(type: .custom)
        saludableBtn.frame = CGRect(x: europeaBtn.frame.maxX + wScreen * 0.073, y: snacksBtn.frame.maxY + wScreen * 0.07, width: wScreen * 0.16, height: wScreen * 0.2)
        saludableBtn.setImage(#imageLiteral(resourceName: "saludable"), for: .normal)
        saludableBtn.addTarget(self, action: #selector(foodTypeP), for: .touchUpInside)
        typeFoodView?.addSubview(saludableBtn)
        
        regContainer = UIView(frame: CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen))
        regContainer?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.addSubview(regContainer!)
        
        regSwipe = UISwipeGestureRecognizer(target: self, action: #selector(regDetected(sender:)))
        regSwipe?.direction = .down
        regContainer?.addGestureRecognizer(regSwipe!)
        
        regView = UIView(frame: CGRect(x: wScreen * 0.025, y: hScreen * 0.04, width: wScreen * 0.95, height: hScreen * 0.85))
        regView?.backgroundColor = .white
        regView?.layer.cornerRadius = 20.0
        regContainer?.addSubview(regView!)
        
        regImg = UIImageView(frame: CGRect(x: regView!.frame.width * 0.035, y: regView!.frame.height * 0.05, width: wScreen * 0.05, height: wScreen * 0.05))
        regImg?.image = #imageLiteral(resourceName: "regIcon")
        regView?.addSubview(regImg!)
        
        shareLabel = UILabel(frame: CGRect(x: regImg!.frame.maxX + regView!.frame.width * 0.04, y: regView!.frame.height * 0.045, width: wScreen * 0.25, height: wScreen * 0.065))
        shareLabel?.text = "compartir"
        shareLabel?.textColor = .black
        shareLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        shareLabel?.textAlignment = .left
        regView?.addSubview(shareLabel!)
        
        legendLabel = UILabel(frame: CGRect(x: shareLabel!.frame.maxX + regView!.frame.width * 0.1, y: regView!.frame.height * 0.05, width: wScreen * 0.4, height: wScreen * 0.065))
        legendLabel?.text = "regala esta experiencia"
        legendLabel?.textColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
        legendLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        legendLabel?.textAlignment = .left
        regView?.addSubview(legendLabel!)
        
        regImg = UIImageView(frame: CGRect(x: regView!.frame.width * 0.025, y: legendLabel!.frame.maxY + regView!.frame.height * 0.03, width: regView!.frame.width * 0.95, height: regView!.frame.height * 0.75))
        regImg?.image = #imageLiteral(resourceName: "reg")
        regView?.addSubview(regImg!)
        
        regPayBtn = UIButton(type: .custom)
        regPayBtn?.frame = CGRect(x: regView!.frame.width * 0.1, y: regImg!.frame.maxY, width: regView!.frame.width * 0.8, height: regView!.frame.height * 0.1)
        regPayBtn?.setImage(#imageLiteral(resourceName: "Buttonpp"), for: .normal)
        regView?.addSubview(regPayBtn!)
        
        regBackBtn = UIButton(type: .custom)
        regBackBtn?.frame = CGRect(x: wScreen * 0.25, y: regView!.frame.maxY + hScreen * 0.01, width: wScreen * 0.5, height: hScreen * 0.1)
        regBackBtn?.setTitle("Regresar", for: .normal)
        regBackBtn?.setTitleColor(.white, for: .normal)
        regBackBtn?.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        regBackBtn?.titleLabel?.textAlignment = .center
        regContainer?.addSubview(regBackBtn!)
        
    }
    
    // MARK: CollectionView PROTOCOL
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.x
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vcControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellGrid", for: indexPath) as! GridsContainerT
        
        cell.grid = vcControllers[indexPath.row]
        cell.contentView.addSubview(cell.grid.view)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (wScreen)
        
        return CGSize(width: cellWidth, height: hScreen * 0.66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    @objc func foodTypeP() {
        
    }
    
    @objc func goMaps() {
        
    }
    
    // Función de protocolo de scrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if container?.contentOffset.x == UIScreen.main.bounds.width * 0 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: (self.opc1!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Carnes"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 0
                
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 1 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: self.opc1!.frame.maxX + (self.opc1!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName2?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Mariscos"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 0
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 2 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: self.opc2!.frame.maxX + (self.opc3!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Pastas"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 0
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 3 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: self.opc3!.frame.maxX + (self.opc4!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Snacks"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 0
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 4 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: self.opc4!.frame.maxX + (self.opc5!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Oriental"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 1
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 5 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.foco?.frame = CGRect(x: self.opc5!.frame.maxX + (self.opc6!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Mexicana"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 1
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 6 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.foco?.frame = CGRect(x: self.opc6!.frame.maxX + (self.opc7!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName7?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.titulo?.text = "Europea"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 1
            }, completion: nil)
        } else if container?.contentOffset.x == UIScreen.main.bounds.width * 7 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.foco?.frame = CGRect(x: self.opc7!.frame.maxX + (self.opc8!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
                self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
                self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
                self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
                self.zoneName8?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
                self.titulo?.text = "Saludable"
                self.options?.contentOffset.x = UIScreen.main.bounds.width * 1
            }, completion: nil)
        }
    }
    
    // Funciones de la vista del filtro
    @objc func swipeDetected(sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5) {
            self.filtroView?.frame = CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen)
            self.filtroView?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
    }
    
    @objc func regDetected(sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5) {
            self.regContainer?.frame = CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen)
            self.regContainer?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
    }
    
    //Funciones de botones de header
    @objc func regalaPressed() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.regContainer?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.regContainer?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            })
        }
    }
    
    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
//    @objc func todosPressed() {
//
//        UIView.animate(withDuration: 0.5) {
//            self.container?.contentOffset.x = UIScreen.main.bounds.width * 0
//            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
//            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
//        }
//    }
    
    @objc func filtroPressed() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.filtroView?.frame = CGRect(x: 0, y: 0, width: wScreen, height: hScreen)
        }) { (true) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.filtroView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            })
        }
    }
    
    //Funciones de los botones de las opciones
    @objc func op1Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 0
            self.foco?.frame = CGRect(x: (self.opc1!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Carnes"
            
        }, completion: nil)
    }
    
    @objc func op2Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 1
            self.foco?.frame = CGRect(x: self.opc1!.frame.maxX + (self.opc2!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName2?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Mariscos"
        }, completion: nil)
    }
    
    @objc func op3Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 2
            self.foco?.frame = CGRect(x: self.opc2!.frame.maxX + (self.opc3!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Pastas"
        }, completion: nil)
    }
    
    @objc func op4Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 3
            self.foco?.frame = CGRect(x: self.opc3!.frame.maxX + (self.opc4!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Snacks"
        }, completion: nil)
    }
    
    @objc func op5Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 4
            self.foco?.frame = CGRect(x: self.opc4!.frame.maxX + (self.opc5!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Oriental"
        }, completion: nil)
    }
    
    @objc func op6Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 5
            self.foco?.frame = CGRect(x: self.opc5!.frame.maxX + (self.opc6!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Mexicana"
        }, completion: nil)
    }
    
    @objc func op7Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 6
            self.foco?.frame = CGRect(x: self.opc6!.frame.maxX + (self.opc7!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName7?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.titulo?.text = "Europea"
        }, completion: nil)
    }
    
    @objc func op8Pressed() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.container?.contentOffset.x = UIScreen.main.bounds.width * 7
            self.foco?.frame = CGRect(x: self.opc7!.frame.maxX + (self.opc8!.frame.width/2) - (wScreen * 0.19)/2, y: 0, width: wScreen * 0.19, height: wScreen * 0.19)
            self.zoneName7?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName2?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName3?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName4?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName5?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName6?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName1?.font = UIFont(name: "PlayfairDisplay-Regular", size: 12)
            self.zoneName8?.font = UIFont(name: "PlayfairDisplay-Bold", size: 12)
            self.zoneName7?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName2?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName3?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName4?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName5?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName6?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName1?.textColor = UIColor(red: 169/255, green: 174/255, blue: 180/255, alpha: 1)
            self.zoneName8?.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.titulo?.text = "Saludable"
        }, completion: nil)
    }
    
}

class GridsContainerT: UICollectionViewCell {
    
    var grid = UIViewController()
}
