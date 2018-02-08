//
//  Noticias.swift
//  Noticias
//
//  Created by David Valencia on 20/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit
import SDWebImage

class Noticias: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    var fecha: UILabel?
    var titulo: UILabel?
    var closeBtn: UIButton?
    var recetasBtn: UIButton?
    var moreBtn: UIButton?
    var layout: UICollectionViewFlowLayout?
    var newsContainer: UICollectionView?
    var dataSource = [NewsModel]()
    var bgImage: UIImageView?
    var bgMes: UIImageView?
    var mesActual: UILabel?
    var anioActual: UILabel?
    var blurEffect: UIBlurEffect?
    var blurEffectView: UIVisualEffectView?
    var newsBgBoard: UIView?
    var newsBoard: UIScrollView?
    var adorno: UIImageView?
    var swipeGesture: UISwipeGestureRecognizer?
    
    var autorImg: UIImageView?
    var newsTitle: UILabel?
    var newsCategory: UILabel?
    var newsIntro: UITextView?
    var newsImg1: UIImageView?
    var newsP1: UITextView?
    var newsP2: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color de status bar
        UIApplication.shared.statusBarStyle = .lightContent
        
        getData()
        loadInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInterface() {
        
        // Color de fondo de la pantalla
        view.backgroundColor = UIColor.white
        
        // Imagen de backgraund de la pantalla
        bgImage = UIImageView(image: #imageLiteral(resourceName: "bgNews"))
        bgImage?.frame = view.frame
        view.addSubview(bgImage!)
        
        // Header
//        fecha = UILabel(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.085, width: wScreen * 0.3, height: hScreen * 0.03))
//        fecha?.text = "Mayo 2018"
//        fecha?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
//        fecha?.textColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 0.6)
////        fecha?.backgroundColor = .red
//        view.addSubview(fecha!)
        
        titulo = UILabel(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.1, width: wScreen * 0.45, height: hScreen * 0.08))
        titulo?.text = "Noticias"
        titulo?.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        titulo?.textColor = UIColor.white
//        titulo?.backgroundColor = .blue
        view.addSubview(titulo!)
        
        closeBtn = UIButton(type: .custom)
        closeBtn?.frame = CGRect(x: wScreen * 0.91, y: hScreen * 0.06, width: wScreen * 0.04, height: wScreen * 0.04)
        closeBtn?.setImage(#imageLiteral(resourceName: "closeNewsB"), for: .normal)
        closeBtn?.addTarget(self, action: #selector(closeNewsP), for: .touchUpInside)
        view.addSubview(closeBtn!)
        
//        recetasBtn = UIButton(type: .custom)
//        recetasBtn?.frame = CGRect(x: wScreen * 0.5, y: hScreen * 0.1325, width: wScreen * 0.3, height: wScreen * 0.13)
//        recetasBtn?.setImage(#imageLiteral(resourceName: "recetasB"), for: .normal)
//        recetasBtn?.addTarget(self, action: #selector(recetasP), for: .touchUpInside)
//        view.addSubview(recetasBtn!)
        
        bgMes = UIImageView(image: #imageLiteral(resourceName: "new-b"))
        bgMes?.frame = CGRect(x: wScreen * 0.5, y: hScreen * 0.1125, width: wScreen * 0.3, height: wScreen * 0.13)
        view.addSubview(bgMes!)
        
        mesActual = UILabel(frame: CGRect(x: wScreen * 0.51, y: hScreen * 0.118, width: wScreen * 0.28, height: wScreen * 0.08))
        mesActual?.text = "Febrero"
        mesActual?.textColor = UIColor.white
        mesActual?.font = UIFont(name: "Roboto-Bold", size: 13.5)
        mesActual?.textAlignment = .center
        view.addSubview(mesActual!)
        
        anioActual = UILabel(frame: CGRect(x: mesActual!.frame.maxX, y: hScreen * 0.12, width: wScreen * 0.2, height: wScreen * 0.07))
        anioActual?.text = "2018"
        anioActual?.textColor = UIColor.white
        anioActual?.font = UIFont(name: "Roboto-Bold", size: 13.5)
        anioActual?.textAlignment = .center
        view.addSubview(anioActual!)
        
//        moreBtn = UIButton(type: .system)
//        moreBtn?.frame = CGRect(x: recetasBtn!.frame.maxX, y: hScreen * 0.14, width: wScreen * 0.2, height: wScreen * 0.07)
//        moreBtn?.setTitle("más...", for: .normal)
//        moreBtn?.setTitleColor(UIColor(red: 137/255, green: 177/255, blue: 255/255, alpha: 1), for: .normal)
//        moreBtn?.addTarget(self, action: #selector(moreP), for: .touchUpInside)
////        moreBtn?.backgroundColor = UIColor.darkGray
//        view.addSubview(moreBtn!)
        
        // CollectionView
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .vertical
        layout?.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout?.minimumLineSpacing = 15.0
        layout?.itemSize = CGSize(width: wScreen * 0.86, height: hScreen * 0.58)
        
        newsContainer = UICollectionView(frame: CGRect(x: wScreen * 0.07, y: hScreen * 0.2, width: wScreen * 0.86, height: hScreen * 0.8), collectionViewLayout: layout!)
        newsContainer?.register(ContentNews.self, forCellWithReuseIdentifier: "newsCell")
        newsContainer?.isScrollEnabled = true
        newsContainer?.delegate = self
        newsContainer?.dataSource = self
        newsContainer?.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(newsContainer!)
        
        blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0
        view.addSubview(blurEffectView!)
    
        newsBgBoard = UIView(frame: CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen))
        newsBgBoard?.backgroundColor = UIColor.white
        newsBgBoard?.layer.cornerRadius = 20.0
        newsBgBoard?.alpha = 0
        view.addSubview(newsBgBoard!)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(sender:)))
        swipeGesture?.direction = .down
        newsBgBoard?.addGestureRecognizer(swipeGesture!)
        
        adorno = UIImageView(image: #imageLiteral(resourceName: "adornoGris"))
        adorno?.frame = CGRect(x: wScreen * 0.4, y: hScreen * 0.02, width: wScreen * 0.2, height: wScreen * 0.012)
        newsBgBoard?.addSubview(adorno!)
        
        newsBoard = UIScrollView(frame: CGRect(x: 0, y: newsBgBoard!.frame.height * 0.04, width: wScreen, height: newsBgBoard!.frame.height * 0.83))
        newsBoard?.delegate = self
        newsBoard?.alwaysBounceHorizontal = false
        newsBoard?.bounces = false
        newsBoard?.isScrollEnabled = true
        newsBoard?.isPagingEnabled = false
        newsBgBoard?.addSubview(newsBoard!)
        
        autorImg = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.02, width: wScreen * 0.15, height: wScreen * 0.15))
        autorImg?.layer.cornerRadius = autorImg!.frame.width/2
        autorImg?.layer.masksToBounds = true
        newsBoard?.addSubview(autorImg!)
        
        newsTitle = UILabel(frame: CGRect(x: autorImg!.frame.maxX + wScreen * 0.03, y: hScreen * 0.02, width: wScreen * 0.45, height: wScreen * 0.16))
        newsTitle?.textColor = UIColor.black
        newsTitle?.font = UIFont(name: "Roboto-Bold", size: 20)
        newsTitle?.numberOfLines = 2
        newsBoard?.addSubview(newsTitle!)
        
        newsCategory = UILabel(frame: CGRect(x: wScreen * 0.75, y: hScreen * 0.02, width: wScreen * 0.2, height: wScreen * 0.11))
        newsCategory?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 12)
        newsCategory?.textColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1)
        newsBoard?.addSubview(newsCategory!)
        
        newsIntro = UITextView(frame: CGRect(x: wScreen * 0.05, y: newsTitle!.frame.maxY + wScreen * 0.05, width: wScreen * 0.9, height: wScreen * 0.3))
        newsIntro?.font = UIFont(name: "Roboto-Light", size: 14.5)
        newsIntro?.textColor = UIColor.black
        newsBoard?.addSubview(newsIntro!)
        
        newsImg1 = UIImageView(frame: CGRect(x: wScreen * 0.05, y: newsIntro!.frame.maxY + wScreen * 0.05, width: wScreen * 0.9, height: wScreen * 0.4))
        newsBoard?.addSubview(newsImg1!)
        
        newsP1 = UITextView(frame: CGRect(x: wScreen * 0.05, y: newsImg1!.frame.maxY + wScreen * 0.05, width: wScreen * 0.9, height: wScreen * 0.3))
        newsP1?.font = UIFont(name: "Roboto-Light", size: 14.5)
        newsP1?.textColor = UIColor.black
        newsBoard?.addSubview(newsP1!)
        
        newsP2 = UITextView(frame: CGRect(x: wScreen * 0.05, y: newsP1!.frame.maxY + wScreen * 0.05, width: wScreen * 0.9, height: wScreen * 0.3))
        newsP2?.font = UIFont(name: "Roboto-Light", size: 14.5)
        newsP2?.textColor = UIColor.black
        newsBoard?.addSubview(newsP2!)
        
        newsBoard?.contentSize = CGSize(width: wScreen, height: newsP2!.frame.maxY)
    }
    
    // Selectores de interfaz
    @objc func closeNewsP() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func moreP() {
        
    }
    
    @objc func swipeDetected(sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.newsBgBoard?.frame = CGRect(x: 0, y: hScreen, width: wScreen, height: hScreen)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.newsBgBoard?.alpha = 0
                self.blurEffectView?.alpha = 0
            })
        }
    }
    
    // Petición a webservice
    func getData() {
        let url = URL(string: "http://104.236.10.17/api/noticias/") // se convirete el string url a untipo de dato URL
        
        var request = URLRequest(url: url!) //inicializacion del Request
        request.httpMethod = "GET" //tipo de peticion
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
                print("Ocurrio un error al obtener el json")
            }
            
            DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                
//                self.refresher?.endRefreshing()
                
            })
            
            do{
                //control de errores desconocidos (TRY) en la serializacion del json
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Any>
                //print(json)
                if json.count > 0{ //numero de post en el json
                    self.dataSource.removeAll()
                    for obj in json{ //Recorrido de todos los post en el json
                        let objeAux = obj as! NSDictionary
                        let noticia = NewsModel(dictionary: objeAux)
                        self.dataSource.append(noticia)
                        
                    }
                    
                    
                    DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                        
                        self.newsContainer?.reloadData()
                        
                    })
                    
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

    // MARK: UICollectionView Protocol Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! ContentNews
        let cellWidth = cell.frame.width
        let cellHeight = cell.frame.height
        
        cell.layer.cornerRadius = 15.0
        cell.backgroundColor = UIColor.darkGray
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.4
        
        
        cell.newsBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        cell.newsBackground.layer.cornerRadius = 15.0
        cell.newsBackground.layer.masksToBounds = true
        if let url = URL(string: "http://104.236.10.17" + dataSource[indexPath.row].imagen_principal) {
            print(url)
            cell.newsBackground.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            cell.newsBackground.image = #imageLiteral(resourceName: "sin-back")
        }
        cell.contentView.addSubview(cell.newsBackground)
        
        cell.autorImg = UIImageView(frame: CGRect(x: cellWidth * 0.05, y: cellWidth * 0.05, width: cellWidth * 0.15, height: cellWidth * 0.15))
        cell.autorImg.layer.cornerRadius = cell.frame.width * 0.075
        cell.autorImg.layer.masksToBounds = true
        if let url = URL(string: "http://104.236.10.17" + dataSource[indexPath.row].imagen_autor!) {
            cell.autorImg.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            cell.autorImg.image = #imageLiteral(resourceName: "sin-back")
        }
        cell.contentView.addSubview(cell.autorImg)
//
        cell.autorName = UILabel(frame: CGRect(x: cell.autorImg.frame.maxX + cellWidth * 0.02, y: cellWidth * 0.07, width: cellWidth * 0.5, height: cellHeight * 0.05))
        cell.autorName.textColor = UIColor.white
        cell.autorName.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        if dataSource[indexPath.row].autor != nil {
            cell.autorName.text = dataSource[indexPath.row].autor
        } else {
            cell.autorName.text = ""
        }
        cell.contentView.addSubview(cell.autorName)
//
        cell.newsDate = UILabel(frame: CGRect(x: cell.autorImg.frame.maxX + cellWidth * 0.02, y: cell.autorName.frame.maxY, width: cellWidth * 0.4, height: cellHeight * 0.04))
        cell.newsDate.textColor = UIColor.white
        cell.newsDate.font = UIFont(name: "HelveticaNeue-Bold", size: 10.5)
        if dataSource[indexPath.row].fecha != nil {
            cell.newsDate.text = dataSource[indexPath.row].fecha
        } else {
            cell.newsDate.text = ""
        }
        cell.contentView.addSubview(cell.newsDate)
//
        cell.category = UILabel(frame: CGRect(x: cellWidth * 0.05, y: cellHeight * 0.38, width: cellWidth * 0.5, height: cellHeight * 0.05))
        cell.category.textColor = UIColor(red: 242/255, green: 244/255, blue: 243/255, alpha: 1)
        cell.category.font = UIFont(name: "AvenirNextCondensed-DemiBold ", size: 12.5)
        if dataSource[indexPath.row].categoria != nil {
            cell.category.text = dataSource[indexPath.row].categoria
        } else {
            cell.category.text = ""
        }
        cell.contentView.addSubview(cell.category)
//
        cell.newsName = UILabel(frame: CGRect(x: cellWidth * 0.05, y: cell.category.frame.maxY, width: cellWidth * 0.8, height: cellHeight * 0.2))
        cell.newsName.textColor = UIColor.white
        cell.newsName.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20.5)
        cell.newsName.numberOfLines = 2
        if dataSource[indexPath.row].nombre != nil {
            cell.newsName.text = dataSource[indexPath.row].nombre
        } else {
            cell.newsName.text = ""
        }
        cell.contentView.addSubview(cell.newsName)
//
        cell.newsSubtitle = UILabel(frame: CGRect(x: cellWidth * 0.05, y: cell.newsName.frame.maxY, width: cellWidth * 0.8, height: cellHeight * 0.2))
        cell.newsSubtitle.textColor = UIColor.white
        cell.newsSubtitle.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 13.5)
        cell.newsSubtitle.numberOfLines = 3
        if dataSource[indexPath.row].subtitulo != nil {
            cell.newsSubtitle.text = dataSource[indexPath.row].subtitulo
        } else {
            cell.newsSubtitle.text = ""
        }
        cell.contentView.addSubview(cell.newsSubtitle)
        
        cell.line = UIView(frame: CGRect(x: 0, y: cell.newsSubtitle.frame.maxY + cellHeight * 0.05, width: cellWidth, height: 0.5))
        cell.line.backgroundColor = UIColor.white
        cell.contentView.addSubview(cell.line)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let url = URL(string: "http://104.236.10.17" + dataSource[indexPath.row].imagen_autor!) {
            autorImg?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            
        }
        
        newsTitle?.text = dataSource[indexPath.row].nombre
        newsCategory?.text = dataSource[indexPath.row].categoria
        newsIntro?.text = dataSource[indexPath.row].introduccion
        
        if let url = URL(string: "http://104.236.10.17" + dataSource[indexPath.row].imagen_principal) {
            newsImg1?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
        } else {
            
        }
        
        newsP1?.text = dataSource[indexPath.row].parrafo1
        newsP2?.text = dataSource[indexPath.row].parrafo2
        
        UIView.animate(withDuration: 0.5) {
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blurEffectView?.alpha = 1
            self.newsBgBoard?.alpha = 1
        }) { (true) in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.newsBgBoard?.frame = CGRect(x: 0, y: hScreen * 0.13, width: wScreen, height: hScreen)
            })
        }
    }
}

class ContentNews: UICollectionViewCell {
    
    var newsBackground = UIImageView()
    var autorImg = UIImageView()
    var autorName = UILabel()
    var newsDate = UILabel()
    var category = UILabel()
    var newsName = UILabel()
    var newsSubtitle = UILabel()
    var line = UIView()
}
