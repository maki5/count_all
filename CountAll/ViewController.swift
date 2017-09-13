//
//  ViewController.swift
//  CountAll
//
//  Created by maki on 8/29/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {

    @IBOutlet var table: UITableView!
    private var countedObjects = [CountedObject]()
    static var sharedInstace : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ViewController.sharedInstace = self
        populateCountObjects()
        
        if countedObjects.count == 0 {
           performSegue(withIdentifier: "addObjectSegue", sender: self)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateCountObjects()
    }
    
    
    func didCloseModal() {
        populateCountObjects()
    }
    
    func decreaseButtonTapped(cell: TableViewCell) {
        let cellTag = cell.tag
        let countedObject = countedObjects[cellTag]
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let activity = Activity(context: context)
        activity.created_at = Date() as NSDate
        activity.amount = -1
        countedObject.addToActivities(activity)
                
        do {
            try context.save()
        } catch let error {
            NSLog(error.localizedDescription)
        }
        
        populateCountObjects()
    }
    
    func increaseButtonTappedLP(cell: TableViewCell) {
        performSegue(withIdentifier: "addAmountSegue", sender: cell)
    }
    
    func increaseButtonTapped(cell: TableViewCell) {
        let cellTag = cell.tag
        let countedObject = countedObjects[cellTag]
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let activity = Activity(context: context)
        activity.created_at = Date() as NSDate
        activity.amount = 1
        countedObject.addToActivities(activity)
        
        do {
            try context.save()
        } catch let error {
            NSLog(error.localizedDescription)
        }
        
        populateCountObjects()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return countedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countedObject = countedObjects[indexPath.row]
        
        let activities = countedObject.activities?.allObjects as! [Activity]
        
        var count = 0
        for activity in activities {
            count += Int(activity.amount)
        }

        let cell: TableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        guard let name = countedObject.name
            else {
                return cell
        }
        

        cell.name?.text = name
        cell.count?.text = String(count)
        cell.tag = indexPath.row
        cell.delegate = self
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            let objToDelete = countedObjects[indexPath.row]
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            context.delete(objToDelete as NSManagedObject)
            do {
                try context.save()
                populateCountObjects()
            } catch {
                NSLog(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detailsViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAmountSegue" {
            let cell = sender as! UITableViewCell
            let vc = segue.destination as! AddAmountViewController
            vc.tag = cell.tag
            
        }
    }
    
    
    private func populateCountObjects() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountedObject")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CountedObject")
        request.returnsObjectsAsFaults = true
        request.relationshipKeyPathsForPrefetching = ["activities"]
        
        do {
            countedObjects = try context.fetch(fetchRequest) as! [CountedObject]
            table.reloadData()
            
        } catch let error{
            NSLog(error.localizedDescription)
        }
    }
    

}

