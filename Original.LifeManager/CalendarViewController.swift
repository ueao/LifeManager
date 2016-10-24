//
//  ViewController.swift
//  Original.LifeManager
//
//  Created by Aoi Sakaue on 2016/02/17.
//  Copyright © 2016年 Aoi Sakaue. All rights reserved.
//

import UIKit
//カレンダーの画面

//CALayerクラスのインポート
import QuartzCore

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    //メンバ変数の設定（配列格納用）
    var count: Int!
    var mArray: NSMutableArray!
    
    //メンバ変数の設定（カレンダー用）
    var now: Date!
    var year: Int!
    var month: Int!
    var day: Int!
    var maxDay: Int!
    var dayOfWeek: Int!
    
    //メンバ変数の設定（カレンダー関数から取得したものを渡す）
    var comps: DateComponents!
    
    //メンバ変数の設定（カレンダーの背景色）
    var calendarBackGroundColor: UIColor!
    
    //プロパティを指定
    @IBOutlet var calendarBar: UILabel!
    @IBOutlet var prevMonthButton: UIButton!
    @IBOutlet var nextMonthButton: UIButton!
    
    
    
    @IBOutlet weak var ToDokun: UIImageView!
    
    
    //とどくんのコメントを表示する
    
    @IBOutlet var commentLabel: UILabel!
    var commentArray = [AnyObject]()
    var ccount = Int(arc4random() % 16)
    

    //カレンダーの位置決め用メンバ変数
    
    var calendarLabelIntervalX: Int!
    var calendarLabelX: Int!
    var calendarLabelY: Int!
    var calendarLabelWidth: Int!
    var calendarLabelHeight: Int!
    var calendarLabelFontSize: Int!
    
    var buttonRadius: Float!
    
    var calendarIntervalX: Int!
    var calendarX: Int!
    var calendarIntervalY: Int!
    var calendarY: Int!
    var calendarSize: Int!
    var calendarFontSize: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 色を変数に用意しておく
        let color1 = UIColor(
            red: CGFloat(0.93), green: CGFloat(0.83), blue: CGFloat(0.10), alpha: CGFloat(1.0)
        )
        
        // 背景の色を変える
        self.navigationController?.navigationBar.barTintColor = color1
        
        
        
        ////現在起動中のデバイスを取得（スクリーンの幅・高さ）
        //        let screenWidth  = selfwide.screenWidth()
        //        let screenHeight = selfsize.screenHeight()
        
        //アドバイスいただいたところ変更
        //////////////現在起動中のデバイスを取得（スクリーンの幅・高さ///////////////////
        //画面の幅
        let screenWidth = UIScreen.main.bounds.size.width
        //画面の高さ
        let screenHeight = UIScreen.main.bounds.size.height
        
        //iPhone4s
        if(screenWidth == 320 && screenHeight == 480){
            
            calendarLabelIntervalX = 5;
            calendarLabelX         = 45;
            calendarLabelY         = 93;
            calendarLabelWidth     = 40;
            calendarLabelHeight    = 25;
            calendarLabelFontSize  = 14;
            
            buttonRadius           = 20.0;
            
            calendarIntervalX      = 5;
            calendarX              = 45;
            calendarIntervalY      = 120;
            calendarY              = 45;
            calendarSize           = 40;
            calendarFontSize       = 17;
            
            //iPhone5またはiPhone5s
        }else if (screenWidth == 320 && screenHeight == 568){
            
            calendarLabelIntervalX = 5;
            calendarLabelX         = 45;
            calendarLabelY         = 93;
            calendarLabelWidth     = 40;
            calendarLabelHeight    = 25;
            calendarLabelFontSize  = 14;
            
            buttonRadius           = 20.0;
            
            calendarIntervalX      = 5;
            calendarX              = 45;
            calendarIntervalY      = 120;
            calendarY              = 45;
            calendarSize           = 40;
            calendarFontSize       = 17;
            
            //iPhone6
        }else if (screenWidth == 375 && screenHeight == 667){
            
            calendarLabelIntervalX = 15;
            calendarLabelX         = 50;
            calendarLabelY         = 95;
            calendarLabelWidth     = 45;
            calendarLabelHeight    = 25;
            calendarLabelFontSize  = 16;
            
            buttonRadius           = 22.5;
            
            calendarIntervalX      = 15;
            calendarX              = 50;
            calendarIntervalY      = 125;
            calendarY              = 50;
            calendarSize           = 45;
            calendarFontSize       = 19;
            
            self.prevMonthButton.frame = CGRect(x: 15, y: 438, width: CGFloat(calendarSize), height: CGFloat(calendarSize));
            self.nextMonthButton.frame = CGRect(x: 314, y: 438, width: CGFloat(calendarSize), height: CGFloat(calendarSize));
            
            //iPhone6 plus
        }else if (screenWidth == 414 && screenHeight == 736){
            
            calendarLabelIntervalX = 15;
            calendarLabelX         = 55;
            calendarLabelY         = 95;
            calendarLabelWidth     = 55;
            calendarLabelHeight    = 25;
            calendarLabelFontSize  = 18;
            
            buttonRadius           = 25;
            
            calendarIntervalX      = 18;
            calendarX              = 55;
            calendarIntervalY      = 125;
            calendarY              = 55;
            calendarSize           = 50;
            calendarFontSize       = 21;
            ///////////////////////////////////////////////////////////////////////
            //ボタンの位置決める
            self.prevMonthButton.frame = CGRect(x: 18, y: 468, width: CGFloat(calendarSize), height: CGFloat(calendarSize));
            self.nextMonthButton.frame = CGRect(x: 348, y: 468, width: CGFloat(calendarSize), height: CGFloat(calendarSize));
        }
        
        //ボタンを角丸にする
        prevMonthButton.layer.cornerRadius = CGFloat(buttonRadius)
        nextMonthButton.layer.cornerRadius = CGFloat(buttonRadius)
        
        //現在の日付を取得する
        now = Date()
        
        //inUnit:で指定した単位（月）の中で、rangeOfUnit:で指定した単位（日）が取り得る範囲
        let calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range: NSRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in:NSCalendar.Unit.month, for:now)
        
        //最初にメンバ変数に格納するための現在日付の情報を取得する
        comps = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday],from:now)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        let orgYear: NSInteger      = comps.year!
        let orgMonth: NSInteger     = comps.month!
        let orgDay: NSInteger       = comps.day!
        let orgDayOfWeek: NSInteger = comps.weekday!
        let max: NSInteger          = range.length
        
        year      = orgYear
        month     = orgMonth
        day       = orgDay
        dayOfWeek = orgDayOfWeek
        maxDay    = max
        
        //空の配列を作成する（カレンダーデータの格納用）
        mArray = NSMutableArray()
        
        //曜日ラベル定義
        let monthName:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        
        //曜日ラベルを動的に配置
        setupCalendarLabel(monthName as NSArray)
        
        //初期表示時のカレンダーをセットアップする
        setupCurrentCalendar()
    }
    //曜日ラベルの動的配置関数
    func setupCalendarLabel(_ array: NSArray) {
        
        let calendarLabelCount = 7
        
        for i in 0...6{
            
            //ラベルを作成
            let calendarBaseLabel: UILabel = UILabel()
            
            //X座標の値をCGFloat型へ変換して設定
            calendarBaseLabel.frame = CGRect(
                x: CGFloat(calendarLabelIntervalX + calendarLabelX * (i % calendarLabelCount)),
                y: CGFloat(calendarLabelY),
                width: CGFloat(calendarLabelWidth),
                height: CGFloat(calendarLabelHeight)
            )
            
            //日曜日の場合は赤色を指定
            if(i == 0){
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
                
                //土曜日の場合は青色(RoyalBlue4)を指定
            }else if(i == 6){
                
                //RGBカラーの設定は小数値をCGFloat型にしてあげる
                calendarBaseLabel.textColor = UIColor(
                    //                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                    red: CGFloat(0.15), green: CGFloat(0.25), blue: CGFloat(0.55), alpha: CGFloat(1.0)
                    //                    red:0, green:0, blue:0.4, alpha:1.0
                    
                )
                
                //平日の場合は灰色を指定
            }else{
                
                calendarBaseLabel.textColor = UIColor.lightGray
                
            }
            
            //曜日ラベルの配置
            calendarBaseLabel.text = String(array[i] as! NSString)
            calendarBaseLabel.textAlignment = NSTextAlignment.center
            calendarBaseLabel.font = UIFont(name: "System", size: CGFloat(calendarLabelFontSize))
            self.view.addSubview(calendarBaseLabel)
        }
        
        //////////////////////////////////////////////////
        //////////////とどくん喋らせたい/////////////////////
        //single tap/二行目つけたし
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)));
        tapGesture.numberOfTapsRequired = 1;
        self.view.addGestureRecognizer(tapGesture);
        
        // single swipe up
        let swipeUpGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeUp(_:)));
        swipeUpGesture.numberOfTouchesRequired = 1;  //指の数
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpGesture);
        
        
        
        
        
        //とどくん喋らせるよう///////////
        commentArray.append(["ToDoListを見てみよう"])
        commentArray.append(["The Sky is the limit!"])
        commentArray.append(["今日は何の日？"])
        commentArray.append(["大安の日は結婚式が多いんだよ"])
        commentArray.append(["2月29日は四年に一度！"])
        commentArray.append(["体調管理は大事だよ〜"])
        commentArray.append(["宿題は終わった？"])
        commentArray.append(["さては今日デートでしょ"])
        commentArray.append(["僕はトドだよ"])
        commentArray.append(["左のボタンで前月見れるよ"])
        commentArray.append(["ToDo追加はリスト右上のボタン！"])
        commentArray.append(["いい天気だねー"])
        commentArray.append(["It's nice to take a break."])
        commentArray.append(["Let's make it happen."])
        commentArray.append(["Think simply."])
        commentArray.append(["Dreams come true."])
        commentArray.append(["右のボタンで来月に変わるよ"])
       
        
            commentLabel.text! = ""
      
        choiceComment()
        
    }   ///////////ViewDidload終わり//////////////////
    
    //カレンダーを生成する関数
    func generateCalendar(){
        
        //タグナンバーとトータルカウントの定義
        var tagNumber = 1
        let total     = 42
        
        //7×6=42個のボタン要素を作る
        for i in 0...41{
            
            //配置場所の定義
            let positionX   = calendarIntervalX + calendarX * (i % 7)
            let positionY   = calendarIntervalY + calendarY * (i / 7)
            let buttonSizeX = calendarSize;
            let buttonSizeY = calendarSize;
            
            //ボタンをつくる
            let button: UIButton = UIButton()
            button.frame = CGRect(
                x: CGFloat(positionX),
                y: CGFloat(positionY),
                width: CGFloat(buttonSizeX!),
                height: CGFloat(buttonSizeY!)
            )
            
            
            //ボタンの初期設定をする
            if(i < dayOfWeek - 1){
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", for: UIControlState())
                button.isEnabled = false
                
            }else if(i == dayOfWeek - 1 || i < dayOfWeek + maxDay - 1){
                
                //日付の入る部分はボタンのタグを設定する（日にち）
                button.setTitle(String(tagNumber), for: UIControlState())
                button.tag = tagNumber
                tagNumber += 1
                
            }else if(i == dayOfWeek + maxDay - 1 || i < total){
                
                //日付の入らない部分はボタンを押せなくする
                button.setTitle("", for: UIControlState())
                button.isEnabled = false
                
            }
            
            //ボタンの配色の設定
            if(i % 7 == 0){
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0)
                )
            }else if(i % 7 == 6){
                calendarBackGroundColor = UIColor(
                    red: CGFloat(0.15), green: CGFloat(0.25), blue: CGFloat(0.55), alpha: CGFloat(1.0)
                    //                    red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0)
                )
            }else{
                
                calendarBackGroundColor = UIColor.lightGray
                
            }
            
            
            //ボタンのデザインを決定する
            button.backgroundColor = calendarBackGroundColor
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.titleLabel!.font = UIFont(name: "System", size: CGFloat(calendarFontSize))
            button.layer.cornerRadius = CGFloat(buttonRadius)
            
            //配置したボタンを押した際のアクションを設定する
            button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), for: .touchUpInside)
            
            
            //ボタンを配置する
            self.view.addSubview(button)
            mArray.add(button)
        }
        
    }
    
    //タイトル表記を設定する関数
    func setupCalendarTitleLabel() {
        calendarBar.text = String("\(year)年\(month)月")
    }
    
    //現在（初期表示時）の年月に該当するデータを取得する関数
    func setupCurrentCalendarData() {
        
        /*************
         * (重要ポイント)
         * 現在月の1日のdayOfWeek(曜日の値)を使ってカレンダーの始まる位置を決めるので、
         * yyyy年mm月1日のデータを作成する。
         * 後述の関数 setupPrevCalendarData, setupNextCalendarData も同様です。
         *************/
        let currentCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var currentComps: DateComponents = DateComponents()
        
        currentComps.year  = year
        currentComps.month = month
        currentComps.day   = 1
        
        let currentDate: Date = currentCalendar.date(from: currentComps)!
        recreateCalendarParameter(currentCalendar, currentDate: currentDate)
    }
    
    //前の年月に該当するデータを取得する関数
    func setupPrevCalendarData() {
        
        //現在の月に対して-1をする
        if(month == 0){
            year = year - 1;
            month = 12;
        }else{
            month = month - 1;
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        let prevCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var prevComps: DateComponents = DateComponents()
        
        prevComps.year  = year
        prevComps.month = month
        prevComps.day   = 1
        
        let prevDate: Date = prevCalendar.date(from: prevComps)!
        recreateCalendarParameter(prevCalendar, currentDate: prevDate)
    }
    
    //次の年月に該当するデータを取得する関数
    func setupNextCalendarData() {
        
        //現在の月に対して+1をする
        if(month == 12){
            year = year + 1;
            month = 1;
        }else{
            month = month + 1;
        }
        
        //setupCurrentCalendarData()と同様の処理を行う
        let nextCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var nextComps: DateComponents = DateComponents()
        
        nextComps.year  = year
        nextComps.month = month
        nextComps.day   = 1
        
        let nextDate: Date = nextCalendar.date(from: nextComps)!
        recreateCalendarParameter(nextCalendar, currentDate: nextDate)
    }
    
    //カレンダーのパラメータを再作成する関数
    func recreateCalendarParameter(_ currentCalendar: Calendar, currentDate: Date) {
        
        //引数で渡されたものをもとに日付の情報を取得する
        let currentRange: NSRange = (currentCalendar as NSCalendar).range(of: NSCalendar.Unit.day, in:NSCalendar.Unit.month, for:currentDate)
        
        comps = (currentCalendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday],from:currentDate)
        
        //年月日と最後の日付と曜日を取得(NSIntegerをintへのキャスト不要)
        let currentYear: NSInteger      = comps.year!
        let currentMonth: NSInteger     = comps.month!
        let currentDay: NSInteger       = comps.day!
        let currentDayOfWeek: NSInteger = comps.weekday!
        let currentMax: NSInteger       = currentRange.length
        
        year      = currentYear
        month     = currentMonth
        day       = currentDay
        dayOfWeek = currentDayOfWeek
        maxDay    = currentMax
    }
    
    //表示されているボタンオブジェクトを一旦削除する関数
    func removeCalendarButtonObject() {
        
        //ビューからボタンオブジェクトを削除する
        for i in 0..<mArray.count {
            (mArray[i] as AnyObject).removeFromSuperview()
        }
        
        //配列に格納したボタンオブジェクトも削除する
        mArray.removeAllObjects()
    }
    
    //現在のカレンダーをセットアップする関数
    func setupCurrentCalendar() {
        
        setupCurrentCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    //日付ボタンをタップすると日付を教えてくれる
    func buttonTapped(_ button: UIButton){
        commentLabel.text = "今日は\(year)年\(month)月\(button.tag)日だよ！"
        //コンソール表示
        print("\(year)年\(month)月\(button.tag)日が選択されました！")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //前の月のボタンを押した際のアクション
    func getPrevMonthData(_ sender: UIButton) {
        prevCalendarSettings()
    }
    
    //次の月のボタンを押した際のアクション
    func getNextMonthData(_ sender: UIButton) {
        nextCalendarSettings()
    }

    //前月を表示するメソッド
    func prevCalendarSettings() {
        removeCalendarButtonObject()
        setupPrevCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    //次月を表示するメソッド
    func nextCalendarSettings() {
        removeCalendarButtonObject()
        setupNextCalendarData()
        generateCalendar()
        setupCalendarTitleLabel()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//とどくん喋らせる
    func choiceComment() {
    }
    
    func handleTap(_ sender: UITapGestureRecognizer){
        print("Tapped!")
         ccount = Int(arc4random() % 16)
    

        if(ccount % 2 == 0){
            commentLabel.text = ""
        }
        if ccount  == 1{
            commentLabel.text = commentArray[ccount][0] as? String
            
        }
        else{
            commentLabel.text = commentArray[ccount] [0] as? String
            
        }

    }


    func handleSwipeUp(_ sender: UITapGestureRecognizer){
        print("Swiped up!")
        commentLabel.text = "おはよう！"
    }
    
}
