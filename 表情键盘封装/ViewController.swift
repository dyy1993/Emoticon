//
//  ViewController.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    lazy var  emoticonVC : EmoticonController = EmoticonController {[weak self] (emoticon) in
       
        self?.textView.insertEmoticon(emoticon: emoticon)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputView = emoticonVC.view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
  


    @IBAction func sendClick(_ sender: Any) {
        
     print( textView.getEmoticonString())
        
    }
}

