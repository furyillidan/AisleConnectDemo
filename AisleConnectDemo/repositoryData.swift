//
//  repositoryData.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/24.
//  Copyright © 2019 Neo Chou. All rights reserved.
//


protocol repositoryDataDelegate : class {
    func loadDataError()
}


import UIKit

class repositoryData : NSObject {
    
    static let shared = repositoryData()
    
    weak var delegate : repositoryDataDelegate?
    
    var data: GasPriceModel?
    
    var gasPriceList : [GasPriceList]?
    
//    func loadData () {
//        let service = Service()
//        service.delegate = self 
//        service.get()
//    }
}
