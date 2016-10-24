//
//  FinishViewController.swift
//  Original.LifeManager
//
//  Created by Aoi Sakaue on 2016/02/25.
//  Copyright © 2016年 Aoi Sakaue. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet var todoLabel1 : UILabel!
    
    
    
    var wordArray: [AnyObject] = [] //ユーザデフォルトからとる
    var shuffledWordArray: [AnyObject] = [] //シャッフルされた配列
    var nowNumber : Int = 0

    let saveData = UserDefaults.standard

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            todoLabel1?.text = ""
        
        
    }
    //Viewが現れた時に出てくる
    override func viewWillAppear(_ animated: Bool){
        if saveData.array(forKey: "WORD") != nil {
            
            wordArray = saveData.array(forKey: "WORD")! as [AnyObject]
            shuffle()
            todoLabel1!.text = shuffledWordArray[nowNumber]["todo"]as? String
        }
        
//        wordArray = saveData.arrayForKey("WORD")!
//        shuffle()
        
//        todoLabel1!.text = shuffledWordArray[nowNumber]["todo"]as? String
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shuffle() {
        while wordArray.count > 0 {
            let index = Int(arc4random_uniform(UInt32(wordArray.count)))
            shuffledWordArray.append(wordArray[index])
            wordArray.remove(at: index)
        }
    }

    
}
