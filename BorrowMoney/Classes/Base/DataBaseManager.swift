//
//  DataBaseManager.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/10.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit
import FMDB

class DataBaseManager: NSObject {
    static let shareManager = DataBaseManager()
    var fmdb:FMDatabase!// 定义管理数据库的对象
    let lock = NSLock()
    
    override init() {
        super.init()
        
        //设置数据库的路径;fmdb.sqlite是由自己随意命名
        let path = NSHomeDirectory().appending("/Documents/fmdbData.sqlite")
        //构造管理数据库的对象
        fmdb = FMDatabase(path: path)
        //判断数据库是否打开成功;如果打开失败则需要创建数据库
        if !fmdb.open() {
            XPrint("数据库打开失败...")
            return
        }
    }
    
    
    // 创建表
    func createTableName(sql : String) -> Void {
        let createTable = String (format: "create table if not exists t_%@", sql)//
        do {
            try self.fmdb.executeUpdate(createTable, values: nil)
        } catch  {
            XPrint(self.fmdb.lastErrorMessage())
        }
    }
    
    
    // 插入数据
    func insertData(sql : String,dataArray : NSArray) {
        
        //加锁操作
        lock.lock()
        //sel语句
        //(?,?)表示需要传的值，对应前面出现几个字段，后面就有几个问号
//        let insetSql = String (format: "insert into t_%@", sql)//
//        "insert into student(userName, passWord) values(?,?)"
        //更新数据库
        do {
//            try fmdb.executeUpdate(insetSql, values: [model.userName!,model.passWord!])
        }catch {
            print(fmdb.lastErrorMessage())
        }
        
        //解锁
        lock.unlock()
    }
    
    
    
}
