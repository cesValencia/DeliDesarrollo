//
//  DemoTableViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 24/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoTableViewController: ExpandingTableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //VARIABLES PARA EL ARRASTRAR VARIABLES AL SIGUIENTE CONTROLLADOR
    //Urls
    var categorias: String?
    var categoria1: String?
    var categoria2: String?
    var categoria3: String?
    var categoria4: String?
    var categoria5: String?
    var categoria6: String?
    var categoria7: String?
    var categoria8: String?
    var c1 = Paging()
    var c2 = Paging()
    var c3 = Paging()
    var c4 = Paging()
    var c5 = Paging()
    var c6 = Paging()
    var c7 = Paging()
    var c8 = Paging()
    var cName1 = (category: "Diamante", desc: "restaurantes & bistrò")
    var cName2 = (category: "Mixología", desc: "lounges & bares")
    var cName3 = (category: "Platino", desc: "restaurantes & bistrò")
    var cName4 = (category: "Plata", desc: "restaurantes & pubs")
    var cName5 = (category: "Antojo", desc: "antojerías y snacks")
    var cName6 = (category: "Bares", desc: "pubs, bares & cantinas")
    var cName7 = (category: "Postres", desc: "café, pasteles & helados")
    var cName8 = (category: "Verdes", desc: "vegana & vegetariana")
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
    var tabBarView: UIView?
    var tabBtn1: UIButton?
    var tabBtn2: UIButton?
    var tabBtn3: UIButton?
    var tabBtn4: UIButton?
    var tabAvatar: UIImageView?
    var dataSource = [Restaurant]()
    var dataSourceForDiamond = [Restaurant]()
    var dataSourceForPlatinum = [Restaurant]()
    var dataSourceForMixology = [Restaurant]()
    var dataSourceForSilver = [Restaurant]()
    var dataSourceForGreen = [Restaurant]()
    var dataSourceForSnacks = [Restaurant]()
    var dataSourceForPubs = [Restaurant]()
    var dataSourceForCakes = [Restaurant]()
    var statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    
    //Arreglos que muestran contenido del carrusel de experiencias
    var imgA = [UIImage]()
    var precioA = [UIImage]()
    var tituloA = [String]()
    var subtituloA = [String]()
    var realA = [String]()
    var botonArray = [String]()
    
    // Vista de medalla
    var medalView: UIView?
    
    //Caruusel Ex 2 arreglo
    var sugeridosC = [UIImage]()
    
    //Nombre de los collectionViews
    var collectionEx: UICollectionView?
    var collectionEx2: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var layout2: UICollectionViewFlowLayout?
    
    var identifiers = ["201", "202", "203", "204", "205", "206", "207", "208", "209", "210"]
  
    @IBOutlet weak var containerView: UIView!
    
    //fileprivate var scrollOffsetY: CGFloat = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Status bar
    statusBar.backgroundColor = UIColor.white.withAlphaComponent(0)
    UIApplication.shared.statusBarStyle = .lightContent
    
    //NUEVAS VARIABLES
    categorias = "http://104.236.10.17/api/restaurantes"
    categoria1 = "http://104.236.10.17/api/restaurantes/categoria/1"
    categoria2 = "http://104.236.10.17/api/restaurantes/categoria/2"
    categoria3 = "http://104.236.10.17/api/restaurantes/categoria/3"
    categoria4 = "http://104.236.10.17/api/restaurantes/categoria/4"
    categoria5 = "http://104.236.10.17/api/restaurantes/categoria/5"
    categoria6 = "http://104.236.10.17/api/restaurantes/categoria/6"
    categoria7 = "http://104.236.10.17/api/restaurantes/categoria/7"
    categoria8 = "http://104.236.10.17/api/restaurantes/categoria/8"
    
    cColor1 = headColor1
    
    botones()
    
    btnArray = [boton!, boton2!, boton3!, boton4!, boton5!, boton6!, boton7!, boton8!]
    

    
    //Contenido de los arreglos de carrusel de experiencias
    imgA = [UIImage(named: "PostresEx")!, UIImage(named: "BaresEx")!, UIImage(named: "AntojoEx")!, UIImage(named: "VerdeEx")!, UIImage(named: "PlataEx")!, UIImage(named: "MixoEx")!, UIImage(named: "PlatinoEx")!, UIImage(named: "DiamanteEx")!]
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
    collectionEx?.register(CollectionViewEx.self, forCellWithReuseIdentifier: "cell")
    collectionEx?.bounces = true
    collectionEx?.backgroundColor = UIColor.white
    collectionEx?.delegate = self
    collectionEx?.dataSource = self
    containerView.addSubview(collectionEx!)
    
    medalView = UIView(frame: CGRect(x: 0, y: collectionEx!.frame.maxY + 10, width: wScreen * 0.13, height: wScreen * 0.25))
    medalView?.backgroundColor = UIColor(red: 90/255, green: 110/255, blue: 241/255, alpha: 1)
    containerView.addSubview(medalView!)
    
    let medalImg = UIImageView(frame: CGRect(x: (medalView!.frame.width/2) - (wScreen * 0.04)/2, y: (medalView!.frame.height/2) - (wScreen * 0.05)/2, width: wScreen * 0.04, height: wScreen * 0.05))
    medalImg.image = #imageLiteral(resourceName: "medall")
    medalView?.addSubview(medalImg)
    
    //CollectionView2
    collectionEx2 = UICollectionView(frame: CGRect(x: wScreen - (wScreen * 0.85), y: collectionEx!.frame.maxY + 10, width: wScreen * 0.85, height: wScreen * 0.25), collectionViewLayout: layout2!)
    collectionEx2?.register(CollectionViewEx2.self, forCellWithReuseIdentifier: "cell2")
    collectionEx2?.bounces = true
    collectionEx2?.backgroundColor = UIColor.white
    collectionEx2?.delegate = self
    collectionEx2?.dataSource = self
    containerView.addSubview(collectionEx2!)
    
    // TabBar
    tabBarView = UIView(frame: CGRect(x: 0, y: collectionEx2!.frame.maxY, width: wScreen, height: hScreen * 0.1))
    tabBarView?.backgroundColor = UIColor.white
    containerView.addSubview(tabBarView!)
    
    tabBtn1 = UIButton(type: .custom)
    tabBtn1?.frame = CGRect(x: wScreen * 0.08, y: tabBarView!.frame.height * 0.2, width: wScreen * 0.1, height: wScreen * 0.1)
    tabBtn1?.setImage(#imageLiteral(resourceName: "tabIcon1"), for: .normal)
    tabBtn1?.addTarget(self, action: #selector(tab1Pressed), for: .touchUpInside)
    tabBarView?.addSubview(tabBtn1!)
    
    tabBtn2 = UIButton(type: .custom)
    tabBtn2?.frame = CGRect(x: tabBtn1!.frame.maxX + (wScreen * 0.08), y: tabBarView!.frame.height * 0.2, width: wScreen * 0.1, height: wScreen * 0.1)
    tabBtn2?.setImage(#imageLiteral(resourceName: "tabIcon2"), for: .normal)
    tabBtn2?.addTarget(self, action: #selector(tab2Pressed), for: .touchUpInside)
    tabBarView?.addSubview(tabBtn2!)
    
    tabBtn3 = UIButton(type: .custom)
    tabBtn3?.frame = CGRect(x: tabBtn2!.frame.maxX + (wScreen * 0.08), y: tabBarView!.frame.height * 0.2, width: wScreen * 0.1, height: wScreen * 0.1)
    tabBtn3?.setImage(#imageLiteral(resourceName: "tabIcon3"), for: .normal)
    tabBtn3?.addTarget(self, action: #selector(tab3Pressed), for: .touchUpInside)
    tabBarView?.addSubview(tabBtn3!)
    
    tabBtn4 = UIButton(type: .custom)
    tabBtn4?.frame = CGRect(x: tabBtn3!.frame.maxX + (wScreen * 0.08), y: tabBarView!.frame.height * 0.2, width: wScreen * 0.1, height: wScreen * 0.1)
    tabBtn4?.setImage(#imageLiteral(resourceName: "tabIcon4"), for: .normal)
    tabBtn4?.addTarget(self, action: #selector(tab4Pressed), for: .touchUpInside)
    tabBarView?.addSubview(tabBtn4!)
    
    tabAvatar = UIImageView(frame: CGRect(x: tabBtn4!.frame.maxX + (wScreen * 0.08), y: tabBarView!.frame.height * 0.15, width: wScreen * 0.12, height: wScreen * 0.12))
    tabAvatar?.image = #imageLiteral(resourceName: "avatar")
    tabBarView?.addSubview(tabAvatar!)
    
    configureNavBar()
//    let image1 = Asset.backgroundImage.image
//    tableView.backgroundView = UIImageView(image: image1)
    
    getData()
    
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
    
    @objc func tab1Pressed() {
        
    }
    
    @objc func tab2Pressed() {
        
    }
    
    @objc func tab3Pressed() {
        
    }
    
    @objc func tab4Pressed() {
        
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
        c1.urlJson = categorias
        c1.topColor = cColor1
        c1.categoryName = cName7.category
        c1.categoryDesc = cName7.desc
        c1.dataSourceForDiamond2 = dataSourceForDiamond
        c1.dataSourceForPlatinum2 = dataSourceForPlatinum
        c1.dataSourceForMixology2 = dataSourceForMixology
        c1.dataSourceForSilver2 = dataSourceForSilver
        c1.dataSourceForGreen2 = dataSourceForGreen
        c1.dataSourceForSnacks2 = dataSourceForSnacks
        c1.dataSourceForPubs2 = dataSourceForPubs
        c1.dataSourceForCakes2 = dataSourceForCakes

        self.navigationController?.pushViewController(c1, animated: true)
    }
    
    @objc func pressed2() {
        
        c2.urlJson = categorias
        c2.topColor = cColor1
        c2.categoryName = cName6.category
        c2.categoryDesc = cName6.desc
        c2.dataSourceForDiamond2 = dataSourceForDiamond
        c2.dataSourceForPlatinum2 = dataSourceForPlatinum
        c2.dataSourceForMixology2 = dataSourceForMixology
        c2.dataSourceForSilver2 = dataSourceForSilver
        c2.dataSourceForGreen2 = dataSourceForGreen
        c2.dataSourceForSnacks2 = dataSourceForSnacks
        c2.dataSourceForPubs2 = dataSourceForPubs
        c2.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c2, animated: true)
    }
    
    @objc func pressed3() {
        
        c3.urlJson = categorias
        c3.topColor = cColor1
        c3.categoryName = cName5.category
        c3.categoryDesc = cName5.desc
        c3.dataSourceForDiamond2 = dataSourceForDiamond
        c3.dataSourceForPlatinum2 = dataSourceForPlatinum
        c3.dataSourceForMixology2 = dataSourceForMixology
        c3.dataSourceForSilver2 = dataSourceForSilver
        c3.dataSourceForGreen2 = dataSourceForGreen
        c3.dataSourceForSnacks2 = dataSourceForSnacks
        c3.dataSourceForPubs2 = dataSourceForPubs
        c3.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c3, animated: true)
    }
    
    @objc func pressed4() {
        
        c4.urlJson = categorias
        c4.topColor = cColor1
        c4.categoryName = cName8.category
        c4.categoryDesc = cName8.desc
        c4.dataSourceForDiamond2 = dataSourceForDiamond
        c4.dataSourceForPlatinum2 = dataSourceForPlatinum
        c4.dataSourceForMixology2 = dataSourceForMixology
        c4.dataSourceForSilver2 = dataSourceForSilver
        c4.dataSourceForGreen2 = dataSourceForGreen
        c4.dataSourceForSnacks2 = dataSourceForSnacks
        c4.dataSourceForPubs2 = dataSourceForPubs
        c4.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c4, animated: true)
    }
    
    @objc func pressed5() {
        
        c5.urlJson = categorias
        c5.topColor = cColor1
        c5.categoryName = cName4.category
        c5.categoryDesc = cName4.desc
        c5.dataSourceForDiamond2 = dataSourceForDiamond
        c5.dataSourceForPlatinum2 = dataSourceForPlatinum
        c5.dataSourceForMixology2 = dataSourceForMixology
        c5.dataSourceForSilver2 = dataSourceForSilver
        c5.dataSourceForGreen2 = dataSourceForGreen
        c5.dataSourceForSnacks2 = dataSourceForSnacks
        c5.dataSourceForPubs2 = dataSourceForPubs
        c5.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c5, animated: true)
    }
    
    @objc func pressed6() {
        
        c6.urlJson = categorias
        c6.topColor = cColor1
        c6.categoryName = cName2.category
        c6.categoryDesc = cName2.desc
        c6.dataSourceForDiamond2 = dataSourceForDiamond
        c6.dataSourceForPlatinum2 = dataSourceForPlatinum
        c6.dataSourceForMixology2 = dataSourceForMixology
        c6.dataSourceForSilver2 = dataSourceForSilver
        c6.dataSourceForGreen2 = dataSourceForGreen
        c6.dataSourceForSnacks2 = dataSourceForSnacks
        c6.dataSourceForPubs2 = dataSourceForPubs
        c6.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c6, animated: true)
    }
    
    @objc func pressed7() {
        
        c7.urlJson = categorias
        c7.topColor = cColor1
        c7.categoryName = cName3.category
        c7.categoryDesc = cName3.desc
        c7.dataSourceForDiamond2 = dataSourceForDiamond
        c7.dataSourceForPlatinum2 = dataSourceForPlatinum
        c7.dataSourceForMixology2 = dataSourceForMixology
        c7.dataSourceForSilver2 = dataSourceForSilver
        c7.dataSourceForGreen2 = dataSourceForGreen
        c7.dataSourceForSnacks2 = dataSourceForSnacks
        c7.dataSourceForPubs2 = dataSourceForPubs
        c7.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c7, animated: true)
    }
    
    @objc func pressed8() {
        
        c8.urlJson = categorias
        c8.topColor = cColor1
        c8.categoryName = cName1.category
        c8.categoryDesc = cName1.desc
        c8.dataSourceForDiamond2 = dataSourceForDiamond
        c8.dataSourceForPlatinum2 = dataSourceForPlatinum
        c8.dataSourceForMixology2 = dataSourceForMixology
        c8.dataSourceForSilver2 = dataSourceForSilver
        c8.dataSourceForGreen2 = dataSourceForGreen
        c8.dataSourceForSnacks2 = dataSourceForSnacks
        c8.dataSourceForPubs2 = dataSourceForPubs
        c8.dataSourceForCakes2 = dataSourceForCakes
        
        self.navigationController?.pushViewController(c8, animated: true)
    }
    
    //Serializando JSON
    func getData() {
        let url = URL(string: categorias!) // se convirete el string url a untipo de dato URL
        
        var request = URLRequest(url: url!) //inicializacion del Request
        request.httpMethod = "GET" //tipo de peticion
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
                print("Ocurrio un error al obtener el json")
            }
            do{
                //control de errores desconocidos (TRY) en la serializacion del json
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Any>
                //print(json)
                if json.count > 0{ //numero de post en el json
                    self.dataSource.removeAll()
                    for obj in json{ //Recorrido de todos los post en el json
                        let objeAux = obj as! NSDictionary
                        let restaurante = Restaurant(dictionary: objeAux)
//                                                self.dataSource.append(restaurante);
                        
                        switch restaurante.categoria.lowercased() {
                        case "diamante":
                            self.dataSourceForDiamond.append(restaurante)
                        case "platino":
                            self.dataSourceForPlatinum.append(restaurante)
                        case "mixologia":
                            self.dataSourceForMixology.append(restaurante)
                        case "plata":
                            self.dataSourceForSilver.append(restaurante)
                        case "verdes":
                            self.dataSourceForGreen.append(restaurante)
                        case "antojo":
                            self.dataSourceForSnacks.append(restaurante)
                        case "bares":
                            self.dataSourceForPubs.append(restaurante)
                        default:
                            self.dataSourceForCakes.append(restaurante)
                        }

                    }
                    
                }
                else{
                    print("Sin datos")
                }
            }
            catch{
                print("Error Serializando del Json")
            }
            }.resume() //ejecuta el URLSession
        
    }
    
    
    /*DashboardView*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionEx {

            return imgA.count
        }else {

            return sugeridosC.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionEx{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewEx
            
            //            cell.setSubviews()
            
            cell.imgEx.image = imgA[indexPath.row]
            cell.imgEx.frame = CGRect(x: cell.frame.width * 0.1365, y: 0, width: cell.frame.width * 0.727, height: cell.frame.width * 0.727)
            cell.contentView.addSubview(cell.imgEx)
            
            cell.precio.image = precioA[indexPath.row]
            cell.precio.frame = CGRect(x: cell.frame.width * 0.125, y: cell.imgEx.frame.maxY + 15, width: cell.frame.width * 0.3, height: cell.frame.height * 0.076)
            cell.contentView.addSubview(cell.precio)
            
            cell.titulo.text = tituloA[indexPath.row]
            cell.titulo.frame = CGRect(x: cell.frame.width * 0.1365, y: cell.precio.frame.maxY + 5.3, width: cell.frame.width * 0.85, height: cell.frame.height * 0.1)
            cell.titulo.font = UIFont(name: "Roboto-Bold", size: 19.5)
            cell.titulo.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            cell.contentView.addSubview(cell.titulo)
            
            cell.subtitulo.text = subtituloA[indexPath.row]
            cell.subtitulo.frame = CGRect(x: cell.frame.width * 0.1365, y: cell.titulo.frame.maxY + 0.5, width: cell.frame.width * 0.85, height: cell.frame.height * 0.13)
            cell.subtitulo.font = UIFont(name: "Montserrat-Light", size: 14)
            cell.subtitulo.numberOfLines = 2
            cell.subtitulo.textColor = UIColor.black.withAlphaComponent(0.5)
            cell.contentView.addSubview(cell.subtitulo)
            
            cell.precioReal.text = realA[indexPath.row]
            cell.precioReal.frame = CGRect(x: cell.frame.width * 0.1365, y: cell.subtitulo.frame.maxY + 0.6, width: cell.frame.width * 0.85, height: cell.frame.height * 0.13)
            cell.precioReal.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
            cell.precioReal.numberOfLines = 2
            cell.precioReal.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.3)
            cell.contentView.addSubview(cell.precioReal)
            
            cell.btn = btnArray[indexPath.row]
            cell.btn.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            cell.contentView.addSubview(cell.btn)
            
            cell.lineSpace.frame = CGRect(x: cell.frame.width - cell.frame.width * 0.01, y: 0, width: cell.frame.width * 0.005, height: cell.frame.height)
            cell.lineSpace.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            cell.contentView.addSubview(cell.lineSpace)
            
            
            cell.backgroundColor = UIColor.white
            
            return cell
        }else{

            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewEx2

            cell2.sugeridos.frame = CGRect(x: 0, y: 0, width: cell2.frame.width * 0.98, height: cell2.frame.height)
            cell2.sugeridos.image = sugeridosC[indexPath.row]
            cell2.backgroundColor = UIColor.white
            cell2.layer.cornerRadius = 3.0
            cell2.contentView.addSubview(cell2.sugeridos)

            return cell2
        }
        


    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let id = botonArray[indexPath.row];
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)//instanciamos nuestro story
//
//        let siguienteViewController = storyBoard.instantiateViewController(withIdentifier: id)
//        let naviController = UINavigationController(rootViewController: siguienteViewController)
//        present(naviController, animated: true, completion: nil)
        
//        self.present(siguienteViewController, animated: true, completion: nil)//mostrar nuestro viewcontroller
        
        //let viewController = storyboard?.instantiateViewController(withIdentifier: id);
//        self.navigationController?.pushViewController(siguienteViewController, animated: true)
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }*/
    
    
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!

}



// MARK: - Lifecycle
extension DemoTableViewController {
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    guard let titleView = navigationItem.titleView else { return }
    let center = UIScreen.main.bounds.midX
    let diff = center - titleView.frame.midX
    titleImageViewXConstraint.constant = diff
  }
  
}

// MARK: Helpers
extension DemoTableViewController {
  
  fileprivate func configureNavBar() {
   
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
  
}

// MARK: Actions
extension DemoTableViewController {
  
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
extension DemoTableViewController {
  
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
    
    //scrollOffsetY = scrollView.contentOffset.y
  }
}

extension DemoTableViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionEx {
            let cellWidth = wScreen * 0.38
            
            return CGSize(width: cellWidth, height: collectionEx!.frame.height * 0.93)
        } else {
            
            let cellWidth = wScreen * 0.65
            
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
