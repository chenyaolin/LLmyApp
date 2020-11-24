//
//  LLDBViewController.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2020/10/28.
//  Copyright © 2020 ManlyCamera. All rights reserved.
//

import UIKit
import SQLite3
import SnapKit
import RxSwift
import RxCocoa

class LLDBViewController: UIViewController {
    
    var db: OpaquePointer?
    let disposeBag = DisposeBag()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitleColor(.red, for: .normal)
        view.setTitle("添加", for: .normal)
        return view
    }()
    
    private lazy var updateButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitleColor(.red, for: .normal)
        view.setTitle("更新", for: .normal)
        return view
    }()
    
    private lazy var deleteButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitleColor(.red, for: .normal)
        view.setTitle("删除", for: .normal)
        return view
    }()
    
    private lazy var checkButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitleColor(.red, for: .normal)
        view.setTitle("查询", for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        
        if openDB() {
            print("数据库打开成功")
        }
    }
    
    private func bindViewModel() {
        
        addButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
            let isOk = self?.addModel() ?? false
            if isOk {
                print("插入数据成功")
            } else {
                print("插入数据失败")
            }
            } => disposeBag
        
        deleteButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
            
            let isOk = self?.deleteTable() ?? false
            if isOk {
                print("删除数据成功")
            } else {
                print("删除数据失败")
            }
            } => disposeBag
        
        updateButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
            let isOk = self?.updateModel() ?? false
            if isOk {
                print("更新数据成功")
            } else {
                print("更新数据失败")
            }
            } => disposeBag
        
        checkButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
            self?.checkModel()
            } => disposeBag
        
    }
    
    private func openDB() -> Bool {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//         print(filePath)
         let file = filePath + "/fish.sqlite"
        print(file)
         let cfile = file.cString(using: String.Encoding.utf8)
         let state = sqlite3_open(cfile, &db)
         if state != SQLITE_OK {
             print("打开数据库失败")
             return false
         }
         //创建表
         return creatTable()
    }
    
    func creatTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS 't_fish' ('fid' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'name' text,'age' integer );"
        return execSql(sql: sql)
    }
    
    func addModel() -> Bool {
        let sql = "insert into t_fish (name,age) values ('小鱼','4')"
        return execSql(sql: sql)
    }
    
    func deleteModel() -> Bool {
        let sql = "delete from t_fish where fid = '3'"
        return execSql(sql: sql)
    }
    
    func updateModel() -> Bool {
        let sql = "update t_fish set name = '小鱼仔' where fid = '2'"
        return execSql(sql: sql)
    }
    
    func checkModel() {
        let sql = "SELECT fid, name, age FROM t_fish;"
        execRecordSet(sql: sql)
    }
    
    func deleteTable() -> Bool {
        let sql = "DROP TABLE t_fish"
        return execSql(sql: sql)
    }
    
    func execRecordSet(sql: String) {
     
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("SQL 错误")
            return
        }
     
        print("SQL 正确")
        // 2. 遍历集合
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            // 将单条记录字典添加到结果数组中
            let dic = record(stmt: stmt!)
            print("\(dic)")
        }
     
        // 3. 释放语句句柄 - 很重要，否则会内容泄漏
        sqlite3_finalize(stmt)
    }
    
    private func record(stmt: OpaquePointer) -> [String: AnyObject] {
     
        // 1. 获取查询结果列数
        let colCount = sqlite3_column_count(stmt)
     
        // 单条记录字典
        var row = [String: AnyObject]()
     
        // 2. 遍历所有列，获取每一列的信息
        for col in 0..<colCount {
            // 1> 获取列名
            let cName = sqlite3_column_name(stmt, col)
            let name = String(cString: cName!, encoding: String.Encoding.utf8) ?? ""
     
            // 2> 获取每列数据类型
            let type = sqlite3_column_type(stmt, col)
     
            // 3> 根据数据类型获取对应结果
            var value: AnyObject?
            switch (type) {
            case SQLITE_FLOAT:
                value = sqlite3_column_double(stmt, col) as AnyObject
            case SQLITE_INTEGER:
                value = Int(sqlite3_column_int64(stmt, col)) as AnyObject
            case SQLITE3_TEXT:
                let cText = UnsafePointer<CUnsignedChar>(sqlite3_column_text(stmt, col))
//                value = String(CString: cText, encoding: NSUTF8StringEncoding)
                if let a = cText {
                    value = String(cString: a) as AnyObject
                }
                
            case SQLITE_NULL:
                value = NSNull()
            default:
                print("不支持的数据类型")
            }
     
            print("列名 \(name) 值 \(value)")
            row[name] = value ?? NSNull()
        }
        
        sqlite3_finalize(stmt)
     
        return row
    }
    
    func execSql(sql: String) -> Bool {
        let csql = sql.cString(using: String.Encoding.utf8)
        return sqlite3_exec(db, csql, nil, nil, nil) == SQLITE_OK
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for i in 0..<100 {
//            let stu = Student(name: "张三\(i)", age: Int(arc4random() % 100))
//            stu.insert()
//        }
//    }

}

extension LLDBViewController {
    
    private func setupUI() {
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
        view.addSubview(updateButton)
        updateButton.snp.makeConstraints { (make) in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(updateButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(deleteButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
        
    }
}
