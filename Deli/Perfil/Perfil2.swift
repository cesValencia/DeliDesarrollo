//
//  Perfil2.swift
//  Deli
//
//  Created by David Valencia on 24/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class Perfil2: UIViewController {
    
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
        
        //Medidas de ancho y alto de pantalla
        let widthScreen = view.frame.width
        
        //Color de fondo de la pantalla
        view.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 45/255, alpha: 1)
        
        //Botón de regreso
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 30, y: 40, width: 10, height: 18)
        backBtn.setImage(#imageLiteral(resourceName: "backBtn"), for: .normal)
        backBtn.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        //Titulo de pantalla
        let title = UILabel(frame: CGRect(x: 35, y: backBtn.frame.maxY + 140, width: widthScreen - 70, height: 120))
        title.text = "Cambiar mi contraseña"
        title.numberOfLines = 2
        title.textColor = UIColor.white
        title.font = UIFont(name: "Arial", size: 35)
        view.addSubview(title)
        
        //Texto2
        let texto2 = UILabel(frame: CGRect(x: 35, y: title.frame.maxY + 20, width: 155, height: 20))
        texto2.text = "Olvidaste tu contraseña?"
        texto2.textColor = UIColor(red: 145/255, green: 148/255, blue: 153/255, alpha: 1)
        texto2.font = UIFont(name: "Arial", size: 14)
        view.addSubview(texto2)
        
        //Botón para cambiar contraseña
        let changePass = UIButton(type: .custom)
        changePass.frame = CGRect(x: texto2.frame.maxX, y: title.frame.maxY + 20, width: 90, height: 20)
        changePass.setTitle("Da click aquí", for: .normal)
        changePass.titleLabel?.font = UIFont(name: "Arial", size: 14)
        changePass.titleLabel?.textAlignment = .left
        changePass.setTitleColor(UIColor(red: 152/255, green: 145/255, blue: 116/255, alpha: 1), for: .normal)
        changePass.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
        view.addSubview(changePass)
        
        //Campo de contraseña actual
        let imgCandado = UIImageView(frame: CGRect(x: 35, y: texto2.frame.maxY + 60, width: 15, height: 15))
        imgCandado.image = UIImage(named: "candadoM")
        view.addSubview(imgCandado)
        
        let campo1 = UITextField(frame: CGRect(x: imgCandado.frame.maxX + 5, y: texto2.frame.maxY + 60, width: 250, height: 15))
        campo1.attributedPlaceholder = NSAttributedString(string: "Contraseña actual", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        campo1.textAlignment = .left
        campo1.font = UIFont(name: "Arial", size: 14)
        campo1.textColor = UIColor.white
        campo1.keyboardType = UIKeyboardType.numberPad
        campo1.returnKeyType = UIReturnKeyType.done
        campo1.clearButtonMode = UITextFieldViewMode.whileEditing
        campo1.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        view.addSubview(campo1)
        
        let line1 = UIView(frame: CGRect(x: 20, y: campo1.frame.maxY + 20, width: widthScreen - 40, height: 1))
        line1.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        view.addSubview(line1)
        
        //Campo de nueva contraseña
        let imgUser = UIImageView(frame: CGRect(x: 35, y: line1.frame.maxY + 20, width: 15, height: 15))
        imgUser.image = UIImage(named: "userM")
        view.addSubview(imgUser)
        
        let campo2 = UITextField(frame: CGRect(x: imgCandado.frame.maxX + 5, y: line1.frame.maxY + 20, width: 250, height: 15))
        campo2.attributedPlaceholder = NSAttributedString(string: "Contraseña actual", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        campo2.textAlignment = .left
        campo2.font = UIFont(name: "Arial", size: 14)
        campo2.textColor = UIColor.white
        campo2.keyboardType = UIKeyboardType.numberPad
        campo2.returnKeyType = UIReturnKeyType.done
        campo2.clearButtonMode = UITextFieldViewMode.whileEditing
        campo2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        view.addSubview(campo2)
        
        let line2 = UIView(frame: CGRect(x: 20, y: campo2.frame.maxY + 20, width: widthScreen - 40, height: 1))
        line2.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        view.addSubview(line2)
        
        //Campo de confirmación de contraseña
        let imgUser2 = UIImageView(frame: CGRect(x: 35, y: line2.frame.maxY + 20, width: 15, height: 15))
        imgUser2.image = UIImage(named: "userM")
        view.addSubview(imgUser2)
        
        let campo3 = UITextField(frame: CGRect(x: imgCandado.frame.maxX + 5, y: line2.frame.maxY + 20, width: 250, height: 15))
        campo3.attributedPlaceholder = NSAttributedString(string: "Contraseña actual", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        campo3.textAlignment = .left
        campo3.font = UIFont(name: "Arial", size: 14)
        campo3.textColor = UIColor.white
        campo3.keyboardType = UIKeyboardType.numberPad
        campo3.returnKeyType = UIReturnKeyType.done
        campo3.clearButtonMode = UITextFieldViewMode.whileEditing
        campo3.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        view.addSubview(campo3)
        
        let line3 = UIView(frame: CGRect(x: 20, y: campo3.frame.maxY + 20, width: widthScreen - 40, height: 1))
        line3.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        view.addSubview(line3)
        
        //Botón de siguiente
        let nextBtn = UIButton(type: .custom)
        nextBtn.frame = CGRect(x: widthScreen - 120, y: line3.frame.maxY + 50, width: 80, height: 80)
        nextBtn.setImage(#imageLiteral(resourceName: "nextM"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        view.addSubview(nextBtn)
    }
    
    @objc func backPressed() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changePressed() {
        
    }
    
    @objc func nextPressed() {
        
        present(Perfil3(), animated: true, completion: nil)
    }
}

