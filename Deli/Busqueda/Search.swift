//
//  Search.swift
//  SearchController
//
//  Created by David Valencia on 02/02/18.
//  Copyright © 2018 David Valencia. All rights reserved.
//

import UIKit

class Search: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var tableView: UITableView!
    var dataSource = [Restaurant]()
    var filteredNames = [Restaurant]()
    var searchBar = UISearchBar()
    var titulo: UILabel?
    var closeSearchImg: UIImageView?
    var closeSearchB: UIButton?
    var backTableView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        closeSearchImg = UIImageView(frame: CGRect(x: wScreen * 0.91, y: hScreen * 0.04, width: wScreen * 0.04, height: wScreen * 0.04))
        closeSearchImg?.image = #imageLiteral(resourceName: "closeSearch")
        view.addSubview(closeSearchImg!)
        
        closeSearchB = UIButton(type: .system)
        closeSearchB?.frame = CGRect(x: wScreen * 0.9, y: hScreen * 0.025, width: wScreen * 0.1, height: wScreen * 0.1)
        closeSearchB?.addTarget(self, action: #selector(closeSearchP), for: .touchUpInside)
        view.addSubview(closeSearchB!)

        titulo = UILabel(frame: CGRect(x: wScreen * 0.05, y: closeSearchImg!.frame.maxY + wScreen * 0.02, width: wScreen * 0.6, height: hScreen * 0.05))
        titulo?.text = "Buscar"
        titulo?.textColor = UIColor.black
        titulo?.font = UIFont(name: "Roboto-Black", size: 35)
        view.addSubview(titulo!)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: hScreen * 0.12, width: wScreen, height: hScreen * 0.08))
        searchBar.barTintColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        searchBar.backgroundImage = UIImage()
        searchBar.keyboardAppearance = .dark
        let attributePlaceHolder = searchBar.value(forKey: "searchField") as? UITextField
        attributePlaceHolder?.attributedPlaceholder = NSAttributedString(string: "Buscar por nombre", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 14) ?? ""])
        attributePlaceHolder?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        backTableView = UIView(frame: CGRect(x: 0, y: hScreen * 0.2, width: wScreen, height: hScreen * 0.8))
        backTableView?.backgroundColor = UIColor.white
        view.addSubview(backTableView!)
        
        tableView = UITableView(frame: CGRect(x: 0, y: hScreen * 0.2, width: wScreen, height: hScreen * 0.8))
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        
        getData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeSearchP() {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return hScreen * 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBar.text != "" {
            view.addSubview(tableView)
            return filteredNames.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchBar.text == "" {
            let cell = SearchCell(restaurant: "", zonaRest: "")
            
            return cell

        } else {

            let cell = SearchCell(restaurant: filteredNames[indexPath.row].nickname, zonaRest: dataSource[indexPath.row].zona)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filteredNames[indexPath.row].nickname + "" + dataSource[indexPath.row].zona)
        let details = FullDetails()
        details.imagen_principal = filteredNames[indexPath.row].imagen_principal
        details.tipo_comida = filteredNames[indexPath.row].tipo_comida
        details.name_restaurant = filteredNames[indexPath.row].nombre
        details.incluye = filteredNames[indexPath.row].incluye
        details.img_price = filteredNames[indexPath.row].img_price
        details.precio = filteredNames[indexPath.row].precio
        details.logo = filteredNames[indexPath.row].logo
        details.introduccion = filteredNames[indexPath.row].introduccion
        details.p1 = filteredNames[indexPath.row].p1
        details.link_video = filteredNames[indexPath.row].link_video
        details.p2 = filteredNames[indexPath.row].p2
        details.imagen_2 = filteredNames[indexPath.row].imagen2
        details.frase = filteredNames[indexPath.row].frase
        details.p3 = filteredNames[indexPath.row].p3
        details.imagen_3 = filteredNames[indexPath.row].imagen3
        details.logo_editorial = filteredNames[indexPath.row].logo_editorial
        details.editorial = filteredNames[indexPath.row].editorial
        details.id_restaurant = filteredNames[indexPath.row].id_restaurante
        details.category = filteredNames[indexPath.row].categoria
        details.zona = filteredNames[indexPath.row].zona
        details.direccion = filteredNames[indexPath.row].direccion
        details.tolerancia = filteredNames[indexPath.row].tolerancia
        
        navigationController?.pushViewController(details, animated: true)
        
    }
    
    // MARK: - UISearchBar Protocol
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            tableView.removeFromSuperview()
            titulo?.text = "Buscar"
        } else {
            view.addSubview(tableView)
            titulo?.text = "Resultados"
        }
        
        filteredNames = searchText.isEmpty ? dataSource : dataSource.filter { (item: Restaurant) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.nombre.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    // Petición a webservice
    func getData() {
        let url = URL(string: "http://104.236.10.17/api/restaurantes/") // se convirete el string url a untipo de dato URL
        
        var request = URLRequest(url: url!) //inicializacion del Request
        request.httpMethod = "GET" //tipo de peticion
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil){ //verifica que no exista algun error a la hora de hacer la peticion
                print("Ocurrio un error al obtener el json")
            }
            
            DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                
//                                self.refresher?.endRefreshing()
                
            })
            
            do{
                //control de errores desconocidos (TRY) en la serializacion del json
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Any>
                //print(json)
                if json.count > 0{ //numero de post en el json
                    self.dataSource.removeAll()
                    for obj in json{ //Recorrido de todos los post en el json
                        let objeAux = obj as! NSDictionary
                        let rest = Restaurant(dictionary: objeAux)
                        
                        self.dataSource.append(rest)

                    }
                    
                    DispatchQueue.main.async(execute: { () -> Void in //se accede al hilo de la interface
                        
                        self.tableView.reloadData()
                        
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
