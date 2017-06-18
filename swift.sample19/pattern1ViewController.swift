//
//  pattern1ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/18.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class pattern1ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
        let mainViewFrame = UIScreen.main.bounds
        
        let scrollViewsample = UIScrollView()
        scrollViewsample.frame = mainViewFrame
         scrollViewsample.contentSize = CGSize(width:mainViewFrame.size.width , height:mainViewFrame.height * 2)
        let sampletextFile = UITextField()
        sampletextFile.text = "パターン1"
        sampletextFile.delegate = self
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
