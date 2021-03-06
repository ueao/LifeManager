//
//  TableViewCell.swift
//  Original.LifeManager
//
//  Created by Aoi Sakaue on 2016/02/21.
//  Copyright © 2016年 Aoi Sakaue. All rights reserved.
//

import Foundation
import CTCheckbox

class TableViewCell: UITableViewCell {
    
    var checkbox = CTCheckbox()
    
    @IBOutlet var ToDoLabel: UILabel!
    @IBOutlet var MemoLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    
    func setData() -> Void {
        //チェックボックスを追加
        checkbox.frame = CGRect(x: self.frame.width - 44, y: 0, width: 22, height: self.frame.height)
        checkbox.checkboxColor = UIColor.black
        checkbox.checkboxSideLength = 22
        self.addSubview(checkbox)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
