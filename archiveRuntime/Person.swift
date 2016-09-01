//
//  Person.swift
//  archiveRuntime
//
//  Created by  椒徒科技 on 16/9/1.
//  Copyright © 2016年 jiaotukeji. All rights reserved.
//

import UIKit

class Person: NSObject,NSCoding {

    var name :String?
    var address :String?
    var professional:String?
    var age :Int = 0
    
    override init() {
    }
    //归档
    internal func encodeWithCoder(aCoder: NSCoder){
        var count :UInt32 = 0
        let ivar = class_copyIvarList(Person.self, &count)
        for i in 0..<Int(count) {
            let iv = ivar[i]
            //获取成员变量的名称 -》 c语言字符串
            let cName = ivar_getName(iv)
            //转换成String字符串
            guard  let Strname = String(UTF8String: cName) else{
                //继续下一次遍历
                continue
            }
            //利用kvc 取值
            let value = self.valueForKey(Strname)
            aCoder.encodeObject(value, forKey: Strname)
//            print(value)
        }
          // 释放c 语言对象
        free(ivar)
    }
    //解档
    internal required init?(coder aDecoder: NSCoder){
        super.init()

        var count :UInt32 = 0
        let ivar = class_copyIvarList(Person.self, &count)
        for i in 0..<Int(count) {
            let iv = ivar[i]
            //获取成员变量的名称 -》 c语言字符串
            let cName = ivar_getName(iv)
            //转换成String字符串
            guard  let Strname = String(UTF8String: cName) else{
                //继续下一次遍历
                continue
            }
            //进行解档取值
            let value = aDecoder.decodeObjectForKey(Strname)
            //利用kvc给属性赋值
           setValue(value, forKeyPath: Strname)
//            print(value)
        }
        // 释放c 语言对象
            free(ivar)
        
    }
    
}
