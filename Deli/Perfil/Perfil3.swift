//
//  Perfil3.swift
//  Deli
//
//  Created by David Valencia on 24/10/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class Perfil3: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var avatar: UIImageView?
    var pickerController: UIImagePickerController?
    var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (UserDefaults.standard.object(forKey: "savedImage") as! NSData) != nil {
            
            avatar?.image = UIImage(data: userAvatar as Data)
        } else {
            avatar?.image = #imageLiteral(resourceName: "avatar")
        }
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
        backBtn.frame = CGRect(x: 30, y: 40, width: 14, height: 21)
        backBtn.setImage(#imageLiteral(resourceName: "backBtn"), for: .normal)
        backBtn.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        //Texto 1 de la pantalla
        let texto1 = UILabel(frame: CGRect(x: backBtn.frame.maxX, y: backBtn.frame.maxY + 32, width: widthScreen - 80, height: 30))
        texto1.text = "Perfil"
        texto1.textColor = UIColor.white
        texto1.font = UIFont(name: "Montserrat-Bold", size: 32)
        view.addSubview(texto1)
        
        //Texto 2 de la pantalla
        let texto2 = UILabel(frame: CGRect(x: backBtn.frame.maxX, y: texto1.frame.maxY + 7, width: widthScreen - 80, height: 15))
        texto2.text = "De usuario"
        texto2.textColor = UIColor(red: 140/255, green: 145/255, blue: 182/255, alpha: 1)
        texto2.font = UIFont(name: "Montserrat-Light", size: 15)
        view.addSubview(texto2)
        
        //Icono de usuario
        let userIcon = UIImageView(frame: CGRect(x: 35, y: backBtn.frame.maxY + 155, width: 19, height: 18))
        userIcon.image = UIImage(named: "userM")
        view.addSubview(userIcon)
        
        //Nombre de usuario
        let name = UILabel(frame: CGRect(x: userIcon.frame.maxX + 16, y: backBtn.frame.maxY + 155, width: 200, height: 18))
        name.text = "David Valencia"
        name.textColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        name.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(name)
        
        //Línea de separación 1
        let line1 = UIView(frame: CGRect(x: 20, y: name.frame.maxY + 15, width: 235, height: 1))
        line1.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        view.addSubview(line1)
        
        //Avatar de usuario
        avatar = UIImageView(frame: CGRect(x: widthScreen - 120, y: backBtn.frame.maxY + 155, width: 83, height: 83))
        avatar?.image = UIImage(named: "avatar")
        avatar?.isUserInteractionEnabled = true
        avatar?.backgroundColor = UIColor.gray
        avatar?.layer.cornerRadius = avatar!.frame.width/2
        avatar?.layer.masksToBounds = true
        view.addSubview(avatar!)
        
        // Tap gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        tapGesture?.numberOfTapsRequired = 1
        avatar?.addGestureRecognizer(tapGesture!)
        
        //Icono de sobre
        let mailIcon = UIImageView(frame: CGRect(x: 35, y: line1.frame.maxY + 45, width: 24, height: 18))
        mailIcon.image = UIImage(named: "sobreM")
        view.addSubview(mailIcon)
        
        //Email de usuario
        let mail = UILabel(frame: CGRect(x: userIcon.frame.maxX + 16, y: line1.frame.maxY + 45, width: 200, height: 18))
        mail.text = "david@gmail.com"
        mail.textColor = UIColor.white
        mail.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(mail)
        
        //Línea de separación 2
        let line2 = UIView(frame: CGRect(x: 20, y: mail.frame.maxY + 15, width: widthScreen - 40, height: 1))
        line2.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        view.addSubview(line2)
        
        //Icono de candado
        let candadoIcon = UIImageView(frame: CGRect(x: 35, y: line2.frame.maxY + 45, width: 18, height: 18))
        candadoIcon.image = UIImage(named: "candadoM")
        view.addSubview(candadoIcon)
        
        //Password de usuario
        let pass = UILabel(frame: CGRect(x: userIcon.frame.maxX + 16, y: line2.frame.maxY + 45, width: 200, height: 18))
        pass.text = "******"
        pass.textColor = UIColor.white
        pass.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(pass)
        
        //Botón de editar
        let editB = UIButton(type: .custom)
        editB.frame = CGRect(x: widthScreen - 104, y: line2.frame.maxY + 45, width: 50, height: 15)
        editB.setTitle("Editar", for: .normal)
        editB.titleLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        editB.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        view.addSubview(editB)
        
        //Línea de separación 3
        let line3 = UIView(frame: CGRect(x: 20, y: pass.frame.maxY + 15, width: widthScreen - 40, height: 1))
        line3.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        view.addSubview(line3)
        
        //Icono de cumpleaños
        let birthIcon = UIImageView(frame: CGRect(x: 35, y: line3.frame.maxY + 45, width: 18, height: 18))
        birthIcon.image = UIImage(named: "regaloM")
        view.addSubview(birthIcon)
        
        //Fecha de nacimiento de usuario
        let birthday = UILabel(frame: CGRect(x: userIcon.frame.maxX + 16, y: line3.frame.maxY + 45, width: 200, height: 18))
        birthday.text = "Junio 8 1980"
        birthday.textColor = UIColor.white
        birthday.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(birthday)
        
        //Botón de editar
        let editB2 = UIButton(type: .custom)
        editB2.frame = CGRect(x: widthScreen - 104, y: line3.frame.maxY + 45, width: 50, height: 15)
        editB2.setTitle("Editar", for: .normal)
        editB2.titleLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        editB2.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        view.addSubview(editB2)
        
        //Línea de separación 2
        let line4 = UIView(frame: CGRect(x: 20, y: birthday.frame.maxY + 15, width: widthScreen - 40, height: 1))
        line4.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        view.addSubview(line4)
        
        //Activación de notificaciones
        let notifications = UILabel(frame: CGRect(x: 35, y: line4.frame.maxY + 45, width: 200, height: 15))
        notifications.text = "Notificaciones"
        notifications.textColor = UIColor.white
        notifications.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(notifications)
        
        //Switch de activación 1
        let switch1 = UISwitch(frame: CGRect(x: widthScreen - 100, y: line4.frame.maxY + 35, width: 50, height: 15))
        switch1.isOn = true
        switch1.onTintColor = UIColor(red: 179/255, green: 203/255, blue: 126/255, alpha: 1)
        view.addSubview(switch1)
        
        //Línea de separación 5
        let line5 = UIView(frame: CGRect(x: 20, y: notifications.frame.maxY + 15, width: widthScreen - 40, height: 1))
        line5.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        view.addSubview(line5)
        
        //Activación de ubicación
        let ubicacion = UILabel(frame: CGRect(x: 35, y: line5.frame.maxY + 45, width: 200, height: 15))
        ubicacion.text = "Activar ubicación"
        ubicacion.textColor = UIColor.white
        ubicacion.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        view.addSubview(ubicacion)
        
        //Switch de activación 2
        let switch2 = UISwitch(frame: CGRect(x: widthScreen - 100, y: line5.frame.maxY + 35, width: 50, height: 15))
        switch2.isOn = true
        switch2.onTintColor = UIColor(red: 179/255, green: 203/255, blue: 126/255, alpha: 1)
        view.addSubview(switch2)
        
    }
    
    // Función para seleccionar nueva imagen del dispositivo
    @objc func tapDetected() {
        
        let actionSheet = UIAlertController(title: "Deli", message: "¿Qué desea hacer?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let choosePictureAction = UIAlertAction(title: "Seleccionar una foto", style: UIAlertActionStyle.default) { (_) in
            print("Seleccionar foto")
            
            self.pickerController = UIImagePickerController()
            self.pickerController?.delegate = self
            self.pickerController?.sourceType = .photoLibrary
            
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.destructive, handler: nil)
        
        actionSheet.addAction(choosePictureAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: ImagePickerController Protocol
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgData: NSData = UIImagePNGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage)!)! as NSData
        UserDefaults.standard.set(imgData, forKey: "savedImage")
        
        // Decode
        userAvatar = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        avatar?.image = UIImage(data: userAvatar as Data)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func backPressed() {
        
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hearthPressed() {
        
    }
    
    @objc func sharePressed() {
        
    }
    
}

