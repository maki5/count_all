//
//  ActivityGroup.swift
//  CountIt
//
//  Created by maki on 9/19/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct ActivityGroup {
    var value: Int
    var date: String
}

class ChartDataGenerator {
    
    static var randomizedSale: Int {
        return Int(Double(arc4random_uniform(10000) + 1) / 10)
    }
    
    static func data(recordIndex: Int) -> [ActivityGroup] {
        var activityGroups = [ActivityGroup]()
        let groupedData = groupData(recordIndex: recordIndex)
        
        
        for (key, element) in groupedData {
            let activityGroup = ActivityGroup(value: element, date: key)
            activityGroups.append(activityGroup)
        }
        
        activityGroups =  activityGroups.reversed()
        let arraySlice = activityGroups.suffix(12)
        let newArr = Array(arraySlice)
        
        return newArr
    }
    
    private static func groupData(recordIndex: Int) -> Dictionary<String, Int>{
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var countedObjects = [CountedObject]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountedObject")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CountedObject")
        request.returnsObjectsAsFaults = true
        request.relationshipKeyPathsForPrefetching = ["activities"]
        
        do {
            countedObjects = try context.fetch(fetchRequest) as! [CountedObject]
            
        } catch let error{
            NSLog(error.localizedDescription)
        }
        
        let countedObject = countedObjects[recordIndex]
        let activities = countedObject.activities?.allObjects as! [Activity]
        
        var resDict = Dictionary<String, Int>()
        
        
        for activity in activities {
            let date = activity.created_at! as Date
            let calendar = Calendar.current
            
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            
            let strDate = "\(months[month - 1]) \(year)"
            
            var activityCount = resDict[strDate]
            
            if  (activityCount != nil){
                activityCount = activityCount! + Int(activity.amount)
            } else {
                activityCount = Int(activity.amount)
            }
            
            resDict[strDate] = activityCount
        }
        
        return resDict
    }
    
}
