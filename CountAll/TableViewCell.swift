//
//  TableViewCell.swift
//  CountIt
//
//  Created by maki on 8/29/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {

    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var name: UILabel?
    @IBOutlet var count: UILabel?
    
    
    @IBAction func decreaseAmount(_ sender: Any) {
        let name = self.name?.text
        delegate?.decreaseButtonTapped(cell: self)
    }
    
}
