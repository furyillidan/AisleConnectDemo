//
//  ListOfProductTableViewCell.swift
//  AisleConnectDemo
//
//  Created by Neo Chou on 2019/8/27.
//  Copyright © 2019 Neo Chou. All rights reserved.
//

import UIKit

class ListOfProductTableViewCell: UITableViewCell {
    
    
    let listImageView = UIImageView()
    let listNameLabel = UILabel()
    let numberLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layout()
        // Initialization code
    }
    
    func layout () {
        listImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        listNameLabel.frame = CGRect(x: 135, y: 5, width: 100, height: 40)
        numberLabel.frame = CGRect(x: 135, y: 70, width: 100, height: 40)
        listImageView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        listNameLabel.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3)
        numberLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3)
        self.contentView.addSubview(listImageView)
        self.contentView.addSubview(listNameLabel)
        self.contentView.addSubview(numberLabel)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
