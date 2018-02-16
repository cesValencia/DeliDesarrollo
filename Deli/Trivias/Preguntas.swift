//
//  Preguntas.swift
//  Deli
//
//  Created by David Valencia on 08/02/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit

class Preguntas: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var headerView: UIView?
    var contador: UILabel?
    var timeLabel: UILabel?
    var numeroDeReactivo: UILabel?
    var reactivoLabel: UILabel?
    var cantidadDePremios: UILabel?
    var premiosLabel: UILabel?
    var scrollView: UIScrollView?
    var firstView: UIView?
    var iniciarBtn: UIButton?
    var iniciarBtnFalso: UIButton?
    var secondView: UIView?
    var collectionQuestion: UICollectionView?
    var collectionAnswer: UICollectionView?
    var layout1: UICollectionViewFlowLayout?
    var layout2: UICollectionViewFlowLayout?
    var nombreTrivia: String?
    var questionArrayT1111 = [String]()
    var r1ArrayT1111 = [String]()
    var r2ArrayT1111 = [String]()
    var r3ArrayT1111 = [String]()
    var questionArrayT2222 = [String]()
    var r1ArrayT2222 = [String]()
    var r2ArrayT2222 = [String]()
    var r3ArrayT2222 = [String]()
    var questionArrayT3333 = [String]()
    var r1ArrayT3333 = [String]()
    var r2ArrayT3333 = [String]()
    var r3ArrayT3333 = [String]()
    var questionArrayT4444 = [String]()
    var r1ArrayT4444 = [String]()
    var r2ArrayT4444 = [String]()
    var r3ArrayT4444 = [String]()
    var questionArrayT5555 = [String]()
    var r1ArrayT5555 = [String]()
    var r2ArrayT5555 = [String]()
    var r3ArrayT5555 = [String]()
    var answerArray4 = [String]()
    var answerArray5 = [String]()
    var answer1Btn: UIButton?
    var answer2Btn: UIButton?
    var answer3Btn: UIButton?
    var answer4Btn: UIButton?
    var answer5Btn: UIButton?
    var btnAnswerArray = [UIButton]()
    var reactivoActual = 010
    var triviaArray = [String]()
    var triv = [String]()
    
    var indexSelected3: Int = 0
    /*Cronómetro*/
    var time = 30
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(self.questionArrayT1111)
        print(self.r1ArrayT1111)
        print(self.r2ArrayT1111)
        print(self.r3ArrayT1111)
        print(self.questionArrayT2222)
        print(self.r1ArrayT2222)
        print(self.r2ArrayT2222)
        print(self.r3ArrayT2222)
        print(self.questionArrayT3333)
        print(self.r1ArrayT3333)
        print(self.r2ArrayT3333)
        print(self.r3ArrayT3333)
        print(self.questionArrayT4444)
        print(self.r1ArrayT4444)
        print(self.r2ArrayT4444)
        print(self.r3ArrayT4444)
        print(self.questionArrayT5555)
        print(self.r1ArrayT5555)
        print(self.r2ArrayT5555)
        print(self.r3ArrayT5555)
        
        // Color de statusBar
        UIApplication.shared.statusBarStyle = .default

        // Cargando la interfaz
        loadInterface()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInterface() {
        
        // Arreglo de preguntas

        answerArray4 = ["Todos", "Todos", "Todos", "Todos", "Todos", "Todos", "Todos", "Todos", "Todos", "Todos"]
        
        answerArray5 = ["Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno", "Ninguno"]
        
//        btnAnswerArray = [answer1Btn!, answer2Btn!, answer3Btn!, answer4Btn!, answer5Btn!]
        
        // Color de fondo de la pantalla
        view.backgroundColor = UIColor.white
        
        // headerView
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: hScreen * 0.15))
        headerView?.backgroundColor = UIColor.white
        headerView?.layer.borderWidth = 0.5
        headerView?.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1).cgColor
        view.addSubview(headerView!)
        
        // Contador y timeLabel
        let counter = NSMutableAttributedString(string: "030", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Medium", size: 18)!])
        let secondsLetter = NSMutableAttributedString(string: " s.", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Medium", size: 16)!])
        let counterText = NSMutableAttributedString()
        counterText.append(counter)
        counterText.append(secondsLetter)
        contador = UILabel(frame: CGRect(x: 0, y: hScreen * 0.07, width: wScreen/3, height: wScreen * 0.05))
        contador?.attributedText = counterText
        contador?.textColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        contador?.textAlignment = .center
        headerView?.addSubview(contador!)
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: contador!.frame.maxY, width: wScreen/3, height: wScreen * 0.05))
        timeLabel?.text = "tiempo"
        timeLabel?.font = UIFont(name: "Helvetica Neue", size: 10.5)
        timeLabel?.textColor = UIColor(red: 106/255, green: 106/255, blue: 119/255, alpha: 1)
        timeLabel?.textAlignment = .center
        headerView?.addSubview(timeLabel!)
        
        let lineBreak1 = UIView(frame: CGRect(x: contador!.frame.maxX, y: headerView!.frame.height * 0.3, width: 0.5, height: headerView!.frame.height * 0.7))
        lineBreak1.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        headerView?.addSubview(lineBreak1)
        
        // numeroDeReactivo y reactivoLabel
        numeroDeReactivo = UILabel(frame: CGRect(x: lineBreak1.frame.maxX, y: hScreen * 0.07, width: wScreen/3, height: wScreen * 0.05))
        numeroDeReactivo?.text = "0" + String(reactivoActual)
        numeroDeReactivo?.textColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        numeroDeReactivo?.textAlignment = .center
        headerView?.addSubview(numeroDeReactivo!)
        
        reactivoLabel = UILabel(frame: CGRect(x: lineBreak1.frame.maxX, y: numeroDeReactivo!.frame.maxY, width: wScreen/3, height: wScreen * 0.05))
        reactivoLabel?.text = "reactivos"
        reactivoLabel?.font = UIFont(name: "Helvetica Neue", size: 10.5)
        reactivoLabel?.textColor = UIColor(red: 106/255, green: 106/255, blue: 119/255, alpha: 1)
        reactivoLabel?.textAlignment = .center
        headerView?.addSubview(reactivoLabel!)
        
        let lineBreak2 = UIView(frame: CGRect(x: numeroDeReactivo!.frame.maxX, y: headerView!.frame.height * 0.3, width: 0.5, height: headerView!.frame.height * 0.7))
        lineBreak2.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        headerView?.addSubview(lineBreak2)
        
        // cantidadDePremios y premiosLabel
        cantidadDePremios = UILabel(frame: CGRect(x: lineBreak2.frame.maxX, y: hScreen * 0.07, width: wScreen/3, height: wScreen * 0.05))
        cantidadDePremios?.text = "003"
        cantidadDePremios?.textColor = UIColor(red: 227/255, green: 121/255, blue: 105/255, alpha: 1)
        cantidadDePremios?.textAlignment = .center
        headerView?.addSubview(cantidadDePremios!)
        
        premiosLabel = UILabel(frame: CGRect(x: lineBreak2.frame.maxX, y: cantidadDePremios!.frame.maxY, width: wScreen/3, height: wScreen * 0.05))
        premiosLabel?.text = "premios"
        premiosLabel?.font = UIFont(name: "Helvetica Neue", size: 10.5)
        premiosLabel?.textColor = UIColor(red: 106/255, green: 106/255, blue: 119/255, alpha: 1)
        premiosLabel?.textAlignment = .center
        headerView?.addSubview(premiosLabel!)
        
        // ScrollView de la pantalla de iniciar trivia y preguntas y respuestas
        scrollView = UIScrollView(frame: CGRect(x: 0, y: headerView!.frame.maxY, width: wScreen, height: hScreen * 0.85))
        scrollView?.isPagingEnabled = true
        scrollView?.isScrollEnabled = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.bounces = true
        scrollView?.delegate = self
        scrollView?.backgroundColor = .yellow
        if #available(iOS 11.0, *) {
            scrollView?.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(scrollView!)
        
        // firstView y secondView
        firstView = UIView(frame: CGRect(x: 0, y: 0, width: wScreen, height: scrollView!.frame.height))
        firstView?.backgroundColor = UIColor.white
        scrollView?.addSubview(firstView!)
        
        let viewTitle = UILabel(frame: CGRect(x: wScreen * 0.075, y: firstView!.frame.height * 0.12, width: wScreen * 0.3, height: wScreen * 0.05))
        viewTitle.text = "TRIVIAS DELI"
        viewTitle.font = UIFont(name: "PlayfairDisplay-Bold", size: 11.5)
        viewTitle.textColor = UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        viewTitle.sizeToFit()
        firstView?.addSubview(viewTitle)
        
        let titleTrivia = UITextView(frame: CGRect(x: wScreen * 0.06, y: viewTitle.frame.maxY + 5, width: wScreen * 0.8, height: hScreen * 0.2))
        titleTrivia.text = nombreTrivia
        titleTrivia.font = UIFont(name: "Roboto-Black", size: 31.5)
        titleTrivia.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        titleTrivia.isScrollEnabled = false
        titleTrivia.sizeToFit()
        firstView?.addSubview(titleTrivia)
        
        let indicacion = UITextView(frame: CGRect(x: wScreen * 0.06, y: titleTrivia.frame.maxY + 5, width: wScreen * 0.8, height: hScreen * 0.2))
        indicacion.text = "El ganador será aquel que conteste de forma correcta en menor número de tiempo…"
        indicacion.font = UIFont(name: "PlayfairDisplay-Regular", size: 15)
        indicacion.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        indicacion.isScrollEnabled = false
        indicacion.sizeToFit()
        firstView?.addSubview(indicacion)
        
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: wScreen * 0.06, y: indicacion.frame.maxY + hScreen * 0.08, width: wScreen * 0.88, height: wScreen * 0.143)
        backBtn.setImage(#imageLiteral(resourceName: "backBtnTrivias"), for: .normal)
        backBtn.addTarget(self, action: #selector(backFromTrivias), for: .touchUpInside)
        firstView?.addSubview(backBtn)
        
        iniciarBtn = UIButton(type: .custom)
        iniciarBtn?.frame = CGRect(x: wScreen * 0.06, y: backBtn.frame.maxY + hScreen * 0.029, width: wScreen * 0.88, height: wScreen * 0.143)
        iniciarBtn?.setImage(#imageLiteral(resourceName: "empezarBtnTrivia"), for: .normal)
        iniciarBtn?.addTarget(self, action: #selector(empezarTrivia), for: .touchUpInside)
        firstView?.addSubview(iniciarBtn!)
        
        iniciarBtnFalso = UIButton(type: .custom)
        iniciarBtnFalso?.frame = CGRect(x: wScreen * 0.06, y: backBtn.frame.maxY + hScreen * 0.029, width: wScreen * 0.88, height: wScreen * 0.143)
        iniciarBtnFalso?.setImage(#imageLiteral(resourceName: "empezarBtnTrivia"), for: .normal)
        iniciarBtnFalso?.addTarget(self, action: #selector(iniciarBtnFalsoPress), for: .touchUpInside)
        iniciarBtnFalso?.alpha = 0
        firstView?.addSubview(iniciarBtn!)
        
        let logoPresentador = UIImageView(frame: CGRect(x: wScreen * 0.07, y: iniciarBtn!.frame.maxY + hScreen * 0.135, width: wScreen * 0.3, height: wScreen * 0.035))
        logoPresentador.image = #imageLiteral(resourceName: "presentadorLogo")
        firstView?.addSubview(logoPresentador)
        
        let blackLogo = UIImageView(frame: CGRect(x: wScreen * 0.68, y: iniciarBtn!.frame.maxY + hScreen * 0.07, width: wScreen * 0.25, height: wScreen * 0.15))
        blackLogo.image = #imageLiteral(resourceName: "logoBlack")
        firstView?.addSubview(blackLogo)
        
        secondView = UIView(frame: CGRect(x: firstView!.frame.maxX, y: 0, width: wScreen, height: scrollView!.frame.height))
        secondView?.backgroundColor = UIColor.white
        scrollView?.addSubview(secondView!)
        
        let viewTitle2 = UILabel(frame: CGRect(x: wScreen * 0.075, y: secondView!.frame.height * 0.11, width: wScreen * 0.3, height: wScreen * 0.05))
        viewTitle2.text = "TRIVIAS DELI"
        viewTitle2.font = UIFont(name: "PlayfairDisplay-Bold", size: 11.5)
        viewTitle2.textColor = UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        viewTitle2.sizeToFit()
        secondView?.addSubview(viewTitle2)
        
        layout1 = UICollectionViewFlowLayout()
        layout1?.itemSize = CGSize(width: wScreen * 0.8, height: hScreen * 0.13)
        layout1?.sectionInset = UIEdgeInsets.zero
        layout1?.minimumLineSpacing = 0
        layout1?.scrollDirection = .horizontal
        
        collectionQuestion = UICollectionView(frame: CGRect(x: wScreen * 0.06, y: viewTitle2.frame.maxY + 5, width: wScreen * 0.8, height: hScreen * 0.125), collectionViewLayout: layout1!)
        collectionQuestion?.delegate = self
        collectionQuestion?.dataSource = self
        collectionQuestion?.register(QuestionCell.self, forCellWithReuseIdentifier: "questionCell")
        collectionQuestion?.isScrollEnabled = false
        collectionQuestion?.isPagingEnabled = true
        collectionQuestion?.showsVerticalScrollIndicator = false
        collectionQuestion?.showsHorizontalScrollIndicator = false
        collectionQuestion?.backgroundColor = UIColor.white
        collectionQuestion?.bounces = false
        secondView?.addSubview(collectionQuestion!)
        
        let adorno = UIView(frame: CGRect(x: wScreen * 0.06, y: collectionQuestion!.frame.maxY, width: wScreen * 0.13, height: 3.5))
        adorno.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 237/255, alpha: 1)
        secondView?.addSubview(adorno)
        
        layout2 = UICollectionViewFlowLayout()
        layout2?.itemSize = CGSize(width: wScreen, height: secondView!.frame.height * 0.7)
        layout2?.sectionInset = UIEdgeInsets.zero
        layout2?.minimumLineSpacing = 0
        layout2?.scrollDirection = .horizontal
        
        collectionAnswer = UICollectionView(frame: CGRect(x: 0, y: adorno.frame.maxY, width: wScreen, height: secondView!.frame.height * 0.7), collectionViewLayout: layout2!)
        collectionAnswer?.delegate = self
        collectionAnswer?.dataSource = self
        collectionAnswer?.register(AnswerCell.self, forCellWithReuseIdentifier: "answerCell")
        collectionAnswer?.isScrollEnabled = false
        collectionAnswer?.isPagingEnabled = true
        collectionAnswer?.showsVerticalScrollIndicator = false
        collectionAnswer?.showsHorizontalScrollIndicator = false
        collectionAnswer?.backgroundColor = UIColor.white
        collectionAnswer?.bounces = false
        secondView?.addSubview(collectionAnswer!)
        
        scrollView?.contentSize = CGSize(width: secondView!.frame.maxX, height: 0)
    }

    // Funciones de los selectores
    @objc func backFromTrivias() {
        navigationController?.popViewController(animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @objc func empezarTrivia() {
        
        UIView.animate(withDuration: 0.5) {
            self.scrollView?.contentOffset.x = UIScreen.main.bounds.width * 1
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        
        iniciarBtn?.alpha = 0
        iniciarBtnFalso?.alpha = 1
    }
    
    @objc func iniciarBtnFalsoPress() {
        let alert = UIAlertController(title: "Lo sentimos! Ya has participado en esta trivia", message: "Participa en las otras trivias que tenemos para ti", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    @objc func action () {
        time -= 1
        if(time == 0) {
            timer.invalidate()
            let alert = UIAlertController(title: "Lo sentimos! Tu tiempo se ha agotado", message: "Participa en las otras trivias que tenemos para ti", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion:nil)

        } else if self.collectionAnswer!.contentOffset.x > UIScreen.main.bounds.width * 9 {
            // Cachar tiempo(falta)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        contador?.text = String(time)
    }
    
    // MARK: - Funciones de protocolo de collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionQuestion {
            
            return questionArrayT1111.count
        } else {
            
            return r1ArrayT1111.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionQuestion {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCell
            
            cell.setQuestionCell()
            
            switch indexSelected3 {
                case 0: cell.question.text = questionArrayT1111[indexPath.row]
                case 1: cell.question.text = questionArrayT2222[indexPath.row]
                case 2: cell.question.text = questionArrayT3333[indexPath.row]
                case 3: cell.question.text = questionArrayT4444[indexPath.row]
                
            default: cell.question.text = questionArrayT5555[indexPath.row]
            }
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! AnswerCell
            
            cell.setAnswerCell()
            
            switch indexSelected3 {
            case 0:
                cell.answer1.text = r1ArrayT1111[indexPath.row]
                cell.answer2.text = r2ArrayT1111[indexPath.row]
                cell.answer3.text = r3ArrayT1111[indexPath.row]
                cell.answer4.text = answerArray4[indexPath.row]
                cell.answer5.text = answerArray5[indexPath.row]
            case 1:
                cell.answer1.text = r1ArrayT2222[indexPath.row]
                cell.answer2.text = r2ArrayT2222[indexPath.row]
                cell.answer3.text = r3ArrayT2222[indexPath.row]
                cell.answer4.text = answerArray4[indexPath.row]
                cell.answer5.text = answerArray5[indexPath.row]
            case 2:
                cell.answer1.text = r1ArrayT3333[indexPath.row]
                cell.answer2.text = r2ArrayT3333[indexPath.row]
                cell.answer3.text = r3ArrayT3333[indexPath.row]
                cell.answer4.text = answerArray4[indexPath.row]
                cell.answer5.text = answerArray5[indexPath.row]
            case 3:
                cell.answer1.text = r1ArrayT4444[indexPath.row]
                cell.answer2.text = r2ArrayT4444[indexPath.row]
                cell.answer3.text = r3ArrayT4444[indexPath.row]
                cell.answer4.text = answerArray4[indexPath.row]
                cell.answer5.text = answerArray5[indexPath.row]
                
            default:
                cell.answer1.text = r1ArrayT5555[indexPath.row]
                cell.answer2.text = r2ArrayT5555[indexPath.row]
                cell.answer3.text = r3ArrayT5555[indexPath.row]
                cell.answer4.text = answerArray4[indexPath.row]
                cell.answer5.text = answerArray5[indexPath.row]
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionAnswer!.contentOffset.x {
        case UIScreen.main.bounds.width * 0:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 1
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 1
                self.numeroDeReactivo?.text = String(9)
            })
        case UIScreen.main.bounds.width * 1:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 2
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 2
                self.numeroDeReactivo?.text = String(8)
            })
        case UIScreen.main.bounds.width * 2:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 3
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 3
                self.numeroDeReactivo?.text = String(7)
            })
        case UIScreen.main.bounds.width * 3:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 4
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 4
                self.numeroDeReactivo?.text = String(6)
            })
        case UIScreen.main.bounds.width * 4:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 5
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 5
                self.numeroDeReactivo?.text = String(5)
            })
        case UIScreen.main.bounds.width * 5:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 6
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 6
                self.numeroDeReactivo?.text = String(4)
            })
        case UIScreen.main.bounds.width * 6:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 7
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 7
                self.numeroDeReactivo?.text = String(3)
            })
        case UIScreen.main.bounds.width * 7:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 8
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 8
                self.numeroDeReactivo?.text = String(2)
            })
        case UIScreen.main.bounds.width * 8:
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionAnswer?.contentOffset.x = UIScreen.main.bounds.width * 9
                self.collectionQuestion?.contentOffset.x = self.collectionQuestion!.frame.width * 9
                self.numeroDeReactivo?.text = String(1)
            })
        default:
            navigationController?.popViewController(animated: true)
        }
    }
    
}

class QuestionCell: UICollectionViewCell {
    
    var question = UITextView()
    
    func setQuestionCell() {
        
        question = UITextView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        question.font = UIFont(name: "Roboto-Medium", size: 18)
        question.textColor = UIColor.black
        question.isScrollEnabled = false
        addSubview(question)
    }
}

class AnswerCell: UICollectionViewCell {
    
    var answer1 = UILabel()
    var answer2 = UILabel()
    var answer3 = UILabel()
    var answer4 = UILabel()
    var answer5 = UILabel()
    var btnAnswer1 = UIButton()
    var btnAnswer2 = UIButton()
    var btnAnswer3 = UIButton()
    var btnAnswer4 = UIButton()
    var btnAnswer5 = UIButton()
    
    func setAnswerCell() {
        
        answer1 = UILabel(frame: CGRect(x: wScreen * 0.06, y: hScreen * 0.03, width: wScreen * 0.88, height: wScreen * 0.143))
        answer1.layer.masksToBounds = true
        answer1.layer.borderWidth = 0.5
        answer1.layer.cornerRadius = 5.0
        answer1.layer.borderColor = UIColor(red: 220/255, green: 226/255, blue: 238/255, alpha: 1).cgColor
        answer1.font = UIFont(name: "PlayfairDisplay-Bold", size: 18.5)
        answer1.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        answer1.textAlignment = .center
        answer1.backgroundColor = .white
        addSubview(answer1)
        
        answer2 = UILabel(frame: CGRect(x: wScreen * 0.06, y: answer1.frame.maxY + hScreen * 0.03, width: wScreen * 0.88, height: wScreen * 0.143))
        answer2.layer.masksToBounds = true
        answer2.layer.borderWidth = 0.5
        answer2.layer.cornerRadius = 5.0
        answer2.layer.borderColor = UIColor(red: 220/255, green: 226/255, blue: 238/255, alpha: 1).cgColor
        answer2.font = UIFont(name: "PlayfairDisplay-Bold", size: 18.5)
        answer2.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        answer2.textAlignment = .center
        answer2.backgroundColor = .white
        addSubview(answer2)
        
        answer3 = UILabel(frame: CGRect(x: wScreen * 0.06, y: answer2.frame.maxY + hScreen * 0.03, width: wScreen * 0.88, height: wScreen * 0.143))
        answer3.layer.masksToBounds = true
        answer3.layer.borderWidth = 0.5
        answer3.layer.cornerRadius = 5.0
        answer3.layer.borderColor = UIColor(red: 220/255, green: 226/255, blue: 238/255, alpha: 1).cgColor
        answer3.font = UIFont(name: "PlayfairDisplay-Bold", size: 18.5)
        answer3.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        answer3.textAlignment = .center
        answer3.backgroundColor = .white
        addSubview(answer3)
        
        answer4 = UILabel(frame: CGRect(x: wScreen * 0.06, y: answer3.frame.maxY + hScreen * 0.03, width: wScreen * 0.88, height: wScreen * 0.143))
        answer4.layer.masksToBounds = true
        answer4.layer.borderWidth = 0.5
        answer4.layer.cornerRadius = 5.0
        answer4.layer.borderColor = UIColor(red: 220/255, green: 226/255, blue: 238/255, alpha: 1).cgColor
        answer4.font = UIFont(name: "PlayfairDisplay-Bold", size: 18.5)
        answer4.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        answer4.textAlignment = .center
        answer4.backgroundColor = .white
        addSubview(answer4)
        
        answer5 = UILabel(frame: CGRect(x: wScreen * 0.06, y: answer4.frame.maxY + hScreen * 0.03, width: wScreen * 0.88, height: wScreen * 0.143))
        answer5.layer.masksToBounds = true
        answer5.layer.borderWidth = 0.5
        answer5.layer.cornerRadius = 5.0
        answer5.layer.borderColor = UIColor(red: 220/255, green: 226/255, blue: 238/255, alpha: 1).cgColor
        answer5.font = UIFont(name: "PlayfairDisplay-Bold", size: 18.5)
        answer5.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        answer5.textAlignment = .center
        answer5.backgroundColor = .white
        addSubview(answer5)
    }
}
