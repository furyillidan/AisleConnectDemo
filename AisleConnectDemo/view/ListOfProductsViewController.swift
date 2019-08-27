//
//  ListOfProductsViewController.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit

class ListOfProductsController: UIViewController {
    
    @IBOutlet weak var listOfProductTableView: UITableView!
    
    var test = ["1","2","3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.listOfProductTableView.delegate = self
        self.listOfProductTableView.dataSource = self
        self.listOfProductTableView.estimatedRowHeight = 180.0;
        self.listOfProductTableView.rowHeight = 100;

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
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfProductTableViewCell", for: indexPath) as! ListOfProductTableViewCell
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
