//
//  ListOfProductsViewController.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit

class ListOfProductsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       getList()
       layout()
        
    }
    
    func getList() {
        let url = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist/:id"
        Service.sharedInstance.getList(url: url) { (data) in
            print(data)
            print(data.result.value as Any)
        }
    }
    
    func layout () {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hand_left"), style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backToPrevious))
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationItem.title = "hacks"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ListOfProductsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
