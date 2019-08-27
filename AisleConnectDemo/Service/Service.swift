//
//  Service.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit
import Alamofire
public typealias DataResponse = Alamofire.DataResponse


class Service : NSObject {
    
    static let sharedInstance = Service()
    static let AFManager : Alamofire.SessionManager = {
       let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    func post (_ parameter:[String:Any]) {
        let url = ""
        self.request(url: url, method: .post, parameters: parameter) { (respone) in
            switch respone.result {
            case .success(_):
                guard let _ = respone.data else { return }
            case .failure(_):
                break
            }
        }
    }
    
    

    
    func getList (url:String? , _ callback: @escaping (DataResponse<Any>) -> Void) {
        
        request(url: url!, method: .get, parameters: [:], callback)
    }
    
    
    func request(url:String, method: HTTPMethod, parameters: Parameters?, _ callback:@escaping (DataResponse<Any>) -> Void) {
        
        Service.AFManager.request(url, method: method, parameters: parameters, encoding: method == HTTPMethod.post ? JSONEncoding.default : URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            callback(response)
            
            switch(response.result) {
                
            case .success(_):
                if response.result.value != nil {
                    print(response.request?.httpMethod! as Any, response.request?.url! as Any)
                }
            case .failure(_):
                break
            }
            
        }
    }
    
}

