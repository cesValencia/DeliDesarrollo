//
//  NetworkProtocolMaps.swift
//  Deli
//
//  Created by David Valencia on 28/12/17.
//  Copyright © 2017 Magnetink. All rights reserved.
//

import Foundation

protocol URL_SessionDelegateMaps {
    func connectionFinishSuccessfullM(session: URL_SessionM, response: [NSDictionary]) //Response del mismotipo que devuelve el JSON o utilizar any para cachar cualquiera de los 2
    func connectionFinishWithError(session: URL_SessionM, error: Error)
    func connectionFinishSuccessfull(session: URL_SessionM, response: NSDictionary)
}

class URL_SessionM: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var dataTask: URLSessionDataTask? //Descarga los bytes, evalua la respuesta del servidor
    var responseData: Data = Data() //Respuesta del lado del servidor
    var httpResponse: HTTPURLResponse?
    var delegate: URL_SessionDelegateMaps?
    
    override init() {
        super.init()
    }
    
    //Por cada webservice se requiere una función de este tipo
    func ubicacion(para rango: String, con latitud: String, con longitud: String) {
        
        //TIP: Esto evita que se hagan peticiones de forma simultánea
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "http://104.236.10.17/api/restaurantes/cercanos"
        let sessionCofiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionCofiguration, delegate: self, delegateQueue: OperationQueue.main) //Hilo con el que se trabaja, el MAIN
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60 //Si pasa más de 60 segundos se cancela el dataTask y se cancela
        
        responseData = Data()
        let body = "rango=\(rango)&latitud=\(latitud)&longitud=\(longitud)"
        request.httpBody = body.data(using: .utf8)
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    // Get restaurant Info
    func getRestaurant(id: String) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "http://104.236.10.17/api/restaurantes/" + id
        
        let sessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: .main)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        responseData = Data()
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    //    URLSession Delegate
    
    //Task finalizado con...error o éxito
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            //No hubo error
            
            if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [NSDictionary] {
                
                if resultado != nil {
                    delegate?.connectionFinishSuccessfullM(session: self, response: resultado!)
                } else if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                    if resultado != nil {
                        delegate?.connectionFinishSuccessfull(session: self, response: resultado!)
                    } else if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                        print(resultado!["msg"] as? String ?? "")
                    } else {
                        print("Ocurrió un error con la serialización del JSON")
                    }
                } else if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                    print(resultado!["msg"] as? String ?? "")
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
