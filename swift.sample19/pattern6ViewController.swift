//
//  pattern6ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/19.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class pattern6ViewController: UIViewController, UITextFieldDelegate{

    let sampletextFile = UITextField()
    var txtActiveField = UITextField()
    let scrollViewsample = UIScrollView()
    var marginValue:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.magenta
        
        let mainViewFrame = UIScreen.main.bounds
        
        
        scrollViewsample.frame = mainViewFrame
        scrollViewsample.contentSize = CGSize(width:mainViewFrame.size.width , height:mainViewFrame.height)
        
        sampletextFile.text = "パターン1"
        sampletextFile.delegate = self
        sampletextFile.borderStyle = UITextBorderStyle.roundedRect
        sampletextFile.frame.size.width = mainViewFrame.size.width/2
        let rec = CGRect(x: mainViewFrame.midX - sampletextFile.frame.size.width/2, y: 500, width:mainViewFrame.size.width/2 , height:  40.0)
        sampletextFile.frame = rec
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(pattern1ViewController.tap(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(scrollViewsample)
        scrollViewsample.addSubview(sampletextFile)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(pattern6ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pattern6ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        //編集されたテキストフィールドを格納しておく
        txtActiveField = textField
        return true
    }
    
    func tap(_ sender: UITapGestureRecognizer){
        sampletextFile.resignFirstResponder()
        //        　　self.view.endEditing(true)
    }
    
    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        
        let userInfo = notification.userInfo!
        //キーボードの大きさ調べる
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        
        let scrollvalue = scrollViewsample.contentOffset.y
    
        let txtLimit1 = txtActiveField.frame.maxY + 8.0 - scrollvalue
        
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        //キーボードよりテキストフィールドのy軸が大きかったらキーボードにかかっている状態。スクロールビューに余白をつける。
        if txtLimit1 >= kbdLimit {
            marginValue = keyboardScreenEndFrame.size.height + 8
            scrollViewsample.contentInset=UIEdgeInsetsMake(0, 0, marginValue, 0)
            
        }
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        //キーボードが下がるので余白なし。
        if(marginValue > 0){
            scrollViewsample.contentInset=UIEdgeInsetsMake(0, 0, 0, 0)
            marginValue = 0
        }
       
    
    }

    


}
