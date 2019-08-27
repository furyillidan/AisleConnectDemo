//
//  HomeViewController.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    let server = Service()
    let titleLabel = UILabel()
    let accountText = UITextField()
    let passWordText = UITextField()
    let loginBtn = UIButton()
    let FBLoginBtn = UIButton()
    let GoogleLoginBtn = UIButton()
    let session = URLSession(configuration: .default)
    let postString = "https://apistage2.aisleconnect.us/ac.server/oauth/token"
    let sessions = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = UUID().uuidString
        
        postDataToAPI()
        postData()
        self.navigationController?.isNavigationBarHidden = true
        layout()
    
    }

    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    func getData(urlString:String?) {
        Service.sharedInstance.getList(url: urlString) { (data) in
            print(data.result.value as Any)
            
        }
    }
    
    
    @objc func goToListPage () {
        self.loginPass()
//        let account = accountText.text
//        let password = passWordText.text
//
       // let headers = ["Content-type":"application/x-www-form-urlencoded"]
//        let parameters : [String:Any] = ["grant_type":"password",
//                          "username":"paul.lin@lineagenetworks.com",
//                          "password":"welcome1",
//                          "client_id":"my-client",
//                          "client_secret":"my-secret",
//                          "scope":"read"]
        //let urlString = "https://apistage2.aisleconnect.us/ac.server/oauth/token"
        //let url = URL(string: "https://apistage2.aisleconnect.us/ac.server/oauth/token")!
        //let url = URL(string: "http://data.ntpc.gov.tw/api/v1/rest/datastore/382000000A-000307-002")!
//        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "no data")
//                return
//            }
//            let responseJson = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJson = responseJson as? [String:Any] {
//                print(responseJson)
//            }
//        }
//        task.resume()
    
    }
    
//    func postUrlsession () {
//        let session = URLSession.shared
//        let url = "https://apistage2.aisleconnect.us/ac.server/oauth/token"
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "POST"
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let params:[String: Any] = ["grant_type":"password",
//                                    "username":"paul.lin@lineagenetworks.com",
//                                    "password":"welcome1",
//                                    "client_id":"my-client",
//                                    "client_secret":"my-secret",
//                                    "scope":"read"]
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
//            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//                if let response = response {
//                    let nsHTTPResponse = response as! HTTPURLResponse
//                    let statusCode = nsHTTPResponse.statusCode
//                    print ("status code = \(statusCode)")
//                }
//                if let error = error {
//                    print ("\(error)")
//                }
//                if let data = data {
//                    do{
//                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
//                        print ("data = \(jsonResponse)")
//                    }catch _ {
//                        print ("OOps not good JSON formatted response")
//                    }
//                }
//            })
//            task.resume()
//        }catch _ {
//            print ("Oops something happened buddy")
//        }
//    }
    
    func postAlamofire() {
        var par : [String:Any]?
        par = ["grant_type":"password",
               "username":"paul.lin@lineagenetworks.com",
               "password":"welcome1",
               "client_id":"my-client",
               "client_secret":"my-secret",
               "scope":"read"]
        Alamofire.request("https://apistage2.aisleconnect.us/ac.server/oauth/token", method: .post, parameters: par, encoding: URLEncoding.default).responseData { (DataResponse) in
            print(DataResponse.result.value as Any)
            
          }
    }
    
    
    
    
    
    
    func postDataToAPI () {
        var par : [String:Any]?
        par = ["grant_type":"password",
               "username":"paul.lin@lineagenetworks.com",
               "password":"welcome1",
               "client_id":"my-client",
               "client_secret":"my-secret",
               "scope":"read"]
        let url = URL(string: postString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var data : Data?
        do {
            data = try JSONSerialization.data(withJSONObject: par!, options: .prettyPrinted)
        }catch let error{
            print(error)
        }
        request.httpBody = data
        request.httpShouldHandleCookies = true
       
        let session = URLSession(configuration: .default, delegate: self as? URLSessionDelegate, delegateQueue: OperationQueue())
        var dataTask : URLSessionDataTask?
        dataTask = session.dataTask(with: request, completionHandler: { (data, respnse, error) in
            print(data as Any)
            
        })
        dataTask?.resume()
    }
    
    
    func requestPost(urlString: String, parameters: String, completion: @escaping (Data) -> Void) {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        fetchedDataByDataTask(from: request, completion: completion)
    }
    
    private func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                print(error as Any)
            }else{
                guard let data = data else{return}
                completion(data)
            }
        }
        task.resume()
    }
    
    
    func postData() {
        let url = URL(string: "https://apistage2.aisleconnect.us/ac.server/oauth/token")!
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        let parameters : [String:Any] = ["grant_type":"password",
                                         "username":"paul.lin@lineagenetworks.com",
                                         "password":"welcome1",
                                         "client_id":"my-client",
                                         "client_secret":"my-secret",
                                         "scope":"read"]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
       
        
        if let data = postData {
            let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if (error != nil) {
                    print(error!)
                }else{
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse!)
                    
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print("\(String(describing: responseData))")
                }
            }
            dataTask.resume()
        }
    }
    
    
    func layout () {
        
        titleLabel.frame = CGRect(x: 68, y: 120, width: 240, height: 60)
        titleLabel.text = "AisleConnect"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Helvetica-Light", size: 35)
        self.view.addSubview(titleLabel)
        
        accountText.frame = CGRect(x: 67, y: 220, width: 240, height: 60)
        accountText.textColor = UIColor.white
        accountText.setBottmBorder()
        accountText.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.view.addSubview(accountText)
        
        passWordText.frame = CGRect(x: 67, y: 290, width: 240, height: 60)
        passWordText.textColor = UIColor.white
        passWordText.setBottmBorder()
        passWordText.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.view.addSubview(passWordText)
        
        loginBtn.frame = CGRect(x: 60, y: 390, width: 260, height: 60)
        loginBtn.layer.cornerRadius = 10
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.setTitle("Log in", for: .normal)
        loginBtn.addTarget(self, action: #selector(goToListPage), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        FBLoginBtn.frame = CGRect(x: 60, y: 520, width: 260, height: 60)
        FBLoginBtn.layer.cornerRadius = 10
        FBLoginBtn.layer.borderWidth = 2
        FBLoginBtn.layer.borderColor = UIColor.white.cgColor
        FBLoginBtn.setTitle("Log in with Facebook", for: .normal)
        self.view.addSubview(FBLoginBtn)
        
        GoogleLoginBtn.frame = CGRect(x: 60, y: 590, width: 260, height: 60)
        GoogleLoginBtn.layer.cornerRadius = 10
        GoogleLoginBtn.layer.borderWidth = 2
        GoogleLoginBtn.layer.borderColor = UIColor.white.cgColor
        GoogleLoginBtn.setTitle("Log in with Google", for: .normal)
        self.view.addSubview(GoogleLoginBtn)
    }
    
    func logErrorAlert() {
        let alert = UIAlertController(title: "帳號密碼錯誤", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginPass() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension UITextField {
    func setBottmBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
