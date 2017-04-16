//
//  EmoticonController.swift
//  表情键盘封装
//
//  Created by yang on 17/4/7.
//  Copyright © 2017年 dingyangyang. All rights reserved.
//

import UIKit
private let emoticonCellid = "emoticonCellid"
class EmoticonController: UIViewController {
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonCollectionViewLayout())
    
    lazy var toolBar :UIToolbar = UIToolbar()

    let manager : EmoticonManager = EmoticonManager()
    
    var emotionCallBack : (_ emoticon: Emoticon) -> ()
    
    
    init(emotionCallBack : @escaping (_ emoticon: Emoticon) -> ()) {
        self.emotionCallBack = emotionCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let emoticonManager = EmoticonManager()
        for package in emoticonManager.emoticonPackages {
            for emotion in package.emoticons {
                print(emotion)
            }
        }
        
        
    }


}
//设置UI界面
extension EmoticonController{

    func setupUI(){
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        view.backgroundColor = UIColor.green
        collectionView.backgroundColor = UIColor.white
        toolBar.backgroundColor = UIColor.blue
        
        //设置约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["tBar" : toolBar,"collectionView" : collectionView] as [String : Any]
        
       var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[tBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        prepareCollectionView()
        prepareToolBar()
    }
    
  private func prepareCollectionView(){
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: emoticonCellid)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
   private func prepareToolBar(){
    
    let titles = ["最近","默认","emoji","浪小花"]
    var i = 0
    var tempItems = [UIBarButtonItem]()
    
    for title in titles {
       let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(item:)))
        item.tag = i
        i += 1
        
        tempItems.append(item)
        tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
    }
    tempItems.removeLast()
    toolBar.items = tempItems
    
    }
    @objc private func itemClick(item : UIBarButtonItem){
    
        let indexPath = IndexPath(item: 0, section: item.tag)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        
        
    }
}

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension EmoticonController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.emoticonPackages.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return manager.emoticonPackages[section].emoticons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emoticonCellid, for: indexPath) as! EmoticonCell
        
        cell.emoticon = manager.emoticonPackages[indexPath.section].emoticons[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let emoticon = manager.emoticonPackages[indexPath.section].emoticons[indexPath.item]
        
        insertRecentlyEmoticon(emoticon: emoticon)
        
        emotionCallBack(emoticon)

        
    }
  private func insertRecentlyEmoticon(emoticon : Emoticon){
        if emoticon.isEmpty || emoticon.isRemove {
            return
        }
    if manager.emoticonPackages.first!.emoticons.contains(emoticon) {
        
        let index = manager.emoticonPackages.first?.emoticons.index(of: emoticon)
        
         manager.emoticonPackages.first?.emoticons.remove(at: index!)
        
    }else{
    
        manager.emoticonPackages.first?.emoticons.remove(at: 19)
    }
        manager.emoticonPackages.first?.emoticons.insert(emoticon, at: 0)
    
    }
}

/// 自定义表情布局
class EmoticonCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH = UIScreen.main.bounds.width / 7
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.contentInset = UIEdgeInsetsMake(1, 0, 1, 0)
    }
}
