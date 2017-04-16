//
//  EmoticonPackage.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {

    lazy var emoticons : [Emoticon] = [Emoticon]()
    
    init(id : String) {
        super.init()
        if id == "" {
            addEmptyEmoticon(isRecently: true)
            return
        }
        let path = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        
        let array =  NSArray(contentsOfFile: path!) as! [[String : String]]
        
        var index = 0
        
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = "\(id)/\(png)"
            }
           emoticons.append(Emoticon(dict: dict))
            //添加删除按钮
            index += 1
            if index == 20 {
                emoticons.append(Emoticon(isRemove: true))
                index = 0
            }
        }
    
        addEmptyEmoticon(isRecently: false)
    }
    
  /// 添加占位表情
  ///
  /// - Parameter isRecently: 是否是最近表情
  private func addEmptyEmoticon(isRecently : Bool){
        let count = emoticons.count % 21
        if count == 0 && !isRecently {
            return
        }
        for _ in count ..< 20 {
            emoticons.append(Emoticon(isEmpty: true))
        }
         emoticons.append(Emoticon(isRemove: true))
        
        
    }
    
}
