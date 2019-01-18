//
//  ReusableViewProtocal.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//  利用swift协议和泛型简化tableView的注册和重用过程

import UIKit

/// 重用view
protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

/// NibView
protocol NibReusable: class {
    static var nibName: String { get }
}

extension NibReusable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

// MARK: - UITableView扩展
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable, T: NibReusable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
            else {
               fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}
