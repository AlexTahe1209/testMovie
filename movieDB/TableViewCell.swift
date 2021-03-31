//
//  TableViewCell.swift
//  movieDB
//
//  Created by Alex Rivera BBVA on 31/03/21.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell       : UIImageView!
    @IBOutlet weak var titleCell       : UILabel!
    @IBOutlet weak var descriptionCell : UITextView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(title:String, description: String)
    {
        titleCell.text = title
        descriptionCell.text = description
    }
}
