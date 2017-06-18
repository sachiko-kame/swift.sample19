//
//  pattern2ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/18.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

//参考URL http://qiita.com/kobaboy/items/d56086b92f84c586562d
class pattern2ViewController: UIViewController ,UITextFieldDelegate, UIScrollViewDelegate {
    
    var txtActiveField = UITextField()
    let scrollViewsample = UIScrollView()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        let mainViewFrame = UIScreen.main.bounds
        
        scrollViewsample.frame = mainViewFrame
        scrollViewsample.contentSize = CGSize(width:mainViewFrame.size.width , height:mainViewFrame.height + 150)
        let sampletextFile = UITextField()
        sampletextFile.delegate = self
        sampletextFile.text = "パターン2"
        sampletextFile.borderStyle = UITextBorderStyle.roundedRect
        sampletextFile.frame.size.width = mainViewFrame.size.width/2
        let rec = CGRect(x: mainViewFrame.midX - sampletextFile.frame.size.width/2, y: 500, width:mainViewFrame.size.width/2 , height:  40.0)
        sampletextFile.frame = rec
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
        notificationCenter.addObserver(self, selector: #selector(pattern2ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(pattern2ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        
        let userInfo = notification.userInfo!
        //キーボードの大きさ調べる
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        
        let scrollvalue = scrollViewsample.contentOffset.y
        
        //入力したテキストフィールドのy軸と高さと少し余白を足してテキストフィールドのマックスy値と少し余白のy軸をとる
        let txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0 - scrollvalue
        
        //現在のselfViewの高さから、キーボードの高さを引いて残りの幅の高さをみるy軸をみる
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        //キーボードよりテキストフィールドのy軸が大きかったらキーボードにかかっている状態。スクロールビューをその分移動させる。
        if txtLimit >= kbdLimit {
            scrollViewsample.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        
        //スクロールを初期値に戻す　スクロールを全く行っていない状態に戻す。
        //コメントアウトしたので戻らない。
//        scrollViewsample.contentOffset.y = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
