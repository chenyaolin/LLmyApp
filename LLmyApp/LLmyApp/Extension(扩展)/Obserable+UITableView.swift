//
//  Obserable+UITableView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift

// tableview cell 绑定
extension Reactive where Base: UITableView {
    func items<S: Sequence, T: UITableViewCell, O: ObservableType>
        (_: T.Type)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, T) -> Void)
        -> Disposable
        where O.E == S, T: Reusable {
            return items(cellIdentifier: T.defaultReuseIdentifier, cellType: T.self)
    }
}

// collectionview cell 绑定
extension Reactive where Base: UICollectionView {
    func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
        (_: Cell.Type)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where O.Element == S, Cell: Reusable {
            return items(cellIdentifier: Cell.defaultReuseIdentifier, cellType: Cell.self)
    }
}

