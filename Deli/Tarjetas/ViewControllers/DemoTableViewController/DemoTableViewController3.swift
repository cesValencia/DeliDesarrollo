//
//  DemoTableViewController3.swift
//  Deli
//
//  Created by David Valencia on 01/09/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import UIKit

class DemoTableViewController3: ExpandingTableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    //Arreglos que muestran contenido del carrusel de experiencias
    var imgA = [UIImage]()
    var precioA = [String]()
    var descA = [String]()
    var realA = [String]()
    var botonArray = [String]()
    
    //Caruusel Ex 2 arreglo
    var tiposC = [String]()
    
    //Nombre de los collectionViews
    @IBOutlet weak var collectionEx5: UICollectionView!
    @IBOutlet weak var collectionEx6: UICollectionView!
    
    
    var identifiers = ["201", "202", "203", "204", "205", "206", "207", "208", "209", "210"]
    
    //fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Contenido de los arreglos de carrusel de experiencias
        imgA = [UIImage(named: "T1")!, UIImage(named: "T2")!, UIImage(named: "T3")!, UIImage(named: "T4")!, UIImage(named: "T5")!]
        precioA = ["Mzo - May", "Jul - Ago", "Sep - Oct", "Nov - Dic", "Ene - Feb"]
        descA = ["Influencia inglesa en nuestra cocina", "Orígenes del sabor mexicano actual", "Tendencias de mixología en el 2018", "Influencia francesa en nuestra cocina", "Los mejores chefs mexicanos del año"]
        realA = ["Valor de premio ganador 2,030$", "Valor de premio ganador 1,100$", "Valor de premio ganador 850$", "Valor de premio ganador 2,030$", "Valor de premio ganador 1,100$"]
        botonArray = ["FullTrivias", "FullTrivias", "FullTrivias", "FullTrivias", "FullTrivias"]
        
        //Contenido arreglo ex2
        tiposC = ["Internacional", "Mexicana", "Europea",  "Oriental"]
        
        self.collectionEx5.dataSource = self
        self.collectionEx5.delegate = self
        self.collectionEx6.dataSource = self
        self.collectionEx6.delegate = self
        
        let mivista = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 335))
        mivista.backgroundColor = UIColor.red
        //view.addSubview(mivista)
        
        configureNavBar()
        let image1 = Asset.backgroundImage.image
        tableView.backgroundView = UIImageView(image: image1)
    }
    
    /*DashboardView*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionEx5 {
            
            return imgA.count
        }else {
            
            return tiposC.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionEx5{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewEx5", for: indexPath) as! CollectionViewEx5
            cell.imgEx.image = imgA[indexPath.row]
            cell.precio.text = precioA[indexPath.row]
            cell.desc.text = descA[indexPath.row]
            cell.precioReal.text = realA[indexPath.row]
            
            return cell
        }else{
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewEx6", for: indexPath) as! CollectionViewEx6
            
            cell2.paises.text = tiposC[indexPath.row]
            cell2.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
            cell2.layer.cornerRadius = 3.0
            
            return cell2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*let id = botonArray[indexPath.row];
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)//instanciamos nuestro story
        
        let siguienteViewController = storyBoard.instantiateViewController(withIdentifier: id)*/
        
        //self.present(FullTrivias(), animated: true, completion: nil)//mostrar nuestro viewcontroller
        navigationController?.pushViewController(FullTrivias(), animated: true)
        
        
        //let viewController = storyboard?.instantiateViewController(withIdentifier: id);
        //self.navigationController?.pushViewController(viewController!, animated: true)
        
        
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     
     navigationController?.isNavigationBarHidden = true
     }
     
     override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     
     navigationController?.isNavigationBarHidden = false
     }*/
    
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
    
}



// MARK: - Lifecycle
extension DemoTableViewController3 {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let titleView = navigationItem.titleView else { return }
        let center = UIScreen.main.bounds.midX
        let diff = center - titleView.frame.midX
        titleImageViewXConstraint.constant = diff
    }
    
}

// MARK: Helpers
extension DemoTableViewController3 {
    
    fileprivate func configureNavBar() {
        
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
}

// MARK: Actions
extension DemoTableViewController3 {
    
    @IBAction func backButtonHandler(_ sender: AnyObject) {
        // buttonAnimation
        let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        
        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate
extension DemoTableViewController3 {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //    if scrollView.contentOffset.y < -25 {
        //      // buttonAnimation
        //      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        //
        //      for viewController in viewControllers {
        //        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        //          rightButton.animationSelected(false)
        //        }
        //      }
        //      popTransitionAnimation()
        //    }
        
        //scrollOffsetY = scrollView.contentOffset.y
    }
}

extension DemoTableViewController3: UICollectionViewDelegateFlowLayout {
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
     let screenWidth = self.view.frame.width
     let cellWidth = (screenWidth/2.0)
     
     return CGSize(width: cellWidth, height: 262)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     
     return 0.0
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     
     return 0.0
     }*/
}
