//
//  NetworkManager.swift
//  IntroDeli
//
//  Created by David Valencia on 19/11/17.
//  Copyright © 2017 David Valencia. All rights reserved.
//

import Foundation

protocol URL_SessionDelegate {
    func connectionFinishSuccessfull(session: URL_Session, response: NSDictionary) //Response del mismo tipo que devuelve el JSON o utilizar any para cachar cualquiera de los 2
    func connectionFinishWithError(session: URL_Session, error: Error)
}

class URL_Session: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var dataTask: URLSessionDataTask? //Descarga los bytes, evalua la respuesta del servidor
    var responseData: Data = Data() //Respuesta del lado del servidor
    var httpResponse: HTTPURLResponse?
    var delegate: URL_SessionDelegate?
    
    override init() {
        super.init()
    }
    
    //Por cada webservice se requiere una función de este tipo
    func registrar(para username: String, con password: String, con email: String) {
        
        //TIP: Esto evita que se hagan peticiones de forma simultánea
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "http://104.236.10.17/api/usuarios/nuevo"
        let sessionCofiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionCofiguration, delegate: self, delegateQueue: OperationQueue.main) //Hilo con el que se trabaja, el MAIN
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60 //Si pasa más de 60 segundos se cancela el dataTask y se cancela
        
        responseData = Data()
        let body = "email=\(email)&password=\(password)&username=\(username)"
        request.httpBody = body.data(using: .utf8)
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    //Función para hacer login
    func logear(con password: String, con email: String) {
        
        //TIP: Esto evita que se hagan peticiones de forma simultánea
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "http://104.236.10.17/api/usuarios/login"
        let sessionCofiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionCofiguration, delegate: self, delegateQueue: OperationQueue.main) //Hilo con el que se trabaja, el MAIN
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60 //Si pasa más de 60 segundos se cancela el dataTask y se cancela
        
        responseData = Data()
        let body = "email=\(email)&password=\(password)"
        request.httpBody = body.data(using: .utf8)
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    func sendTypeFood(token: String, tipo: String) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "http://104.236.10.17/api/usuarios/tipo_comida"
        let sessionConfig = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        responseData = Data()
        let body = "token=\(token)&tipo_comida=\(tipo)"
        request.httpBody = body.data(using: .utf8)
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    //    URLSession Delegate
    
    //Task finalizado con...error o éxito
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            //No hubo error
            
            if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                
                if resultado != nil {
                    delegate?.connectionFinishSuccessfull(session: self, response: resultado!)
                } else {
                    print("Ocurrió un error con la serialización del JSON")
                }
            }
        } else {
            delegate?.connectionFinishWithError(session: self, error: error!)
        }
    }
    
    //Representación de bytes descargando...
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }
    
    //Servidor respondió con... esta se ejecuta primero si todo va bien se ejecutan las funciones de arriba
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        httpResponse = response as? HTTPURLResponse
        
        if httpResponse?.statusCode == 200 {
            completionHandler(URLSession.ResponseDisposition.allow)
        } else {
            completionHandler(URLSession.ResponseDisposition.cancel)
        }
        
        print("Estatus code server: \(httpResponse!.statusCode)")
    }
    
}
