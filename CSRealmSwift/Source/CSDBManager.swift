//
//  CSDBManager.swift
//  CSRealmSwift
//
//  Created by 安跃超 on 2019/1/28.
//  Copyright © 2019年 安跃超. All rights reserved.
//

import Foundation
import RealmSwift

public struct SortOption {
    /// 排序根据的参数名
    var propertyName:String
    /// 是否升序
    var isAscending:Bool
}

public class CSDBManager<T:CSDBBaseBean>: NSObject {

    /// 写入
    public class func write(_ objs:[T]) {
        guard objs.count > 0 else {
            return
        }
        let realm = realmInstance()

        do {
            try realm?.write {
                if objs.count == 1 {
                    if let item = objs.first {
                        realm?.add(item, update: true)
                    }
                } else {
                    realm?.add(objs, update: true)
                }
            }
        } catch let error as NSError {
            print("fail to write transaction: \(error.description)")
        }
    }

    /// 更新
    public class func update(_ session:(()->Void)) {
        let realm = realmInstance()
        do {
            realm?.beginWrite()
            session()
            try realm?.commitWrite()
        } catch let error as NSError {
            print("fail to update transaction: \(error.description)");
        }
    }

    /// query objs in database
    ///
    /// - Parameters:
    ///   - type: target obj type
    ///   - filter: query filter
    ///   - sort: query result sort option
    /// - Returns: query result objs
    public class func query(_ type:T.Type, filter:NSPredicate? = nil, sort:SortOption? = nil) -> [T] {

        let realm = realmInstance();
        var results = realm?.objects(type);

        if filter != nil {
            results = results?.filter(filter!);
        }

        if sort != nil {
            results = results?.sorted(byKeyPath: sort!.propertyName, ascending: sort!.isAscending);
        }

        if results != nil {

            var convertResult:[T] = [];
            for i in 0..<results!.count {
                let item = results![i];
                convertResult.append(item);
            }

            return convertResult;

        }else{
            return [];
        }
    }

    /// query obj with its primary key
    ///
    /// - Parameters:
    ///   - type: target obj type
    ///   - key: primary key
    /// - Returns: query result
    public class func query<K>(_ type:T.Type, withPrimaryKey key:K) -> T? {

        let realm = realmInstance();
        let target = realm?.object(ofType: type, forPrimaryKey: key);

        return target;
    }

    /// delete target objs
    ///
    /// - Parameter objs: target
    public class func delete(_ objs:[T]) {

        guard objs.count > 0 else {
            return;
        }

        let realm = realmInstance();

        do {
            try realm?.write {

                if objs.count == 1 {
                    if let item = objs.first {
                        realm?.delete(item);
                    }
                }else{
                    realm?.delete(objs);
                }
            }
        }catch let err as NSError {
            print("fail to delete transaction: \(err.description)")
        }
    }

    /// delete target objs, if filter is nil, it will delete all target type objs
    ///
    /// - Parameters:
    ///   - type: target obj type
    ///   - filter: filter the target objs need to delete
    public class func delete(_ type:T.Type, filter:NSPredicate? = nil) {
        let targetObjs = self.query(type, filter: filter);
        self.delete(targetObjs);
    }

    /// 删除数据
    /// - Parameters:
    ///   - type: target obj type
    ///   - key: primaryKey
    public class func delete<K>(_ type:T.Type, withPrimaryKey key:K) {

        if let target = self.query(type, withPrimaryKey: key) {
            self.delete([target]);
        }else {
            print("delete fail, obj is not exist");
        }
    }

    /// 清除所有数据
    public class func cleanDB() {
        let realm = realmInstance();

        do {
            try realm?.write {
                realm?.deleteAll();
            }
        }catch let err as NSError {
            print("fail to clean transaction: \(err.description)")
        }
    }

    //初始化数据库
    fileprivate class func realmInstance() -> Realm? {

        if let config = CSDBConfig.shared.realmConfig {
            var instance: Realm? = nil
            do {
                instance = try Realm(configuration: config)
            } catch let error as NSError {
                debugPrint("init realm db fail: \(error.description)")
            }
            return instance;
        } else {
            debugPrint("init realm db fail: !!!config is nil!!!")
            return nil;
        }

    }

    /**
     1.模拟器下
     打印realm数据库地址。。。在模拟器下
     然后打开 Finder 按下 command + shift + G 跳转到对应路径下，用 Realm Browser 打开对应的 .realm 文件就可以看到数据了。
     2.真机下
     如果是真机调试的话，打开 Xcode ，选择菜单 Window 下的 Devices 。选择对应的设备与项目，点击 Download Container。导出 xcappdata 文件后，显示包内容，进到 AppData 下的 Documents ，使用 Realm Browser 打开 .realm 文件即可。
     **/
    public class func printPathInSimulators() {
        let realm = realmInstance()
        if let fileUrl = realm?.configuration.fileURL {
            print("模拟器下realm数据库地址\(fileUrl)")

        }
    }
}
