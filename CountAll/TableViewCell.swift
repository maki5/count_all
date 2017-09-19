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
    
    @IBAction func increaseAmount(_ sender: AnyObject) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.normalTap(sender:)))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(sender:)))
        tapGesture.numberOfTapsRequired = 1
        
        sender.addGestureRecognizer(tapGesture)
        sender.addGestureRecognizer(longGesture)
        
    }
    
    func normalTap(sender : UIGestureRecognizer){
        delegate?.increaseButtonTapped(cell: self)
    }
    
    func longTap(sender : UIGestureRecognizer){
        if sender.state == .ended {
           delegate?.increaseButtonTappedLP(cell: self)
        }
        else if sender.state == .began {
        }
        
    }
    
    @IBAction func decreaseAmount(_ sender: Any) {
        delegate?.decreaseButtonTapped(cell: self)
    }
    
    
    
    
}
