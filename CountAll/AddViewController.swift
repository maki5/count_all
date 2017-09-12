//
//  AddViewController.swift
//  CountAll
//
//  Created by maki on 8/29/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit


class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBOutlet var objectName: UITextField!
    @IBAction func addNewObject(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let countedObj = CountedObject(context: context)
        countedObj.name = objectName.text
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch let error {
            NSLog(error.localizedDescription)
        }
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
