//
//  LLEqualSpaceCollectionVc.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import FWPopupView

class LLEqualSpaceCollectionVc: UIViewController {
    
    private lazy var myCollectionView: UICollectionView = {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let layout = LLEqualSpaceFlowLayout(minInteritem: 10, minLine: 10, edgeInsets: insets)
        layout.estimatedItemSize = CGSize(width: 100, height: 44)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(LLEqualSpaceCollectionCell.self)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        return view
    }()
    
    private let myDatePicker = LLDatePickerView.loadFromNib()
    private var sourceTags = [TagModel]() // 数据源

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        loadData()
    }
    
    func loadData() {
        guard let data = LLUtils.dataModel("LLEqualSpaceData", type: [TagModel].self) else { return }
        sourceTags = data
        myCollectionView.reloadData()
    }
    
    func makeUI() {
        view.backgroundColor = .white
        view.addSubview(myCollectionView)
        myCollectionView.frame = CGRect(x: 0, y: 0, width: kAppWidth, height: 200)
    }
    
    func pop() {
        let popView = LLPopView(withTip: "")
        popView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

        let vProperty = FWPopupViewProperty()
        vProperty.popupCustomAlignment = .center
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor(white: 0, alpha: 0.5)
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        vProperty.animationDuration = 0.3
        popView.vProperty = vProperty

        popView.show()
    }

}

extension LLEqualSpaceCollectionVc: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(LLEqualSpaceCollectionCell.self, indexPath: indexPath)
        cell.bindData(sourceTags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        myDatePicker.show(WithShowDay: true)
//        myDatePicker.pickFinishBlock = { [weak self] (date: YearAndMonthModel) -> () in
//            print("111111 \(date.year)-\(date.month)-\(date.day)-")
//        }
        
//        let tipPopUpView = CRTipPopUpView()
//        tipPopUpView.frame = UIScreen.main.bounds
//        tipPopUpView.remark = "哈哈"
//        tipPopUpView.show()
        
        pop()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        var cellText = ""
//        let tag = sourceTags[indexPath.item]
//        cellText = tag.tag_name ?? ""
////        let spacing: CGFloat = cellText.count <= 2 ? OYUtils.Adapt(32) : OYUtils.Adapt(20)
//        let spacing: CGFloat = 20
//        
//        let titleLabelSize: CGRect? = cellText.boundingRect(with: CGSize(width: Int(INT32_MAX), height: 20), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 12)], context: nil)
//        let size = CGSize(width: (titleLabelSize?.size.width ?? 0.0) + spacing, height: 44)
//
//        return size
//    }
    
}
