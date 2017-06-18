//
//  ViewController.swift
//  swift.sample19
//
//  Created by 水野祥子 on 2017/06/18.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
//font種類参考URL http://iphone-tora.sakura.ne.jp/uifont.html
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var addBtn: UIBarButtonItem!
    
    
    private let myItems: NSArray = ["パターン1(スクロールさせるだけ)", "パターン2(かぶるようならその分被らないようにスクロールする)", "パターン3(キーボードの分viewを縮める(アニメーション入り))","パターン4(制約を利用したバージョン)","その他"]
    private var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ホーム"
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        myTableView.dataSource = self
        
        myTableView.delegate = self
        
        let viewA = UIView()
        myTableView.tableFooterView = viewA
        
        self.view.addSubview(myTableView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     Cellの総数を返すデータソースメソッド.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myItems.count
    }
    
    //タップされた時に呼ばれる
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        switch  indexPath.row{
        case 0:
            let part1 = pattern1ViewController()
            self.navigationController?.pushViewController(part1, animated: true)
        case 1:
            let part2 = pattern2ViewController()
            self.navigationController?.pushViewController(part2, animated: true)
        case 2:
            let part3 = pattern3ViewController()
            self.navigationController?.pushViewController(part3, animated: true)
        case 3:
            let part3 = pattern4ViewController()
            self.navigationController?.pushViewController(part3, animated: true)

        default:
            print("他")
        }
        
        
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.font = UIFont(name: "ArialHebrew", size: 10)

        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }


}

