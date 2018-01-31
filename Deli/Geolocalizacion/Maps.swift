//
//  Maps.swift
//  Deli
//
//  Created by David Valencia on 03/12/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit
import CoreLocation //Para latitud y longitud
import MapKit //Para mapas

class Maps: UIViewController, URL_SessionDelegate2, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager?
    var mapView: MKMapView?
    var dameRestaurantes = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        loadLocation()
        loadMap()
        
    }
    
    // Protocolo
    func connectionFinishWithError(session: URL_Session2, error: Error) {
        print(error.localizedDescription)
    }
    
    func connectionFinishSuccessfull(session: URL_Session2, response: [NSDictionary]) {
        print(response)
        
        print()
        
        for restaurant in response {
            
            let latitud = restaurant["latitud"] as? String ?? ""
            let longitud = restaurant["longitud"] as? String ?? ""
            let coordinate = CLLocationCoordinate2D(latitude: Double(latitud)!, longitude: Double(longitud)!)
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = restaurant["name_restaurant"] as? String ?? ""
            
            
            
            mapView?.addAnnotation(pin)
        }
        
    }
    
    func loadMap() {
        mapView = MKMapView(frame: view.frame)
        mapView?.showsUserLocation = true //Para encontrarnos nosotros
        mapView?.mapType = .standard // cambia el tipo de mapa que se va a visualizar(hybridFlyOver para 3d algunas ciudades nadamas)
        //Inicializamos el delegeado del mapa
        mapView?.delegate = self
        view.addSubview(mapView!)
        
        let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(19.384587,-99.1438529), 500, 500)
        mapView?.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            return nil
        }
        
        let customAnnotation = MKAnnotationView()
        customAnnotation.image = #imageLiteral(resourceName: "restPin")
        customAnnotation.canShowCallout = true //Cuando se agrega un pin se llama esta función
        
        let boton = UIButton(type: .detailDisclosure)
        customAnnotation.rightCalloutAccessoryView = boton
        return customAnnotation
    }
    
    func loadLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.requestWhenInUseAuthorization() //Ejecuta el permiso de acceso al dispositivo
        //Línea que inicia a obtener tus coordenadas
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    //Calcula coordenadas
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations[0]
        let coordinate = currentLocation.coordinate
        
        print("Latitud: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
        
        let networkManager = URL_Session2()
        networkManager.delegate = self
        networkManager.ubicacion(para: "10", con: String(coordinate.latitude), con: String(coordinate.longitude))
        
        //        let networkManager = URL_Session()
        //        networkManager.delegate = self
        //        networkManager.ubicacion(para: "10", con: "19.346652", con: "-99.181054")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("HOla")
        
        let restPost = FullDetails()
        restPost.showRestaurant = dameRestaurantes[1]
        present(restPost, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
