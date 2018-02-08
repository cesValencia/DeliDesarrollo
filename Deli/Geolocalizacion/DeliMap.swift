//
//  DeliMap.swift
//  Deli
//
//  Created by David Valencia on 28/12/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SDWebImage

class DeliMap: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, URL_SessionDelegateMaps, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imagen_principal = ""
    var tipo_comida = ""
    var name_restaurant = ""
    var incluye = ""
    var img_price = ""
    var precio = ""
    var logo = ""
    var introduccion = ""
    var p1 = ""
    var link_video = ""
    var p2 = ""
    var imagen_2 = ""
    var frase = ""
    var p3 = ""
    var imagen_3 = ""
    var logo_editorial = ""
    var editorial = ""
    var id_restaurant = ""
    var category = ""
    var zona = ""
    var direccion = ""
    
    var networkManagerForGetRestaurant: URL_SessionM?
    
    var layout: UICollectionViewFlowLayout?
    var categoryArray = [String]()
    var catTagArray = [String]()
    var precioArray = [String]()
    var referenceCarrusel: UICollectionView?
    var idRestaurante: String?
    var location: CLLocation?
    var condicion: Bool? = true
    var mapView: GMSMapView?
    var darkMapStyle: GMSMapStyle?
    var camera: GMSCameraPosition?
    var pin: CustomPin?
    var poliLine: GMSPolyline?
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D? = nil {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cambio de color de status Bar
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Do any additional setup after loading the view, typically from a nib.
        categoryArray = ["Diamante", "Platino", "Plata", "Mixología", "Verde", "Antojo", "Bares", "Postres"]
        catTagArray = ["DA", "PL", "PA", "MX", "VR", "AJ", "BR", "PS"]
        precioArray = ["100", "200", "300", "400", "500", "600", "700", "800"]
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.requestWhenInUseAuthorization()
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen))
        mapView?.settings.myLocationButton = true
        mapView?.isMyLocationEnabled = true
        mapView?.settings.zoomGestures = true
        mapView?.delegate = self
        mapView?.padding = UIEdgeInsets(top: 0, left: 0, bottom: hScreen * 0.25, right: 0)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "darkStyle", withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        view.addSubview(mapView!)
        
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: wScreen * 0.05, y: hScreen * 0.06, width: wScreen * 0.065, height: wScreen * 0.055)
        backBtn.setImage(#imageLiteral(resourceName: "mapExit"), for: .normal)
        backBtn.tintColor = UIColor.black
        backBtn.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        let vista = UIView(frame: CGRect(x: 0, y: hScreen * 0.76, width: wScreen, height: hScreen * 0.24))
        vista.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(vista)

        let adorno = UIView(frame: CGRect(x: wScreen * 0.415, y: vista.frame.height * 0.08, width: wScreen * 0.17, height: hScreen * 0.005))
        adorno.layer.cornerRadius = 5.0
        adorno.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        layout?.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25)
        
        referenceCarrusel = UICollectionView(frame: CGRect(x: 0, y: vista.frame.height * 0.1, width: wScreen, height: vista.frame.height * 0.7), collectionViewLayout: layout!)
        referenceCarrusel?.register(collectionContent.self, forCellWithReuseIdentifier: "cell")
        referenceCarrusel?.delegate = self
        referenceCarrusel?.dataSource = self
        referenceCarrusel?.backgroundColor = UIColor.white.withAlphaComponent(0)
        vista.addSubview(referenceCarrusel!)
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Funciones de protocolo UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! collectionContent
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 5.0
        
        cell.backTag = UIView(frame: CGRect(x: cell.frame.width * 0.1, y: cell.frame.height * 0.13, width: cell.frame.width * 0.15, height: cell.frame.height * 0.12))
        cell.backTag.layer.cornerRadius = 3.0
        switch categoryArray[indexPath.row].lowercased() {
        case "postres":
            cell.backTag.backgroundColor = UIColor(red: 153/255, green: 159/255, blue: 228/255, alpha: 1)
        case "bares":
            cell.backTag.backgroundColor = UIColor(red: 148/255, green: 205/255, blue: 182/255, alpha: 1)
        case "antojo":
            cell.backTag.backgroundColor = UIColor(red: 195/255, green: 193/255, blue: 157/255, alpha: 1)
        case "verde":
            cell.backTag.backgroundColor = UIColor(red: 154/255, green: 198/255, blue: 112/255, alpha: 1)
        case "mixología":
            cell.backTag.backgroundColor = UIColor(red: 251/255, green: 142/255, blue: 134/255, alpha: 1)
        case "plata":
            cell.backTag.backgroundColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
        case "platino":
            cell.backTag.backgroundColor = UIColor(red: 172/255, green: 164/255, blue: 147/255, alpha: 1)
        default:
            cell.backTag.backgroundColor = UIColor(red: 193/255, green: 191/255, blue: 185/255, alpha: 1)
        }
        cell.contentView.addSubview(cell.backTag)
        
        cell.tagCategory = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width * 0.1, height: cell.frame.height * 0.07))
        cell.tagCategory.center = cell.backTag.center
        cell.tagCategory.text = catTagArray[indexPath.row]
        cell.tagCategory.textAlignment = .center
        cell.tagCategory.font = UIFont(name: "Montserrat-Bold", size: 10.5)
        cell.tagCategory.textColor = UIColor.white
        cell.contentView.addSubview(cell.tagCategory)
        
        cell.precio = UILabel(frame: CGRect(x: cell.frame.width * 0.7, y: cell.frame.height * 0.13, width: cell.frame.width * 0.26, height: cell.frame.height * 0.13))
        let numero = NSMutableAttributedString(string: precioArray[indexPath.row], attributes: [NSAttributedStringKey.font : UIFont(name: "Roboto-Black", size: 19) ?? ""])
        let signo = NSMutableAttributedString(string: "$", attributes: [NSAttributedStringKey.font : UIFont(name: "Roboto-Black", size: 10.5) ?? ""])
        let precioText = NSMutableAttributedString()
        precioText.append(numero)
        precioText.append(signo)
        cell.precio.attributedText = precioText
        cell.precio.textAlignment = .right
        switch categoryArray[indexPath.row].lowercased() {
        case "postres":
            cell.precio.textColor = UIColor(red: 153/255, green: 159/255, blue: 228/255, alpha: 1)
        case "bares":
            cell.precio.textColor = UIColor(red: 148/255, green: 205/255, blue: 182/255, alpha: 1)
        case "antojo":
            cell.precio.textColor = UIColor(red: 195/255, green: 193/255, blue: 157/255, alpha: 1)
        case "verde":
            cell.precio.textColor = UIColor(red: 154/255, green: 198/255, blue: 112/255, alpha: 1)
        case "mixología":
            cell.precio.textColor = UIColor(red: 251/255, green: 142/255, blue: 134/255, alpha: 1)
        case "plata":
            cell.precio.textColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
        case "platino":
            cell.precio.textColor = UIColor(red: 172/255, green: 164/255, blue: 147/255, alpha: 1)
        default:
            cell.precio.textColor = UIColor(red: 193/255, green: 191/255, blue: 185/255, alpha: 1)
        }
        cell.contentView.addSubview(cell.precio)
        
        cell.categoria = UILabel(frame: CGRect(x: cell.frame.width * 0.1, y: cell.backTag.frame.maxY + cell.frame.height * 0.1, width: cell.frame.width * 0.9, height: cell.frame.height * 0.14))
        cell.categoria.text = categoryArray[indexPath.row]
        cell.categoria.font = UIFont(name: "Roboto-Bold", size: 19.5)
        cell.categoria.textColor = .black
        cell.contentView.addSubview(cell.categoria)
        
        cell.desc = UILabel(frame: CGRect(x: cell.frame.width * 0.1, y: cell.categoria.frame.maxY + cell.frame.height * 0.02, width: cell.frame.width * 0.4, height: cell.frame.height * 0.3))
        cell.desc.text = "restaurantes & bistrò"
        cell.desc.textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
        cell.desc.font = UIFont(name: "Montserrat-Regular", size: 11)
        cell.desc.numberOfLines = 2
        cell.contentView.addSubview(cell.desc)
        
        cell.backOfNumberRestaurants = UIView(frame: CGRect(x: cell.frame.width * 0.8, y: cell.frame.height * 0.7, width: cell.frame.width * 0.15, height: cell.frame.width * 0.1))
        cell.backOfNumberRestaurants.layer.cornerRadius = 8.0
        cell.backOfNumberRestaurants.backgroundColor = UIColor(red: 97/255, green: 105/255, blue: 254/255, alpha: 1)
        cell.contentView.addSubview(cell.backOfNumberRestaurants)
        
        cell.numberOfRestaurants = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width * 0.075, height: cell.frame.width * 0.5))
        cell.numberOfRestaurants.center = cell.backOfNumberRestaurants.center
        cell.numberOfRestaurants.text = "45"
        cell.numberOfRestaurants.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        cell.numberOfRestaurants.textColor = UIColor.white
        cell.contentView.addSubview(cell.numberOfRestaurants)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = wScreen/2 - wScreen * 0.05
        let cellHeight = referenceCarrusel!.frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Protocolo
    func connectionFinishWithError(session: URL_SessionM, error: Error) {
        print(error.localizedDescription)
    }
    
    func connectionFinishSuccessfull(session: URL_SessionM, response: NSDictionary) {
     
        let mensaje = response["msg"] as? String ?? "Error"
        
        if mensaje == "No hay restaurantes cerca de ti" {
            let alerta = UIAlertController(title: "Lo sentimos!", message: "No hay restaurantes cerca de ti", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
                self.locationManager?.stopUpdatingLocation()
            })
            
            alerta.addAction(action)
            
            present(alerta, animated: true, completion: nil)
        } else {
            
            
            
            let detail = FullDetails()
            
            detail.imagen_principal = response["imagen_principal"] as? String
            detail.tipo_comida = response["tipo_comida"] as? String
            detail.name_restaurant = response["name_restaurant"] as? String
            detail.incluye = response["incluye"] as? String
            detail.img_price = response["img_price"] as? String
            detail.precio = response["precio"] as? String
            detail.logo = response["logo"] as? String
            detail.introduccion = response["introduccion"] as? String
            detail.p1 = response["p1"] as? String
            detail.link_video = response["link_video"] as? String
            detail.p2 = response["p2"] as? String
            detail.imagen_2 = response["imagen_2"] as? String
            detail.frase = response["frase"] as? String
            detail.p3 = response["p3"] as? String
            detail.imagen_3 = response["imagen_3"] as? String
            detail.logo_editorial = response["logo_editorial"] as? String
            detail.editorial = response["editorial"] as? String
            detail.id_restaurant = response["id_restaurant"] as? String
            detail.category = response["category"] as? String
            detail.zona = response["zona"] as? String
            detail.direccion = response["direccion"] as? String
 
            
            navigationController?.pushViewController(detail, animated: true)
        }
        
        
    }
    
    func connectionFinishSuccessfullM(session: URL_SessionM, response: [NSDictionary]) {
        
        if session == networkManagerForGetRestaurant {
            //            self.imagen_principal = json["imagen_principal"] as! String
            //                self.tipo_comida = json["tipo_comida"] as! String
            //                self.name_restaurant = json["name_restaurant"] as! String
            //                self.incluye = json["incluye"] as! String
            //                self.img_price = json["img_price"] as! String
            //                self.precio = json["precio"] as! String
            //                self.logo = json["logo"] as! String
            //                self.introduccion = json["introduccion"] as! String
            //                self.p1 = json["p1"] as! String
            //                self.link_video = json["link_video"] as! String
            //                self.p2 = json["p2"] as! String
            //                self.imagen_2 = json["imagen_2"] as! String
            //                self.frase = json["frase"] as! String
            //                self.p3 = json["p3"] as! String
            //                self.imagen_3 = json["imagen_3"] as! String
            //                self.logo_editorial = json["logo_editorial"] as! String
            //                self.editorial = json["editorial"] as! String
            //                self.id_restaurant = json["id_restaurant"] as! String
            //                self.category = json["category"] as! String
            //                self.zona = json["zona"] as! String
            //                self.direccion = json["direccion"] as! String
//            let details = FullDetails()
            //            details.imagen_principal1 = response["imagen_principal"] as! String
        } else {
            
            for restaurant in response {
                
                let pinTitle = restaurant["name_restaurant"] as? String ?? ""
                let thumbnail = restaurant["thumbnail"] as? String ?? ""
                let id = restaurant["id_restaurant"] as? String ?? ""
                let latitud = restaurant["latitud"] as? String ?? ""
                let longitud = restaurant["longitud"] as? String ?? ""
                pin = CustomPin(latitud: latitud, longitud: longitud, nombreRestaurante: pinTitle, thumb: thumbnail, idRestaurante: id)
                pin?.map = mapView
                
                
            }
            
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let infoWindow = UIView(frame: CGRect(x: 0, y: 0, width: wScreen * 0.8, height: wScreen * 0.17))
        infoWindow.backgroundColor = UIColor.white
        infoWindow.layer.cornerRadius = wScreen * 0.085
        
        let backInfoWindow = UIImageView(frame: CGRect(x: 0, y: 0, width: infoWindow.frame.width, height: infoWindow.frame.height))
        backInfoWindow.image = #imageLiteral(resourceName: "backInfoW")
        infoWindow.addSubview(backInfoWindow)
        
        let infoImage = UIImageView(frame: CGRect(x: infoWindow.frame.width * 0.025, y: infoWindow.frame.height/2 - (wScreen * 0.13/2), width: wScreen * 0.13, height: wScreen * 0.13))
//        infoImage.image = UIImage(named: (marker as! CustomPin).thumb!)
        if let url = URL(string: "http://104.236.10.17" + (marker as! CustomPin).thumb!) {
            //            background.image = UIImage(data: data)
            infoImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "sin-back"), options: .refreshCached)
            
        } else {
            //Imagen por default.... sugiero poner una imagen default por si algo sale mal
            
        }
        infoImage.layer.cornerRadius = infoImage.frame.width/2
        infoImage.layer.masksToBounds = true
        infoWindow.addSubview(infoImage)
        
        let line = UIView(frame: CGRect(x: infoImage.frame.maxX + infoWindow.frame.width * 0.025, y: 0, width: 1, height: hScreen * 0.17))
        line.backgroundColor = UIColor(red: 50/255, green: 51/255, blue: 68/255, alpha: 1)
        infoWindow.addSubview(line)
        
        let label1 = UILabel(frame: CGRect(x: line.frame.maxX + infoWindow.frame.width * 0.1, y: infoWindow.frame.height/2 - (wScreen * 0.13/2), width: infoWindow.frame.width * 0.6, height: wScreen * 0.13))
        label1.text = (marker as! CustomPin).nombreRestaurante
        label1.textColor = UIColor.white
        label1.font = UIFont(name: "Roboto-Regular", size: 12)
        label1.numberOfLines = 2
        infoWindow.addSubview(label1)
        
        let nextImg = UIImageView(frame: CGRect(x: infoWindow.frame.width - (infoWindow.frame.width * 0.08), y: infoWindow.frame.height/2 - (infoWindow.frame.height * 0.2/2), width: infoWindow.frame.width * 0.025, height: infoWindow.frame.height * 0.2))
        nextImg.image = #imageLiteral(resourceName: "nextPurple")
        infoWindow.addSubview(nextImg)
        
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        networkManagerForGetRestaurant = URL_SessionM()
        networkManagerForGetRestaurant?.delegate = self
        networkManagerForGetRestaurant?.getRestaurant(id: (marker as! CustomPin).idRestaurante!)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations[0].coordinate
        
        location = locations.last
        
        
        
        
        if condicion == true {
            camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 14.5)
            self.mapView?.animate(to: camera!)
            condicion = false
        }
        
        let networkManager = URL_SessionM()
        networkManager.delegate = self
        networkManager.ubicacion(para: "5", con: String(describing: (location?.coordinate.latitude)!), con: String(describing: (location?.coordinate.longitude)!))
        
        print(String(describing: (location?.coordinate.latitude)!))
        print(String(describing: (location?.coordinate.longitude)!))
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        poliLine?.map = nil
        let path = GMSMutablePath()
        path.add(marker.position)
        path.add(mapView.myLocation!.coordinate)
        poliLine = GMSPolyline(path: path)
        poliLine?.strokeColor = UIColor(red: 97/255, green: 105/255, blue: 254/255, alpha: 1)
        poliLine?.strokeWidth = 3.0
        poliLine?.map = mapView
        
        return false
    }
    
    //Serializando JSON
    //    func getData(id: String) {
    //        let url = URL(string: "http://104.131.103.103/api/restaurantes/" + id) // se convirete el string url a untipo de dato URL
    //
    //        var request = URLRequest(url: url!) //inicializacion del Request
    //        request.httpMethod = "GET" //tipo de peticion
    //
    //
    //        URLSession.shared.dataTask(with: request) { (data, response, error) in
    //            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
    //                print("Ocurrio un error al obtener el json")
    //            }
    //
    //            do{
    //                //control de errores desconocidos (TRY) en la serializacion del json
    //                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
    //
    //                self.imagen_principal = json["imagen_principal"] as! String
    //                self.tipo_comida = json["tipo_comida"] as! String
    //                self.name_restaurant = json["name_restaurant"] as! String
    //                self.incluye = json["incluye"] as! String
    //                self.img_price = json["img_price"] as! String
    //                self.precio = json["precio"] as! String
    //                self.logo = json["logo"] as! String
    //                self.introduccion = json["introduccion"] as! String
    //                self.p1 = json["p1"] as! String
    //                self.link_video = json["link_video"] as! String
    //                self.p2 = json["p2"] as! String
    //                self.imagen_2 = json["imagen_2"] as! String
    //                self.frase = json["frase"] as! String
    //                self.p3 = json["p3"] as! String
    //                self.imagen_3 = json["imagen_3"] as! String
    //                self.logo_editorial = json["logo_editorial"] as! String
    //                self.editorial = json["editorial"] as! String
    //                self.id_restaurant = json["id_restaurant"] as! String
    //                self.category = json["category"] as! String
    //                self.zona = json["zona"] as! String
    //                self.direccion = json["direccion"] as! String
    //
    //                print(json)
    //            }
    //            catch{
    //                print("Error Serializando del Json")
    //            }
    //            }.resume() //ejecuta el URLSession
    //
    //    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class collectionContent: UICollectionViewCell {
    
    var precio = UILabel()
    var categoria = UILabel()
    var desc = UILabel()
    var backOfNumberRestaurants = UIView()
    var numberOfRestaurants = UILabel()
    var backTag = UIView()
    var tagCategory = UILabel()
}


