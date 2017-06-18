//
//  pattern3ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/18.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
//参考　http://hacknote.jp/archives/7958/
class pattern3ViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        let mainViewFrame = UIScreen.main.bounds
        let sampletextFile = UITextField()
        sampletextFile.delegate = self
        sampletextFile.text = "パターン3"
        sampletextFile.borderStyle = UITextBorderStyle.roundedRect
        sampletextFile.frame.size.width = mainViewFrame.size.width/2
        let rec = CGRect(x: mainViewFrame.midX - sampletextFile.frame.size.width/2, y: 500, width:mainViewFrame.size.width/2 , height:  40.0)
        sampletextFile.frame = rec
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
        notificationCenter.addObserver(self, selector: #selector(pattern3ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pattern3ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration:TimeInterval = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        //アニメーションの時間はキーボードが出る時間
        UIView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -rect.size.height)
            //キーボードの分viewを縮小させるアニメーション
            self.view.transform = transform
        },completion:nil)
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double)
        //最初と同じにする。
        UIView.animate(withDuration: duration, animations:{
            self.view.transform = CGAffineTransform(translationX: 0, y:0)
        },
                                   completion:nil)
    }



    


}
