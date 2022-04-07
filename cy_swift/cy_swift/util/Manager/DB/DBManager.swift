//
//  DBManager.swift
//  cy_swift
//
//  Created by yunan on 2022/4/6.
//

import Foundation
import GRDB

class DBManager {
    // 数据库路径
    private static var dbPath: String {
        return FileManager.CachesDirectory() + "/cydb.sqlite"
    }
    
    // 数据库配置
    private static var configuration: Configuration {
        var configuration = Configuration()
        // 设置超时
        configuration.busyMode = Database.BusyMode.timeout(5.0)
        
        return configuration
    }
    
    // MARK: 创建数据库
    static var dbQueue: DatabaseQueue = {
        debugPrint(dbPath)
        let db = try! DatabaseQueue(path: dbPath, configuration: configuration)
        db.releaseMemory()
        return db
    }()
}
