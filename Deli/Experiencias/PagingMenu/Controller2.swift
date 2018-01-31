//
//  Controller2.swift
//  PagingMenu
//
//  Created by David Valencia on 16/11/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit
import SDWebImage

class Controller2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var gridContainer: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var imgArray = [UIImage]()
    var dataSourceForPlatino = [Restaurant]()
    var refresher: UIRefreshControl!
    var grid_images=[UIImage]();
    var lastContentOffset: CGFloat = 0.0
    var urlC: String?
    var parentController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        
        //Preloader
        refresher = UIRefreshControl()
        gridContainer?.addSubview(refresher!)
        refresher?.attributedTitle = NSAttributedString(string: "")
        refresher?.tintColor = UIColor(red: 98.00/255, green: 113.00/255, blue: 150.00/255, alpha: 1.0)
        refresher?.addTarget(self, action: #selector(nuevosRegistros), for: .valueChanged)
        
        //Serializando JSON
//        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Función que carga la interface
    func loadUI() {
        
        view.backgroundColor = UIColor.white
        
        //Inicializando cellArray
        //        imgArray = [UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!,UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!, UIImage(named: "hamImg")!]
        
        //Layout del collection view
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .vertical
        
        //CollectionView
        gridContainer = UICollectionView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.66), collectionViewLayout: layout!)
        gridContainer?.register(Content.self, forCellWithReuseIdentifier: "cell2")
        gridContainer?.bounces = true
        gridContainer?.backgroundColor = UIColor.white
        gridContainer?.delegate = self
        gridContainer?.dataSource = self
        view.addSubview(gridContainer!)
        
        
    }
    
    @objc func nuevosRegistros() {
        
        getData()
    }
    
    //Serializando JSON
    func getData() {
        let url = URL(string: urlC!) // se convirete el string url a untipo de dato URL
        
        var request = URLRequest(url: url!) //inicializacion del Request
        request.httpMethod = "GET" //tipo de peticion
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
                print("Ocurrio un error al obtener el json")
            }
            
            DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                
                self.refresher?.endRefreshing()
                
            })
            
            do{
                //control de errores desconocidos (TRY) en la serializacion del json
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Any>
                //print(json)
                if json.count > 0{ //numero de post en el json
                    self.dataSourceForPlatino.removeAll()
                    for obj in json{ //Recorrido de todos los post en el json
                        let objeAux = obj as! NSDictionary
                        let restaurante = Restaurant(dictionary: objeAux)
                        
                        if restaurante.categoria.lowercased() == "platino" {
                            self.dataSourceForPlatino.append(restaurante)
                        }
                       // self.dataSource.append(restaurante);
                        
                        
                        
                        //                        if let url = URL(string: "http://104.131.103.103" + restaurante.imagen_principal){
                        //
                        //                            do {
                        //                                let data = try Data(contentsOf: url)
                        //                                let image = UIImage(data: data)
                        //                                self.grid_images.append(image!)
                        //                            }
                        //                        }
                        
                    }
                    
                    
                    DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                        
                        self.gridContainer?.reloadData()
                        
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
    
    //Funciones del protocolo del collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceForPlatino.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Content
        
        
            
            if let url = URL(string: "http://104.236.10.17" + dataSourceForPlatino[indexPath.row].thumbnail) {
                cell.restaurantImg.frame = CGRect(x: cell.frame.width * 0.075, y: cell.frame.height * 0.05, width: cell.frame.width * 0.85, height: cell.frame.height * 0.9)
                cell.restaurantImg.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
                cell.contentView.addSubview(cell.restaurantImg)
            } else {
                cell.restaurantImg.frame = CGRect(x: cell.frame.width * 0.075, y: cell.frame.height * 0.05, width: cell.frame.width * 0.85, height: cell.frame.height * 0.9)
                cell.restaurantImg.backgroundColor = .black
                cell.contentView.addSubview(cell.restaurantImg)
            }
            
        
        //Zona de restaurante
        cell.restaurantZone.text = dataSourceForPlatino[indexPath.row].zona
        cell.restaurantZone.frame = CGRect(x: cell.frame.width * 0.15, y: cell.frame.height * 0.5, width: cell.frame.width * 0.7, height: cell.frame.height * 0.08)
        cell.restaurantZone.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 13)
        cell.restaurantZone.textColor = zoneColor
        cell.contentView.addSubview(cell.restaurantZone)
        
        //Nombre de restaurante
        cell.restaurantName.text = dataSourceForPlatino[indexPath.row].nombre
        cell.restaurantName.frame = CGRect(x: cell.frame.width * 0.15, y: cell.restaurantZone.frame.maxY + 3, width: cell.frame.width * 0.7, height: cell.frame.height * 0.25)
        cell.restaurantName.font = UIFont(name: "Roboto-Bold", size: 14)
        cell.restaurantName.textColor = nameColor
        cell.restaurantName.numberOfLines = 3
        cell.contentView.addSubview(cell.restaurantName)
            
            //Borde de las celdas
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let details = FullDetails()
        details.showRestaurant = dataSourceForPlatino[indexPath.row]
        details.imagen_principal = dataSourceForPlatino[indexPath.row].imagen_principal
        details.tipo_comida = dataSourceForPlatino[indexPath.row].tipo_comida
        details.name_restaurant = dataSourceForPlatino[indexPath.row].nombre
        details.incluye = dataSourceForPlatino[indexPath.row].incluye
        details.img_price = dataSourceForPlatino[indexPath.row].img_price
        details.precio = dataSourceForPlatino[indexPath.row].precio
        details.logo = dataSourceForPlatino[indexPath.row].logo
        details.introduccion = dataSourceForPlatino[indexPath.row].introduccion
        details.p1 = dataSourceForPlatino[indexPath.row].p1
        details.link_video = dataSourceForPlatino[indexPath.row].link_video
        details.p2 = dataSourceForPlatino[indexPath.row].p2
        details.imagen_2 = dataSourceForPlatino[indexPath.row].imagen2
        details.frase = dataSourceForPlatino[indexPath.row].frase
        details.p3 = dataSourceForPlatino[indexPath.row].p3
        details.imagen_3 = dataSourceForPlatino[indexPath.row].imagen3
        details.logo_editorial = dataSourceForPlatino[indexPath.row].logo_editorial
        details.editorial = dataSourceForPlatino[indexPath.row].editorial
        details.id_restaurant = dataSourceForPlatino[indexPath.row].id_restaurante
        details.category = dataSourceForPlatino[indexPath.row].categoria
        details.zona = dataSourceForPlatino[indexPath.row].zona
        details.direccion = dataSourceForPlatino[indexPath.row].direccion
        details.tolerancia = dataSourceForPlatino[indexPath.row].tolerancia
//        details.showRestaurant = dataSourceForPlatino[indexPath.row]
        
        //        present(details, animated: true, completion: nil)
        parentController?.navigationController?.pushViewController(details, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = self.view.frame.width
        let cellWidth = (screenWidth/2.0)
        
        return CGSize(width: cellWidth, height: 258)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    //Funciones del protocolo del collectionView
}


