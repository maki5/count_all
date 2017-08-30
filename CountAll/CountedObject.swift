//
//  CountedObject.swift
//  CountIt
//
//  Created by maki on 8/30/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import Foundation

extension CountedObject {
    convenience init() {
        
        self.init()
        self.activities = [Activity]() as? NSSet
    }
    
    
}
