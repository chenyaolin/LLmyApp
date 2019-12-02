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
    @IBOutlet weak var testImageview: UIImageView!
    
    func bindViewModel(healthCard: CRHealthCard) {
        nameLabel.text = healthCard.name ?? ""
    }
    
    // 创建蓝色文件夹，只编译文件夹不编译文件，适合大图片，并且不会长期在内存有缓存，需要用绝对路径去读取
    // ImageAssets，最主要的使用场景就是 icon 类的图片, 一般 icon 类的图片大小在 3kb 到 20 kb 不等, 都是一些小文件,会有缓存，直接用name来读取
    //
    func setMyImage() {
        let path = Bundle.main.path(forResource: "Bundle/热门头条@2x", ofType: "png")
        testImageview.image = UIImage(contentsOfFile: path!)
    }
    
}
