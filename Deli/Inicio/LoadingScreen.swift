//
//  LoadingScreen.swift
//  Deli
//
//  Created by David Valencia on 31/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit

class LoadingScreen: UIViewController {
    
    var launchScreen: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Definiendo el color de la statusbar
        UIApplication.shared.statusBarStyle = .lightContent

        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "token") as? String) != nil {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let cards = storyBoard.instantiateViewController(withIdentifier: "MainCards")
            self.present(cards, animated: true, completion: nil)
        } else {
            
            print("Error de inicio")
        }
    }
    
    func loadInterface() {
        
        launchScreen = UIImageView(image: #imageLiteral(resourceName: "launchDeliFake"))
        launchScreen?.frame = view.frame
        view.addSubview(launchScreen!)


    }

}
