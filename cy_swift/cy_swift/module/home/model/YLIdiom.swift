//
//  YLIdiom.swift
//  cy_swift
//
//  Created by yunan on 2022/4/6.
//

import Foundation
import GRDB

struct YLIdiom: Codable {
    /// Int64 is the recommended type for auto-incremented database ids.
    /// Use nil for idiom that are not inserted yet in the database.
    var id: Int64?
    // 名字
    var name: String?
    
    // 拼音
    var pinyin: String?
    
    // 基本释义
    var jbsy: Array<String>?
    
    // 详细释义
    var xxsy: Array<String>?
    
    // 出处
    var chuchu: String?
    
    // 例句
    var lijiu: String?
    
    // 近义词
    var jyc: Array<String>?
    
    // 反义词
    var fyc: Array<String>?
    
    // 设置行名
    private enum Columns: String, CodingKey, ColumnExpression {
        case name, pinyin, jbsy, xxsy, chuchu, lijiu, jyc, fyc
    }
}

// MARK: 数据库相关
extension YLIdiom: MutablePersistableRecord, FetchableRecord {
    private static let dbQueue = DBManager.dbQueue
    // MARK: 创建表
    private static func createTable() -> Void {
        try! dbQueue.inDatabase { (db) -> Void in
            if try db.tableExists("ylIdiom") {
                return
            }
            try db.create(table: "ylIdiom", temporary: false, ifNotExists: true, body: { (t) in
                t.autoIncrementedPrimaryKey("id")
                t.column(Columns.name.rawValue, Database.ColumnType.text)
                t.column(Columns.pinyin.rawValue, Database.ColumnType.text)
                t.column(Columns.jbsy.rawValue, Database.ColumnType.blob)
                t.column(Columns.xxsy.rawValue, Database.ColumnType.blob)
                t.column(Columns.chuchu.rawValue, Database.ColumnType.text)
                t.column(Columns.lijiu.rawValue, Database.ColumnType.text)
                t.column(Columns.jyc.rawValue, Database.ColumnType.blob)
                t.column(Columns.fyc.rawValue, Database.ColumnType.blob)
            })
        }
    }
    // MARK: 增
    static func insert(idiom: YLIdiom) -> Void {
        guard YLIdiom.query(name: idiom.name ?? "") == nil else {
            debugPrint("is already exist")
            
            return
        }
        createTable()
        try! dbQueue.inTransaction{ (db) -> Database.TransactionCompletion in
            do {
                var temp = idiom
                try temp.insert(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
    // MARK: 删
    static func delete(name: String) -> Void {
        // 查询
        guard let idiom = query(name: name) else {
            return
        }
        delete(idiom: idiom)
    }
    
    static func delete(idiom: YLIdiom) -> Void {
        createTable()
        try! dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
            do {
                try idiom.delete(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
    
    // MARK: 改
    static func update(idiom: YLIdiom) -> Void {
        createTable()
        try! dbQueue.inTransaction{ (db) -> Database.TransactionCompletion in
            do {
                try idiom.update(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
    // MARK: 查
    static func query(name: String) -> YLIdiom? {
        createTable()
        return try! dbQueue.unsafeRead({ (db) -> YLIdiom? in
            return try YLIdiom.filter(Column(Columns.name.rawValue) == name).fetchOne(db)
        })
    }
    
    // MARK: 查询所有
    static func queryAll() -> [YLIdiom] {
        createTable()
        return try! dbQueue.unsafeRead( { (db) -> [YLIdiom] in
            return try YLIdiom.fetchAll(db)
        })
    }
}

