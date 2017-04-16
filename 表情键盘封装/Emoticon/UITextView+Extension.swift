//
//  UITextView+Extension.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit
extension UITextView {

    
    /// 获取字符串
    ///
    /// - Returns: 字符串
    func getEmoticonString() -> String {
        
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        let range = NSRange(location: 0, length: attrStrM.length)
        
        attrStrM.enumerateAttributes(in: range, options: []) { (dict, range, _) in
            if let attachment = dict["NSAttachment"] as? emoticonAttachment{
                
                attrStrM.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        return attrStrM.string
    }
    
    /// 插入表情
    ///
    /// - Parameter emoticon: 表情模型
    func insertEmoticon(emoticon :Emoticon) {
        print(emoticon)
        if emoticon.isEmpty{
            return
        }
        if emoticon.isRemove {
             deleteBackward()
            return
        }
        //插入emoji表情
        if emoticon.emojiCode != nil {
            
             replace( selectedTextRange!, withText: emoticon.emojiCode!)
            return
        }
        //插入普通表情
        
        let attachment = emoticonAttachment()
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        attachment.chs = emoticon.chs
        let font =  self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrStr = NSAttributedString(attachment: attachment)
        
        let mutableAttrStr = NSMutableAttributedString(attributedString:  attributedText)
        let range =  selectedRange
        
        mutableAttrStr.replaceCharacters(in: range, with: attrStr)
        
         attributedText = mutableAttrStr
        
        //文字大小重置
         self.font = font
        //光标位置更新
         selectedRange = NSRange(location: range.location + 1, length: 0)

    }
    
}
