//
//  ViewController.swift
//  CountAll
//
//  Created by maki on 8/29/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    private var countedObjects = [CountedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAmountSegue" {
            
            if let button = sender as? UIButton {
                let cell = button.superview?.superview as! UITableViewCell
                let tag = cell.tag
                
                let vc = segue.destination as! AddAmountViewController
//                vc.countedObject = countedObjects[tag]
                vc.ll = "dbhjsbhdj"
            }
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

