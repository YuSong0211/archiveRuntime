//
//  ViewController.swift
//  archiveRuntime
//
//  Created by  椒徒科技 on 16/9/1.
//  Copyright © 2016年 jiaotukeji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

   
        let p  = Person()
        p.name = "yusong"
        p.age = 20
        p.professional = "ios"
        p.address = "jiaotukeji"
        
        NSKeyedArchiver.archiveRootObject(p, toFile: Path)
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         let p = NSKeyedUnarchiver.unarchiveObjectWithFile(Path) as! Person
    
        print(p.name,p.address ,p.age ,p.professional)
    }
    
    var Path: String{
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        
        return (path as NSString).stringByAppendingPathComponent("account.plist")
    }

}

