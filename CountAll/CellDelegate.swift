//
//  CellDelegate.swift
//  CountIt
//
//  Created by maki on 9/12/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import Foundation

protocol CellDelegate {
    func decreaseButtonTapped(cell: TableViewCell)
    
    func increaseButtonTappedLP(cell: TableViewCell)
    
    func increaseButtonTapped(cell: TableViewCell)
}
