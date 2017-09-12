//
//  AddAmountViewController.swift
//  CountIt
//
//  Created by maki on 8/30/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit
import CoreData

class AddAmountViewController: UIViewController {

    var tag = Int()
    var countedObjects = [CountedObject]()
    var countedObject: CountedObject? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        countedObject = countedObjects[tag]
        if let name = countedObject?.name {
            label.text = "Add the amount of \(name)"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var amount: UITextField!
    @IBAction func closeModal(_ sender: Any) {
        
        if let amountVal = amount.text {
            if let amountInt = Int16(amountVal) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let activity = Activity(context: context)
                activity.created_at = Date() as NSDate
                activity.amount = amountInt
                
                countedObject?.addToActivities(activity)
                
                do {
                    try context.save()
                    navigationController?.popViewController(animated: true)
                } catch let error {
                    NSLog(error.localizedDescription)
                }
            }
        }
        
        
        dismiss(animated: true, completion: nil)
        ViewController.sharedInstace?.didCloseModal()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
