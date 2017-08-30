//
//  AddAmountViewController.swift
//  CountIt
//
//  Created by maki on 8/30/17.
//  Copyright © 2017 cm_apps. All rights reserved.
//

import UIKit

class AddAmountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        label.text = ll
    }
    
    @IBOutlet var label: UILabel!
//    var countedObject = CountedObject()
    var ll = String()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
