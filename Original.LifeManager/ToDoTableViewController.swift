//
//  ToDoTableViewController.swift
//  Original.LifeManager
//
//  Created by Aoi Sakaue on 2016/02/21.
//  Copyright © 2016年 Aoi Sakaue. All rights reserved.
//

import UIKit
import CTCheckbox

//ToDoリストの画面
class ToDoTableViewController: UITableViewController {
    
    var wordArray: [AnyObject] = []
    let saveData = UserDefaults.standard
    
//再編集のための
//    var todoEntities: [todo]!
    
    //    @IBOutlet var plusButton: UIButton!
    //    @IBOutlet var backButton: UIButton!
    //    @IBOutlet var doButton: UIButton!
    
    var checkbox = CTCheckbox()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//再？        todoEntities = todo.MR_findAll() as? [todo]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //TableViewCellを使えるようにする
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        
        // 編集ボタンを右上に配置
        navigationItem.rightBarButtonItem = editButtonItem
        
        if saveData.array(forKey: "WORD") != nil {
            wordArray = saveData.array(forKey: "WORD")! as [AnyObject]
            print(wordArray)
        }
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
//移動後
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if saveData.array(forKey: "WORD") != nil {
                wordArray = saveData.array(forKey: "WORD")! as [AnyObject]
    
            }
    
            tableView.reloadData()
        }

    //セクションの数を決める
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの個数を決める
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return wordArray.count
    }
    
    //テーブルセルにデータをセットする
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TableViewCell

//WordList見て直し
        let nowIndexPathDictionary: (AnyObject) =  wordArray[(indexPath as NSIndexPath).row]
        
        cell.ToDoLabel.text = nowIndexPathDictionary["todo"] as? String
        cell.MemoLabel.text = nowIndexPathDictionary["memo"] as? String
        cell.DateLabel.text = nowIndexPathDictionary["date"] as? String
        


        //チェックボックスのタグ
        cell.checkbox.tag = indexPath.row
        cell.checkbox.addTarget(self, action: #selector(ToDoTableViewController.checked(_:)), for: .valueChanged)
        cell.setData()
        return cell
    }
    
    
    //再編集のための遷移//////できれば！！！
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "edit" {
//            let todoController = segue.destinationViewController as! AddViewController
//            let task = todoEntities[tableView.indexPathForSelectedRow()!.row]
//            todoController.task = task
//        }
//    }

    //セル削除ボタン
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    //deleteボタンが押された時の処理
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        wordArray.remove(at: (indexPath as NSIndexPath).row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //wordArrayの保存を行う
        saveData.removeObject (forKey: "WORD")
//        saveData.setObject(wordArray, forKey: "WORD")
        
        
    }
    //編集ボタンを出す
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    //セル移動可能に
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //セル移動後の処理
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoCell = wordArray[(sourceIndexPath as NSIndexPath).row]
       
            wordArray.remove(at: (sourceIndexPath as NSIndexPath).row)
            wordArray.insert(todoCell, at: (destinationIndexPath as NSIndexPath).row)
        
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //ボタンを押した時の移動
    @IBAction func plusButton(_ seque: UIStoryboardSegue) {
    }
//    @IBAction func backButton(){
//        navigationController?.popToRootViewControllerAnimated(true)
//    }
    @IBAction func doButton(_ seque: UIStoryboardSegue) {
    }
    

    
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    
    
    
      // セルの選択状態を保持します
    //    for in文で配列の数だけチェックボックス表示
    func checked(_ sender:CTCheckbox) {
        var selected: [Bool] = []
        for _ in 0 ..< wordArray.count {
            selected.append(false)
        }
        
        selected[sender.tag] = sender.checked
    }
    
    
    class CustomTableViewCell: UITableViewCell{
        var checkbox = CTCheckbox()
        
        func setData() -> Void {
            ////チェックボックスを追加します
            checkbox.frame = CGRect(x: self.frame.width - 44, y: 0, width: 22, height: self.frame.height)
            checkbox.checkboxColor = UIColor.black
        
            checkbox.checkboxSideLength = 22
            self.addSubview(checkbox)
        }
    }
    
    func ToDotableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        if (indexPath as NSIndexPath).row == 0 {
            cell.textLabel!.text = "０行目"
        }else if (indexPath as NSIndexPath).row == 1 {
            cell.textLabel!.text = "１行目"
        }else if (indexPath as NSIndexPath).row == 2 {
            cell.textLabel!.text = "２行目"
        }else if (indexPath as NSIndexPath).row == 3 {
            cell.textLabel!.text = "3行目"
        }else if (indexPath as NSIndexPath).row == 4 {
            cell.textLabel!.text = "4行目"
        }else if (indexPath as NSIndexPath).row == 5 {
            cell.textLabel!.text = "5行目"
        }else if (indexPath as NSIndexPath).row == 6 {
            cell.textLabel!.text = "6行目"
        }else if (indexPath as NSIndexPath).row == 7 {
            cell.textLabel!.text = "7行目"
        }
        return cell
    }
    func ToDotableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0 {//0行目
            performSegue(withIdentifier: "zeroSegue", sender: (indexPath as NSIndexPath).row)
        }else if (indexPath as NSIndexPath).row == 1 {//1行目
            performSegue(withIdentifier: "firstSegue", sender: (indexPath as NSIndexPath).row)
        }else if (indexPath as NSIndexPath).row == 2 {//2行目
            performSegue(withIdentifier: "secondSegue", sender: (indexPath as NSIndexPath).row)
        }
    }

    
//    // Cell が選択された場合
//    func ToDotableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
//        // [indexPath.row] から画像名を探し、UImage を設定
////        selectedImage = UIImage(named:"\(imgArray[indexPath.row])")
////        if selectedImage != nil {
//            // SubViewController へ遷移するために Segue を呼び出す
//            performSegueWithIdentifier("toSubViewController",sender: nil)
//        }
//        
//    }
    func plusbutton(_ segue: UIStoryboardSegue){
        
    }

}
