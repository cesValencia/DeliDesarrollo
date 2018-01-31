//
//  Login.swift
//  Deli
//
//  Created by David Valencia on 23/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate {

    var backgroundImg: UIImageView?
    var logoLogin: UIImageView?
    var infoBox: UIView?
    var titleBox: UILabel?
    var userTF: UITextField?
    var mailTF: UITextField?
    var passwordTF: UITextField?
    var inBtn: UIButton?
    var upBtn: UIButton?
    var fbBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cambiando color de statusbar
        UIApplication.shared.statusBarStyle = .lightContent
        
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load complete interface
    func loadInterface() {
        
        let guia = UIImageView(frame: view.frame)
        guia.image = #imageLiteral(resourceName: "maas")
//        view.addSubview(guia)
        
        backgroundImg = UIImageView(frame: view.frame)
        backgroundImg?.image = #imageLiteral(resourceName: "bgLogin")
        view.addSubview(backgroundImg!)
        
        logoLogin = UIImageView(frame: CGRect(x: wScreen * 0.075, y: hScreen * 0.07, width: wScreen * 0.85, height: hScreen * 0.3))
        logoLogin?.image = #imageLiteral(resourceName: "logoDeliG")
        view.addSubview(logoLogin!)
        
        infoBox = UIView(frame: CGRect(x: 0, y: 0, width: wScreen * 0.92, height: hScreen * 0.62))
        infoBox?.center = view.center
        infoBox?.backgroundColor = UIColor.white.withAlphaComponent(1)
        infoBox?.layer.shadowColor = UIColor.black.cgColor
        infoBox?.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        infoBox?.layer.shadowRadius = 10.0
        infoBox?.layer.shadowOpacity = 0.5
        view.addSubview(infoBox!)
        
        let infoBoxW = infoBox?.frame.width
        let infoBoxH = infoBox?.frame.height
        
        titleBox = UILabel(frame: CGRect(x: infoBoxW! * 0.094, y: infoBoxH! * 0.105, width: infoBoxW! * 0.3, height: infoBoxH! * 0.1))
        titleBox?.text = "Sign In"
        titleBox?.textColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
        titleBox?.font = UIFont(name: "roboto-black", size: 29)
        infoBox?.addSubview(titleBox!)
        
        userTF = UITextField(frame: CGRect(x: infoBoxW! * 0.094, y: titleBox!.frame.maxY + infoBoxH! * 0.048, width: infoBoxW! * 0.812, height: infoBoxH! * 0.105))
        userTF?.attributedPlaceholder = NSAttributedString(string: "Nombre de Usuario", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedStringKey.font: UIFont(name: "roboto-black", size: 11.75)!])
        userTF?.font = UIFont(name: "roboto-black", size: 11.75)
        userTF?.delegate = self
        userTF?.keyboardType = .alphabet
        userTF?.keyboardAppearance = .dark
        userTF?.returnKeyType = .next
        userTF?.borderStyle = .roundedRect
        userTF?.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        userTF?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        userTF?.borderStyle = .roundedRect
        userTF?.clearsOnBeginEditing = true
        userTF?.layer.shadowColor = UIColor.black.cgColor
        userTF?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        userTF?.layer.shadowRadius = 3.0
        userTF?.layer.shadowOpacity = 0.5
        infoBox?.addSubview(userTF!)
        
        mailTF = UITextField(frame: CGRect(x: infoBoxW! * 0.094, y: userTF!.frame.maxY + infoBoxH! * 0.04, width: infoBoxW! * 0.812, height: infoBoxH! * 0.105))
        mailTF?.attributedPlaceholder = NSAttributedString(string: "Correo Electrónico", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedStringKey.font: UIFont(name: "roboto-black", size: 11.75)!])
        mailTF?.font = UIFont(name: "roboto-black", size: 11.75)
        mailTF?.delegate = self
        mailTF?.keyboardType = .emailAddress
        mailTF?.autocapitalizationType = .none
        mailTF?.keyboardAppearance = .dark
        mailTF?.returnKeyType = .next
        mailTF?.borderStyle = .roundedRect
        mailTF?.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        mailTF?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        mailTF?.layer.shadowColor = UIColor.black.cgColor
        mailTF?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        mailTF?.layer.shadowRadius = 3.0
        mailTF?.layer.shadowOpacity = 0.5
        infoBox?.addSubview(mailTF!)
        
        passwordTF = UITextField(frame: CGRect(x: infoBoxW! * 0.094, y: mailTF!.frame.maxY + infoBoxH! * 0.04, width: infoBoxW! * 0.812, height: infoBoxH! * 0.105))
        passwordTF?.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedStringKey.font: UIFont(name: "roboto-black", size: 11.75)!])
        passwordTF?.font = UIFont(name: "roboto-black", size: 11.75)
        passwordTF?.delegate = self
        passwordTF?.keyboardType = .alphabet
        passwordTF?.keyboardAppearance = .dark
        passwordTF?.returnKeyType = .next
        passwordTF?.borderStyle = .roundedRect
        passwordTF?.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        passwordTF?.isSecureTextEntry = true
        passwordTF?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        passwordTF?.layer.shadowColor = UIColor.black.cgColor
        passwordTF?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        passwordTF?.layer.shadowRadius = 3.0
        passwordTF?.layer.shadowOpacity = 0.5
        infoBox?.addSubview(passwordTF!)
        
        inBtn = UIButton(type: UIButtonType.custom)
        inBtn?.frame = CGRect(x: infoBoxW! * 0.075, y: passwordTF!.frame.maxY + infoBoxH! * 0.076, width: infoBoxW! * 0.85, height: infoBoxH! * 0.109)
        inBtn?.setImage(#imageLiteral(resourceName: "inBtnImg"), for: UIControlState.normal)
        inBtn?.addTarget(self, action: #selector(inPressed), for: UIControlEvents.touchUpInside)
        inBtn?.layer.shadowColor = UIColor.black.cgColor
        inBtn?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        inBtn?.layer.shadowRadius = 3.0
        inBtn?.layer.shadowOpacity = 0.5
        inBtn?.alpha = 0
        infoBox?.addSubview(inBtn!)
        
        upBtn = UIButton(type: UIButtonType.custom)
        upBtn?.frame = CGRect(x: infoBoxW! * 0.075, y: passwordTF!.frame.maxY + infoBoxH! * 0.076, width: infoBoxW! * 0.85, height: infoBoxH! * 0.109)
        upBtn?.setImage(#imageLiteral(resourceName: "upBtnImg"), for: UIControlState.normal)
        upBtn?.addTarget(self, action: #selector(upPressed), for: UIControlEvents.touchUpInside)
        upBtn?.layer.shadowColor = UIColor.black.cgColor
        upBtn?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        upBtn?.layer.shadowRadius = 3.0
        upBtn?.layer.shadowOpacity = 0.5
        infoBox?.addSubview(upBtn!)
        
        fbBtn = UIButton(type: UIButtonType.custom)
        fbBtn?.frame = CGRect(x: infoBoxW! * 0.2675, y: inBtn!.frame.maxY + infoBoxH! * 0.066, width: infoBoxW! * 0.465, height: infoBoxH! * 0.028)
        fbBtn?.setImage(#imageLiteral(resourceName: "inFBImg"), for: UIControlState.normal)
        fbBtn?.addTarget(self, action: #selector(fbPressed), for: UIControlEvents.touchUpInside)
        infoBox?.addSubview(fbBtn!)
    }
    
    //Función para los focos de los textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTF {
            mailTF?.becomeFirstResponder() //becomeFirstResponder da el foco al elemento
        } else if textField == mailTF{
            passwordTF?.becomeFirstResponder()
        } else {
            passwordTF?.resignFirstResponder() //resignFirstResponder desiste de ser el foco
        }
        
        return true
    }
    
    // Funciones de los selectores del login
    @objc func inPressed() {
        
    }
    
    @objc func upPressed() {
        
    }
    
    @objc func fbPressed() {
        
    }
}
