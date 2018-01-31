//
//  Busqueda.swift
//  PantallasFake
//
//  Created by David Valencia on 06/10/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit

class Busqueda: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = .default
        //Cargando interfaz de Búsqueda
        cargarInterfaz()
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
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func cargarInterfaz() {
        
        let widthScreen = view.frame.width
        
        //Botón de regreso
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 30, y: 40, width: 13, height: 21)
        backBtn.setImage(#imageLiteral(resourceName: "closeBuscar"), for: .normal)
        backBtn.tintColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
        backBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        //Texto 1 de la pantalla
        let texto1 = UILabel(frame: CGRect(x: backBtn.frame.maxX, y: backBtn.frame.maxY + 32, width: widthScreen - 80, height: 30))
        texto1.text = "Buscar"
        texto1.textColor = UIColor.black
        texto1.font = UIFont(name: "Montserrat-Bold", size: 32)
        view.addSubview(texto1)
        
        //fondo gris textfield
        let fondo = UIView(frame: CGRect(x: widthScreen/2 - 164, y: texto1.frame.maxY + 10, width: 328, height: 40))
        fondo.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        fondo.layer.cornerRadius = 8.0
        view.addSubview(fondo)
        
        //Lupa
        let lupa = UIImageView(frame: CGRect(x: 12, y: 12.5, width: 15, height: 15))
        lupa.image = UIImage(named: "lupaTextBox")
        fondo.addSubview(lupa)
        
        let campoSearch = UITextField(frame: CGRect(x: lupa.frame.maxX + 12, y: 0, width: 310, height: 40))
        campoSearch.placeholder = "Por nombre o tipo de comida"
        campoSearch.textAlignment = .left
        campoSearch.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        campoSearch.textColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
        campoSearch.keyboardType = UIKeyboardType.default
        campoSearch.returnKeyType = UIReturnKeyType.done
        campoSearch.clearButtonMode = UITextFieldViewMode.whileEditing;
        campoSearch.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        campoSearch.keyboardAppearance = .dark
        fondo.addSubview(campoSearch)
        
        
        /*let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        statusBar.backgroundColor = UIColor.white.withAlphaComponent(1)
        statusBar.tintColorDidChange()
        view.addSubview(statusBar)*/
    }
    
    @objc func closeBtnPressed() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.popViewController(animated: true)
    }
    
}

