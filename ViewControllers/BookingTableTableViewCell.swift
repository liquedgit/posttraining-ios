//
//  BookingTableTableViewCell.swift
//  posttraining231
//
//  Created by prk on 18/08/23.
//

import UIKit

class BookingTableTableViewCell: UITableViewCell {

    var updateHandler = {
        
    }
    
    var deleteHandler = {
        
    }
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var roomTxt: UITextField!
    
    
    @IBAction func UpdateButtonOnClick(_ sender: Any) {
        updateHandler()
    }
    
    @IBAction func DeleteButtonOnClick(_ sender: Any) {
        deleteHandler()
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
