//
//  CercaVC.swift
//  PantallasFake
//
//  Created by David Valencia on 07/10/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit

class CercaVC: UIViewController {
    
    var dataSource = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cercaInterface()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func cercaInterface() {
        
        let widthScreen = view.frame.width
        let heightScreen = view.frame.height
        
        print(widthScreen)
        print(heightScreen)
        
        //Background
        let cercaBG = UIImageView(frame: view.frame)
        cercaBG.image = UIImage(named: "cercaBG")
        view.addSubview(cercaBG)
        
        //backBtn
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(#imageLiteral(resourceName: "cercaBack"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        backBtn.frame = CGRect(x: 25, y: 50, width: widthScreen * 0.04, height: widthScreen * 0.06)
        view.addSubview(backBtn)
        
        //shareBtn
        let shareBtn = UIButton(type: .custom)
        shareBtn.setImage(#imageLiteral(resourceName: "cercaShare"), for: .normal)
        shareBtn.frame = CGRect(x: widthScreen - 160, y: backBtn.frame.maxY, width: widthScreen * 0.135, height: widthScreen * 0.135)
        shareBtn.addTarget(self, action: #selector(shareBtnPressed), for: .touchUpInside)
        view.addSubview(shareBtn)
        
        //shareBtn
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(#imageLiteral(resourceName: "cercaSearch"), for: .normal)
        searchBtn.frame = CGRect(x: shareBtn.frame.maxX + 25, y: backBtn.frame.maxY, width: widthScreen * 0.135, height: widthScreen * 0.135)
        searchBtn.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        view.addSubview(searchBtn)
        
        //cercaMarker
        let cercaMarker = UIImageView(frame: CGRect(x: (widthScreen/2) - (widthScreen * 0.507)/2, y: (heightScreen/2) - (155/2), width: widthScreen * 0.507, height: widthScreen * 0.507))
        cercaMarker.image = UIImage(named: "cercaMarker")
        UIView.animate(withDuration: 0.5, animations: {
            self.view.addSubview(cercaMarker)
        }) { (true) in
            
        }
        
        
        //textoCerca
        let textoCerca = UITextView(frame: CGRect(x: (widthScreen/2) - (widthScreen * 0.74)/2, y: (heightScreen) - ((widthScreen * 0.314) + 5 + 50), width: widthScreen * 0.74, height: widthScreen * 0.314))
        textoCerca.text = "Permite el acceso a tu ubicación para poder encontrar experiencias cercanas."
        textoCerca.textAlignment = .center
        textoCerca.isScrollEnabled = false
        textoCerca.isEditable = false
        textoCerca.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        textoCerca.textColor = UIColor(red: 144/255, green: 143/255, blue: 159/255, alpha: 1)
        textoCerca.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        view.addSubview(textoCerca)
        
        let switchCerca = UISwitch(frame: CGRect(x: (widthScreen/2) - 20, y: textoCerca.frame.maxY + 5, width: 0, height: 0))
        switchCerca.isOn = false
        switchCerca.onTintColor = UIColor(red: 179/255, green: 203/255, blue: 126/255, alpha: 1)
        switchCerca.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        view.addSubview(switchCerca)
        
    }
    
    //backBtnPressed
    @objc func backBtnPressed() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareBtnPressed() {
        
        print("Share")
        
        let activityController = UIActivityViewController(activityItems: ["Compartiendo Cerca de mí"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @objc func searchBtnPressed() {
        
        //Atajo provisional
        
    }
    
    @objc func switchValueDidChange(_ sender:UISwitch!) {
        
        if(sender.isOn) {
            
            
            let alert = UIAlertController(title: "'Deli' quisiera utilizar su ubicación actual", message: "Para visualizar las experiencias cercanas a ti ", preferredStyle: .alert)
            
            let clearAction = UIAlertAction(title: "Cancelar", style: .destructive) { (alert: UIAlertAction!) -> Void in
                
                sender.isOn = false
            }
            let allowAction = UIAlertAction(title: "Permitir", style: .default) { (alert: UIAlertAction!) -> Void in
                
                let goMaps = Maps()
                goMaps.dameRestaurantes = self.dataSource
                self.present(goMaps, animated: true, completion: nil)
            }
            
            alert.addAction(clearAction)
            alert.addAction(allowAction)
            
            present(alert, animated: true, completion:nil)
        }else  {
            
            print("Apagado")
        }
    }
    
    //Serializando JSON
    func getData() {
        let url = URL(string: "http://104.236.10.17/api/restaurantes/") // se convirete el string url a untipo de dato URL
        
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
                        self.dataSource.append(restaurante);
                        
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
}

