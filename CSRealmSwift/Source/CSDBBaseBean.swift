//
//  CSDBBaseBean.swift
//  CSRealmSwift
//
//  Created by 安跃超 on 2019/1/28.
//  Copyright © 2019年 安跃超. All rights reserved.
//

import Foundation
import RealmSwift

open class CSDBBaseBean: Object {

    //忽略属性（Ignored Properties）
    override open class func ignoredProperties() -> [String] {
        return [];
    }

//    //索引属性（Indexed Properties）
//    override open class func indexedProperties() -> [String] {
//        return []
//    }
//    //主键（Primary Keys）
//    override open class func primaryKey() -> String? {
//        return nil
//    }

    /**
     类型
     非可选值形式
     可选值形式
     Bool
     dynamic var value = false
     let value = RealmOptional<Bool>()

     Int
     dynamic var value = 0
     let value = RealmOptional<Int>()

     Float
     dynamic var value: Float = 0.0
     let value = RealmOptional<Float>()

     Double
     dynamic var value: Double = 0.0
     let value = RealmOptional<Double>()

     String
     dynamic var value = ""
     dynamic var value: String? = nil

     Data
     dynamic var value = NSData()
     dynamic var value: NSData? = nil

     Date
     dynamic var value = NSDate()
     dynamic var value: NSDate? = nil

     Object
     必须是可选值
     dynamic var value: Class?

     List
     let value = List<Class>()
     必须是非可选值


     LinkingObjects
     let value = LinkingObjects(fromType: Class.self, property: "property")
     必须是非可选值

     **/


    //Model 数据模型创建
    /**
     1.普通的数据模型
     例：
     /// 狗狗的数据模型
     class Dog: Object {

     dynamic var name: String?
     dynamic var age = 0
     }
     /// 狗狗主人的数据模型
     class Person: Object {
     dynamic var name: String?
     dynamic var birthdate = NSDate()
     }
     **/

    /**
     2.关系绑定
     例：/// 狗狗的数据模型
     class Dog: Object {

     dynamic var name: String?
     dynamic var age = 0
     dynamic var owner: Person?  // 对一关系
     }

     /// 狗狗主人的数据模型
     class Person: Object {

     dynamic var name: String?
     dynamic var birthdate = NSDate()
     let dogs = List<Dog>()  // 对多关系
     }
     **/

    /**
     3.反向关系
     /// 狗狗的数据模型
     class Dog: Object {

     dynamic var name: String?
     dynamic var age = 0
     let owner = LinkingObjects(fromType: Person.self, property: "dogs") // 反向关系
     }

     /// 狗狗主人的数据模型
     class Person: Object {

     dynamic var name: String?
     dynamic var birthdate = NSDate()
     let dogs = List<Dog>()  // 对多关系
     }
     **/

    /**
     4.索引属性（Indexed Properties）
     /// 狗狗的数据模型
     class Dog: Object {

     dynamic var name: String?
     dynamic var age = 0

     override class func indexedProperties() -> [String] {

     return ["name"]
     }
     }
     **/

    /**
     5.主键（Primary Keys）
     /// 狗狗的数据模型
     class Dog: Object {

     dynamic var id = UUID().uuidString
     dynamic var name: String?
     dynamic var age = 0

     override class func primaryKey() -> String? {

     return "id"
     }
     }

     **/

    /**
     6.忽略属性（Ignored Properties）

     /// 狗狗的数据模型
     class Dog: Object {

     dynamic var name: String?
     dynamic var age = 0

     override class func ignoredProperties() -> [String]? {

     return ["name"]
     }
     }
     **/
    
}
