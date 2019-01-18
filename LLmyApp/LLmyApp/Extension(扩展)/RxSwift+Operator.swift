//
//  RxSwift+Operator.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import RxSwift
import RxCocoa

/// 绑定操作符优先级
precedencegroup bind {
    associativity: left
    higherThan: DefaultPrecedence
    lowerThan: MultiplicationPrecedence
}

/// 单项绑定操作符
infix operator ~>: bind
func ~> <T>(left: Observable<T>, right: Binder<T>) -> Disposable {
    return left.bind(to: right)
}

func ~> <T>(left: Variable<T>, right: Binder<T>) -> Disposable {
    return left.asObservable().bind(to: right)
}

func ~> <T>(left: Observable<T>, right: Binder<T?>) -> Disposable {
    return left.bind(to: right)
}

func ~> <T>(left: Variable<T>, right: Binder<T?>) -> Disposable {
    return left.asObservable().bind(to: right)
}
func ~> <T>(left: Observable<T>, right: Variable<T>) -> Disposable {
    return left.asObservable().bind(to: right)
}

func ~> <T>(left: Driver<T>, right: Binder<T>) -> Disposable {
    return left.drive(right)
}
func ~> <T>(left: Driver<T>, right: Binder<T?>) -> Disposable {
    return left.drive(right)
}

/// 双向绑定操作符
infix operator <~>: bind
func <~> <T>(left: ControlProperty<T>, right: Variable<T>) -> (Disposable, Disposable) {
    let disposeable1 = right.asObservable().bind(to: left)
    let disposeable2 = left.bind(to: right)
    return (disposeable1, disposeable2)
}
func <~> <T>(left: Variable<T>, right: ControlProperty<T>) -> (Disposable, Disposable) {
    let disposeable2 = left.asObservable().bind(to: right)
    let disposeable1 = right.bind(to: left)
    return (disposeable1, disposeable2)
}

/// dispose操作符优先级
precedencegroup dispose {
    associativity: none
    higherThan: LogicalConjunctionPrecedence
    lowerThan: DefaultPrecedence
}

/// dispose操作符
infix operator =>: dispose
func => (left: Disposable, right: DisposeBag) {
    left.disposed(by: right)
}
func => (left: (Disposable, Disposable), right: DisposeBag) {
    left.0.disposed(by: right)
    left.1.disposed(by: right)
}
