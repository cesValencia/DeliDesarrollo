//
//  TipoComida.swift
//  IntroDeli
//
//  Created by David Valencia on 01/12/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import UIKit

class TipoComida: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, URL_SessionDelegate {

    var pickFood: UIPickerView?
    var nacionalidades = [String]()
    var closeBtn: UIButton?
    var titulo: UILabel?
    var subtitle: UILabel?
    var subtitle2: UILabel?
    var nextBtn: UIButton?
    var lastLegend: UILabel?
    var token: String?
    var selectedFood: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let tok = UserDefaults.standard.object(forKey: "token") {
            token = tok as? String
        }
    }
    
    func loadInterface() {
        
        //Se inicializa el arreglo de Strings con los nombres de las nacionalidades de las comidas
        nacionalidades = ["internacional", "japonesa", "italiana", "mexicana", "francesa", "española", "cantonesa", "suiza", "griega", "argentina", "libanesa"]
        
        view.backgroundColor = bgTipoComida
        
        closeBtn = UIButton(type: .custom)
        closeBtn?.frame = CGRect(x: wScreen * 0.85, y: hScreen * 0.1, width: wScreen * 0.05, height: wScreen * 0.05)
        closeBtn?.setImage(#imageLiteral(resourceName: "closepick"), for: UIControlState.normal)
        closeBtn?.addTarget(self, action: #selector(closePressed), for: UIControlEvents.touchUpInside)
        view.addSubview(closeBtn!)
        
        titulo = UILabel(frame: CGRect(x: wScreen * 0.35, y: closeBtn!.frame.maxY + hScreen * 0.05, width: wScreen * 0.3, height: hScreen * 0.02))
        titulo?.text = "SELECCIONA"
        titulo?.textColor = UIColor.lightGray
        titulo?.textAlignment = .center
        titulo?.font = UIFont(name: "Didot-Bold", size: 13)
        view.addSubview(titulo!)
        
        subtitle = UILabel(frame: CGRect(x: wScreen * 0.1, y: titulo!.frame.maxY + hScreen * 0.02, width: wScreen * 0.8, height: hScreen * 0.05))
        subtitle?.text = "Tu tipo de comida"
        subtitle?.textAlignment = .center
        subtitle?.textColor = UIColor.white
        subtitle?.font = UIFont(name: "Montserrat-Bold", size: 27)
        view.addSubview(subtitle!)
        
        subtitle2 = UILabel(frame: CGRect(x: wScreen * 0.1, y: subtitle!.frame.maxY, width: wScreen * 0.8, height: hScreen * 0.05))
        subtitle2?.text = "favorita?"
        subtitle2?.textAlignment = .center
        subtitle2?.textColor = UIColor.white
        subtitle2?.font = UIFont(name: "Montserrat-Bold", size: 27)
        view.addSubview(subtitle2!)
        
        pickFood = UIPickerView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.4))
        pickFood?.center = view.center
        pickFood?.dataSource = self
        pickFood?.delegate = self
        pickFood?.tintColor = UIColor.white
        view.addSubview(pickFood!)
        
        nextBtn = UIButton(type: UIButtonType.custom)
        nextBtn?.frame = CGRect(x: wScreen * 0.2, y: pickFood!.frame.maxY + hScreen * 0.07, width: wScreen * 0.6, height: hScreen * 0.08)
        nextBtn?.setImage(#imageLiteral(resourceName: "filtroBtn"), for: UIControlState.normal)
        nextBtn?.addTarget(self, action: #selector(nextPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(nextBtn!)
        
        lastLegend = UILabel(frame: CGRect(x: wScreen * 0.2, y: nextBtn!.frame.maxY + hScreen * 0.05, width: wScreen * 0.6, height: hScreen * 0.05))
        lastLegend?.text = "Opción para mejorar tu experiencia en la visualización de contenido."
        lastLegend?.textAlignment = .center
        lastLegend?.textColor = UIColor.lightGray
        lastLegend?.font = UIFont(name: "SourceSansPro-Regular", size: 14)
        lastLegend?.numberOfLines = 2
        view.addSubview(lastLegend!)
    }
    
    @objc func closePressed() {
        
    }
    
    @objc func nextPressed() {
        
        // Almacenando tipo de comida en la BD
        let networkTypeFood = URL_Session()
        networkTypeFood.delegate = self
        networkTypeFood.sendTypeFood(token: token!, tipo: selectedFood!)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cards = storyBoard.instantiateViewController(withIdentifier: "MainCards")
        self.present(cards, animated: true, completion: nil)
    }
    
    //MARK: Protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return nacionalidades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return nacionalidades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 47
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let pickerLabel = nacionalidades[row]
        
        let myPickerLabel = NSAttributedString(string: pickerLabel, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        return myPickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedFood = nacionalidades[row]
        print(selectedFood!)
    }
    
    func connectionFinishSuccessfull(session: URL_Session, response: NSDictionary) {
        print(response)
        
        
        
    }
    
    func connectionFinishWithError(session: URL_Session, error: Error) {
        print(error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
