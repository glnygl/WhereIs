//
//  MainViewController.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0

class MainViewController: BaseViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    let categoryType = ["ATM", "Bookshop", "Cinema", "Coffee",
                        "Restaurant", "Hospital", "Hotel", "Pharmacy"]
    var place = "Coffee"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cityTextField.text = ""
        SVProgressHUD.dismiss()
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        let cancelButton:UIButton =  UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red:0.72, green:0.05, blue:0.04, alpha:1.0), for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 55, height: 32)
        
        let doneButton:UIButton =  UIButton(type: .custom)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor(red:0.72, green:0.05, blue:0.04, alpha:1.0), for: .normal)
        doneButton.frame = CGRect(x: 0, y: 0, width: 55, height: 32)
        
        let actionSheetPicker = ActionSheetStringPicker(title: "", rows: categoryType, initialSelection: 0, doneBlock: {
            picker, values, indexes in
            
            self.categoryButton.setTitle(indexes as? String, for: .normal)

            self.place = (indexes as! String).lowercased()

            return
            
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        actionSheetPicker?.setCancelButton(UIBarButtonItem(customView: cancelButton))
        actionSheetPicker?.setDoneButton(UIBarButtonItem(customView: doneButton))
        actionSheetPicker?.show()
    }
    
    
    @IBAction func pressedSearchButton(_ sender: UIButton) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let listViewController = mainStoryboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listViewController.navigationItem.title = "Places"
        
        if (self.cityTextField.text?.isEmpty)! {
            self.cityTextField.text = "istanbul"
        }
 
        listViewController.place = self.place
        listViewController.city = self.cityTextField.text!
        self.navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func roundObjects() {
        self.cityTextField.layer.cornerRadius = 8
        self.cityTextField.clipsToBounds = true
        self.searchButton.layer.cornerRadius = 8
        self.searchButton.clipsToBounds = true
        self.categoryButton.layer.cornerRadius = 8
        self.categoryButton.clipsToBounds = true
    }
}
