//
//  Emoticon.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class Emoticon: NSObject {

    var code : String?{
    
        didSet{
        
            guard let code = code else {
                return
            }
            let scanner  = Scanner(string: code)
            
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            
            let c = Character(UnicodeScalar(value)!)
            emojiCode = String(c)
            
            
        }
    
    }      //emoji对应的code
    var chs : String?    //表情对应的文字
    var png : String?{
    
        didSet{
            guard let png = png else{
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }      //表情图片
    
    var pngPath : String?      //表情图片全路径
    var emojiCode : String?    //emoji表情
    var isRemove :Bool = false //是否是删除表情
    var isEmpty :Bool = false //是否是占位表情
    
    init(dict:[String : String]) {
        super.init()
        setValuesForKeys(dict)
    }
    init(isRemove : Bool) {
        super.init()
        self.isRemove = isRemove
    }
    init(isEmpty : Bool) {
        super.init()
        self.isEmpty = isEmpty
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
    
        return dictionaryWithValues(forKeys: ["emojiCode","chs","pngPath"]).description
    }
}
