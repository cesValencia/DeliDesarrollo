//
//  PageViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 05/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

/// UIViewController with UICollectionView with custom transition method
open class ExpandingViewController: UIViewController {
  
  /// The default size to use for cells.
  open var itemSize = CGSize(width: 256, height: 335)
  
  ///  The collection view object managed by this view controller.
  open var collectionView: UICollectionView?
  
  fileprivate var transitionDriver: TransitionDriver?
  
  /// Index of current cell
  open var currentIndex: Int {
    guard let collectionView = self.collectionView else { return 0 }
    
    let startOffset = (collectionView.bounds.size.width - itemSize.width) / 2
    guard let collectionLayout  = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
      return 0
    }
    
    let minimumLineSpacing = collectionLayout.minimumLineSpacing
    let a = collectionView.contentOffset.x + startOffset + itemSize.width / 2
    let b = itemSize.width + minimumLineSpacing
    return Int(a / b)
  }
}

// MARK: life cicle

extension ExpandingViewController {
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
    

 }
}



// MARK: Transition

public extension ExpandingViewController {
  
  /**
   Pushes a view controller onto the receiver’s stack and updates the display with custom animation.
   
   - parameter viewController: The table view controller to push onto the stack. 
   */
  func pushToViewController(_ viewController: ExpandingTableViewController) {
    guard let collectionView = self.collectionView,
    let navigationController = self.navigationController else {
      return
    }
    
    viewController.transitionDriver = transitionDriver
    let insets = viewController.automaticallyAdjustsScrollViewInsets
    let tabBarHeight =  insets == true ? navigationController.navigationBar.frame.size.height : 0
    let stausBarHeight = insets == true ? UIApplication.shared.statusBarFrame.size.height : 0
    let backImage = getBackImage(viewController, headerHeight: viewController.headerHeight)
    
    transitionDriver?.pushTransitionAnimationIndex(currentIndex,
                                                   collecitionView: collectionView,
                                                   backImage: backImage,
                                                   headerHeight: viewController.headerHeight,
                                                   insets: tabBarHeight + stausBarHeight) { headerView in
                                                   // for subview in headerView.subviews {
                                                     //   subview.removeFromSuperview()
                                                    //}
                                                    
                                                    if tarjetaActiva == 0 {
                                                        
                                                        let containerTMP = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 236))
                                                        containerTMP.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
                                                        headerView.addSubview(containerTMP)
                                                        
                                                        let exprefImg = UIImageView(frame: CGRect(x: wScreen * 0.05, y: hScreen * 0.05, width: wScreen * 0.3, height: hScreen * 0.02))
                                                        exprefImg.image = #imageLiteral(resourceName: "expref")
                                                        containerTMP.addSubview(exprefImg)
                                                        
                                                        let closeCards = UIButton(type: .custom)
                                                        closeCards.setImage(#imageLiteral(resourceName: "CloseCards"), for: .normal)
                                                        closeCards.frame = CGRect(x: self.view.frame.width - 50, y: 40, width: 45, height: 45)
                                                        closeCards.addTarget(self, action: #selector(self.closeCardsPressed), for: .touchUpInside)
//                                                        containerTMP.addSubview(closeCards)
                                                        
                                                        let texto = UILabel(frame: CGRect(x: wScreen * 0.05, y: containerTMP.frame.height * 0.4, width: 300, height: 43))
                                                        texto.text = "Tu eliges"
                                                        texto.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
                                                        texto.textColor = UIColor.white
                                                        texto.font = UIFont(name: "roboto-black", size: 37)
                                                        containerTMP.addSubview(texto)
                                                        
                                                        let imgTags = UIImageView(frame: CGRect(x: wScreen * 0.05, y: texto.frame.maxY + hScreen * 0.017, width: wScreen * 0.9, height: hScreen * 0.038))
                                                        imgTags.image = #imageLiteral(resourceName: "hashtags")
                                                        containerTMP.addSubview(imgTags)
                                                        
                                                        let dots = UIImageView(frame: CGRect(x: wScreen * 0.9, y: imgTags.frame.maxY + hScreen * 0.045, width: wScreen * 0.06, height: wScreen * 0.016))
                                                        dots.image = #imageLiteral(resourceName: "dotsDesdoble")
                                                        containerTMP.addSubview(dots)
                                                        
                                                    }else if tarjetaActiva == 1 {
                                                        
                                                        let containerTMP = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 236))
                                                        containerTMP.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
                                                        headerView.addSubview(containerTMP)
                                                        
                                                        let closeCards = UIButton(type: .custom)
                                                        closeCards.setImage(#imageLiteral(resourceName: "closeCard"), for: .normal)
                                                        closeCards.frame = CGRect(x: self.view.frame.width - 50, y: 40, width: 45, height: 45)
                                                        //containerTMP.addSubview(closeCards)
                                                        
                                                        let texto = UILabel(frame: CGRect(x: 36, y: closeCards.frame.maxY + 5, width: 300, height: 43))
                                                        texto.text = "Ruta Menú"
                                                        texto.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
                                                        texto.textColor = UIColor.white
                                                        texto.font = UIFont(name: "Montserrat-Bold", size: 36)
                                                        containerTMP.addSubview(texto)
                                                        
                                                        let subTexto = UILabel(frame: CGRect(x: 36, y: texto.frame.maxY + 4, width: 300, height: 20))
                                                        subTexto.text = "Disfruta y comparte"
                                                        subTexto.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/(255), alpha: 0)
                                                        subTexto.textColor = UIColor(red: 152/255, green: 151/255, blue: 143/255, alpha: 1)
                                                        subTexto.font = UIFont(name: "Montserrat-Light", size: 15)
                                                        containerTMP.addSubview(subTexto)
                                                    }else if tarjetaActiva == 2 {
                                                        
                                                        let containerTMP = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 236))
                                                        containerTMP.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
                                                        headerView.addSubview(containerTMP)
                                                        
                                                        let closeCards = UIButton(type: .custom)
                                                        closeCards.setImage(#imageLiteral(resourceName: "closeCard"), for: .normal)
                                                        closeCards.frame = CGRect(x: self.view.frame.width - 50, y: 40, width: 45, height: 45)
                                                        //containerTMP.addSubview(closeCards)
                                                        
                                                        let texto = UILabel(frame: CGRect(x: 36, y: closeCards.frame.maxY + 5, width: 300, height: 43))
                                                        texto.text = "Trivias"
                                                        texto.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
                                                        texto.textColor = UIColor.white
                                                        texto.font = UIFont(name: "Montserrat-Bold", size: 36)
                                                        containerTMP.addSubview(texto)
                                                        
                                                        let subTexto = UILabel(frame: CGRect(x: 36, y: texto.frame.maxY + 4, width: 300, height: 20))
                                                        subTexto.text = "Disfruta y comparte"
                                                        subTexto.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/(255), alpha: 0)
                                                        subTexto.textColor = UIColor(red: 152/255, green: 151/255, blue: 143/255, alpha: 1)
                                                        subTexto.font = UIFont(name: "Montserrat-Light", size: 15)
                                                        containerTMP.addSubview(subTexto)
                                                    }

                                                    print("tarjeta activa = \(tarjetaActiva)")
                                                    
      viewController.tableView.tableHeaderView = headerView
      self.navigationController?.pushViewController(viewController, animated: false)
    }
  }
    
    @objc func closeCardsPressed() {
        
        
    }
}

// MARK: create

extension ExpandingViewController {
  
  fileprivate func commonInit() {
    
    let layout = PageCollectionLayout(itemSize: itemSize)
    collectionView = PageCollectionView.createOnView(view,
                                                     layout: layout,
                                                     height: itemSize.height + itemSize.height / 5 * 2,
                                                     dataSource: self,
                                                     delegate: self)
    if #available(iOS 10.0, *) {
      collectionView?.isPrefetchingEnabled = false
    } 
    transitionDriver = TransitionDriver(view: view)
  }
}

// MARK: Helpers

extension ExpandingViewController {
  
  fileprivate func getBackImage(_ viewController: UIViewController, headerHeight: CGFloat) -> UIImage? {
    let imageSize = CGSize(width: viewController.view.bounds.width, height: viewController.view.bounds.height - headerHeight)
    let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
    return viewController.view.takeSnapshot(imageFrame)
  }

}

// MARK: UICollectionViewDataSource

extension ExpandingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard case let cell as BasePageCollectionCell = cell else {
      return
    }
    
    cell.configureCellViewConstraintsWithSize(itemSize)
  }
  open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    fatalError("need emplementation in subclass")
  }
  
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    fatalError("need emplementation in subclass")
  }
}

// MARK: UIScrollViewDelegate 

extension ExpandingViewController {
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let indexPath = IndexPath(row: currentIndex, section: 0)
    if case let currentCell as BasePageCollectionCell = collectionView?.cellForItem(at: indexPath) {
      currentCell.configurationCell()
    }
  }
}

