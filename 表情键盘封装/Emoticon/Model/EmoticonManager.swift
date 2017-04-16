//
//  EmoticonManager.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class EmoticonManager{

   lazy var emoticonPackages : [EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        
        emoticonPackages.append(EmoticonPackage(id: ""))
        emoticonPackages.append(EmoticonPackage(id: "com.apple.emoji"))
        emoticonPackages.append(EmoticonPackage(id: "com.sina.default"))
        emoticonPackages.append(EmoticonPackage(id: "com.sina.lxh"))
    }
}
