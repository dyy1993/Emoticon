//
//  FindEmoticon.swift
//  表情键盘封装
//
//  Created by yang on 17/4/8.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    static let  shareInstance : FindEmoticon = FindEmoticon()
    
   private lazy var manager :EmoticonManager = EmoticonManager()
    
    func findAttrString(text : String, font : UIFont) -> NSMutableAttributedString? {
        
        let pattern = "\\[.*?\\]"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else{
            return nil
        }
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
        let attrStrM = NSMutableAttributedString(string: text)
        
        for i in (0..<results.count).reversed() {
            
            let result = results[i]
            
            let chs = (text as NSString).substring(with: result.range)
            
            guard let pngPath = findPngPath(chs: chs) else{
            
                return nil
            }
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            
           let attrStr = NSAttributedString(attachment: attachment)
            
            attrStrM.replaceCharacters(in: result.range, with: attrStr)
            
            
        }
        return attrStrM
 
        
    }
    private func findPngPath(chs : String) -> String? {
        for package in manager.emoticonPackages{
        
            for emticon in package.emoticons {
                if emticon.chs == chs {
                    return emticon.pngPath
                }
            }
        }
        return nil
        
    }
    
}
