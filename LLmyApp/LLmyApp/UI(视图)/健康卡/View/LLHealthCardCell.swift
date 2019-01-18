//
//  LLHealthCardCell.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

class LLHealthCardCell: UITableViewCell, NibReusable, Reusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func bindViewModel(healthCard: CRHealthCard) {
        nameLabel.text = healthCard.name ?? ""
    }
    
}
