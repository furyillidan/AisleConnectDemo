//
//  ListViewController.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/19.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var gasPriceRecordsItem = [GasPriceRecordsItem]()
    var gasPriceItem = [GasPriceList]()
    let getString = "http://data.ntpc.gov.tw/api/v1/rest/datastore/382000000A-000320-002"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.estimatedRowHeight = 180.0;
        self.listTableView.rowHeight = 120;
        
        getList(url: getString)
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    
    func getList(url:String?) {
        //let url = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist"
        Service.sharedInstance.getList(url: getString) { (response) in
            if (response.result.value != nil) {
                let decoder = JSONDecoder()
                let result = try? decoder.decode(GasPriceModel.self, from: response.data!)
                if result?.success == true {
                    self.gasPriceItem = [result?.result] as! [GasPriceList]
                    
                }
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }
        }
        
    }

    
    
    func layout () {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(backToPrevious))
        
        let searchBtn = UIButton.init(type: .custom)
        searchBtn.setImage(UIImage(named: "search"), for: .normal)
        searchBtn.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        let addBtn = UIButton.init(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.addTarget(self, action: #selector(goToAdd), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [searchBtn,addBtn])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 8
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationItem.title = "LISTS"
    }
  
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
   
    @objc func goToSearch () {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "searchViewController") as? searchViewController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func goToAdd () {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "addViewController") as? addViewController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gasPriceItem.first?.records?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if gasPriceItem.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
            let result = gasPriceItem.first!.records
            cell.listNameLabel.text = result![indexPath.row].district
            cell.numberLabel.text = result![indexPath.row].price1
            cell.listImageView.image = UIImage(named: "book")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ListOfProductsController") as? ListOfProductsController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}


