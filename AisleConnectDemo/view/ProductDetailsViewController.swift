//
//  ProductDetailsViewController.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ProductDetails"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ProductDetails", style: .plain, target: self, action: #selector(backToPrevious))
        getList()
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getList() {
        let url = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/product/:id"
        Service.sharedInstance.getList(url: url) { (data) in
            print(data)
            print(data.result.value as Any)
        }
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
