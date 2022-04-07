//
//  YLFileManagerExtension.swift
//  cy_swift
//
//  Created by yunan on 2022/4/6.
//

import Foundation

// MARK: 沙盒路径获取
public extension FileManager {
    // MARK: 1.1、获取Home的完整路径名
    static func homeDirectory() -> String {
        //获取程序的Home目录
        return NSHomeDirectory()
    }

    // MARK: 1.2、获取Documnets的完整路径名
    static func DocumnetsDirectory() -> String {
        //获取程序的documentPaths目录
        return NSHomeDirectory() + "/Documents"
    }

    // MARK: 1.3、获取Library的完整路径名
    /**
     这个目录下有两个子目录：Caches 和 Preferences
     Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
     Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出时删除
     */
    static func LibraryDirectory() -> String {
        return NSHomeDirectory() + "/Library"
    }

    // MARK: 1.4、获取/Library/Caches的完整路径名
    static func CachesDirectory() -> String {
        return NSHomeDirectory() + "/Library/Caches"
    }

    // MARK: 1.5、获取Library/Preferences的完整路径名
    static func PreferencesDirectory() -> String {
        return NSHomeDirectory() + "/Library/Preferences"
    }

    // MARK: 1.6、获取Tmp的完整路径名
    // 获取Tmp的完整路径名，用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空
    static func TmpDirectory() -> String {
        return NSHomeDirectory() + "/tmp"
    }
}

// MARK: 文件以及文件夹的操作
public extension FileManager {
    // 文件管理器
    static var fileManager: FileManager {
        return FileManager.default
    }
    
    // MARK: 创建文件夹
    static func createFolder(folderPath: String) -> Bool {
        if isExists(atPath: folderPath) {
            return true
        }
        do {
            // withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch _ {
            debugPrint("create folder failure at " + folderPath)
            return false
        }
    }
    
    // MARK: 删除文件夹
    static func removeFolder(folderPath: String) -> Bool {
        guard isExists(atPath: folderPath) else {
            // 存在不操作
            return true
        }
        do {
            try fileManager.removeItem(atPath: folderPath)
            return true
        } catch _ {
            debugPrint("remove folder failure at " + folderPath)
            return false
        }
    }
    
    // MARK: 创建文件
    static func createFile(filePath: String) -> Bool {
        guard isExists(atPath: filePath) else {
            return fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        return true
    }
    
    // MARK: 删除文件
    static func removeFile(filePath: String) -> Bool {
        guard isExists(atPath: filePath) else {
            // 存在不操作
            return true
        }
        do {
            try fileManager.removeItem(atPath: filePath)
            return true
        } catch _ {
            debugPrint("remove file failure at " + filePath)
            return false
        }
    }
    
    // MARK: 判断文件是否存在
    static func isExists(atPath: String) -> Bool {
        let exist = fileManager.fileExists(atPath: atPath)
        guard exist else {
            return false
        }
        return true
    }
}

// MARK: 文件读写
public extension FileManager {
    
}
