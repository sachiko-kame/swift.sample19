//
//  pattern5ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/19.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class pattern5ViewController: UIViewController ,UITextFieldDelegate{

    var txtActiveField = UITextField()
    var scrollFormer:CGFloat! = nil
    let sampletextFile = UITextField()
    var Adj:CGFloat! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        
        let mainViewFrame = UIScreen.main.bounds
        
        sampletextFile.delegate = self
        sampletextFile.text = "パターン5"
        sampletextFile.borderStyle = UITextBorderStyle.roundedRect
        sampletextFile.frame.size.width = mainViewFrame.size.width/2
        let rec = CGRect(x: mainViewFrame.midX - sampletextFile.frame.size.width/2, y: 500, width:mainViewFrame.size.width/2 , height:  40.0)
        sampletextFile.frame = rec
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(pattern2ViewController.tap(_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.addSubview(sampletextFile)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(pattern5ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pattern5ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        //self.view.endEditing(true)
    }
    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        
        let userInfo = notification.userInfo!
        //キーボードの大きさ調べる
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        
        let txtLimit = txtActiveField.frame.maxY + 8.0        
        //現在のselfViewの高さから、キーボードの高さを引いて残りの幅の高さをみるy軸をみる
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        Adj = txtLimit - kbdLimit
        
        if txtLimit > 0 {
            sampletextFile.frame.origin.y -= Adj
//            sampletextFile.setNeedsDisplay()

            }
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        if(Adj > 0) {
            sampletextFile.frame.origin.y += Adj
//            sampletextFile.setNeedsDisplay()
        }
        Adj = 0.0
        
    }

}
