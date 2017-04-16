//
//  EmoticonCell.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    lazy var emoticonBtn = UIButton()
    
    var emoticon : Emoticon?{
    
        didSet{
        
            guard let emoticon = emoticon  else {
                return
            }
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonBtn.setTitle(emoticon.emojiCode ?? "", for: .normal)
            
            if emoticon.isRemove {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension EmoticonCell {

    func setupUI(){
        
        addSubview(emoticonBtn)
        
        emoticonBtn.frame = self.bounds
        
        emoticonBtn.isUserInteractionEnabled = false
        
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
