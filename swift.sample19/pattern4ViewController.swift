//
//  pattern4ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/18.
//  Copyright © 2017年 sachiko. All rights reserved.
//
//キーボードに関しての参考URL http://hajihaji-lemon.com/smartphone/swift/uitextview_keyboard/
//レイアウトに関してのURL　http://blog.personal-factory.com/2016/01/11/make-auto-layout-via-code/
import UIKit

class pattern4ViewController: UIViewController,UITextFieldDelegate {

    var txtActiveField = UITextField()
    var testConstraint:NSLayoutConstraint! = nil
    var allY:CGFloat = 0.0
    let sampletextFile = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        let mainViewFrame = UIScreen.main.bounds
        sampletextFile.translatesAutoresizingMaskIntoConstraints = false
        sampletextFile.delegate = self
        sampletextFile.text = "パターン4"
        sampletextFile.borderStyle = UITextBorderStyle.roundedRect
        sampletextFile.frame.size.width = mainViewFrame.size.width/2
        let rec = CGRect(x: mainViewFrame.midX - sampletextFile.frame.size.width/2, y: 500, width:mainViewFrame.size.width/2 , height:  40.0)
        sampletextFile.frame = rec
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(pattern4ViewController.tap(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(sampletextFile)
        
        
        //テキストビューのトップはself.viewのトップから600のところにする制約をつける
       testConstraint = NSLayoutConstraint(item: sampletextFile,
                                                      attribute: NSLayoutAttribute.top,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: self.view,
                                                      attribute: NSLayoutAttribute.top,
                                                      multiplier: 1.0,
                                                      constant:600)
        
        self.view.addConstraint(testConstraint)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(pattern4ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pattern4ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func tap(_ sender: UITapGestureRecognizer){
        sampletextFile.resignFirstResponder()
        //        　　self.view.endEditing(true)
    }

    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        //編集されたテキストフィールドを格納しておく
        txtActiveField = textField
        return true
    }

    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        //キーボードのフレームを取得する。
        if let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            let myBoundSize: CGSize = UIScreen.main.bounds.size
            let txtLimit = txtActiveField.frame.maxY + 8.0
            let kbdLimit = myBoundSize.height - keyboardFrame.size.height
            //テキストビューの最大Y座標と、キーボードの最小Y座標の差を計算する。
            let zureY = txtLimit - kbdLimit
            
            if (zureY > 0) {
                
                //テキストビューの垂直方向の位置の制約に差分をマイナスする。topのy軸をマイナスにして上にあげる
                testConstraint.constant -= zureY
                //allYにいじった分の値を入れとく
                allY = zureY
                
                //アニメーションさせる。
                UIView.animate(withDuration: 0.5, animations:{ self.view.layoutIfNeeded()})
                
            }
        }
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        if(allY > 0) {
            testConstraint.constant += allY
            UIView.animate(withDuration: 0.5, animations:{ self.view.layoutIfNeeded()})
        }
        allY = 0.0
    
        
        
    }
}
