//
//  Perfil.swift
//  Deli
//
//  Created by David Valencia on 24/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class Perfil: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInterface() {
        
        //Color de fondo de toda la pantalla
        view.backgroundColor = UIColor.white
        
        //Alto y ancho de pantalla
        let screenWidth = view.frame.width
        
        //Botón de regreso
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 30, y: 40, width: 10, height: 18)
        backBtn.setImage(#imageLiteral(resourceName: "backBtnBrown"), for: .normal)
        backBtn.addTarget(self, action: #selector(btnBrownPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        //Título de pantalla
        let title = UILabel(frame: CGRect(x: backBtn.frame.maxX, y: backBtn.frame.maxY + 150, width: 150, height: 30))
        title.text = "CONTRASEÑA"
        title.textAlignment = .left
        title.font = UIFont(name: "AlNile-Bold", size: 16)
        title.textColor = UIColor(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        view.addSubview(title)
        
        //Subtitulo de la pantalla
        let subtitle = UITextView(frame: CGRect(x: backBtn.frame.maxX, y: title.frame.maxY + 5, width: 230, height: 110))
        subtitle.text = "No te Preocupes!"
        subtitle.textColor = UIColor(red: 93/255, green: 93/255, blue: 93/255, alpha: 1)
        subtitle.font = UIFont(name: "Avenir-Light", size: 40)
        subtitle.textAlignment = .left
        view.addSubview(subtitle)
        
        //Texto que indica el paso a seguir
        let indicacion = UITextView(frame: CGRect(x: backBtn.frame.maxX, y: subtitle.frame.maxY + 20, width: 300, height: 50))
        indicacion.text = "Por favor revisa tu mail para recuperar tu contraseña."
        indicacion.textAlignment = .left
        indicacion.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        indicacion.font = UIFont(name: "Avenir-Light", size: 15)
        view.addSubview(indicacion)
        
        //Imagen de sobre
        let sobre = UIImageView(frame: CGRect(x: backBtn.frame.maxX + 5, y: indicacion.frame.maxY + 50, width: 118, height: 74.25))
        sobre.image = UIImage(named: "sobre")
        view.addSubview(sobre)
        
        //Botón de check
        let checkBtn = UIButton(type: .custom)
        checkBtn.frame = CGRect(x: screenWidth - 100, y: sobre.frame.maxY + 80, width: 65, height: 65)
        checkBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        checkBtn.addTarget(self, action: #selector(checkBtnpressed), for: .touchUpInside)
        view.addSubview(checkBtn)
    }
    
    //Selectores
    @objc func btnBrownPressed() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkBtnpressed() {
        
        present(Perfil2(), animated: true, completion: nil)
    }
    
}

