# Emoticon
###swift表情键盘 一行代码搞定
##使用
#####懒加载表情键盘控制器
```
 lazy var  emoticonVC : EmoticonController = EmoticonController {[weak self] (emoticon) in
       
        self?.textView.insertEmoticon(emoticon: emoticon)
    }
    
```
#####替换键盘
```objc
   textView.inputView = emoticonVC.view
    
```
