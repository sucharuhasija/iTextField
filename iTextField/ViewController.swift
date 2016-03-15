//
//  ViewController.swift
//  iTextField
//
//  Created by Sucharu hasija on 12/03/16.
//  Copyright © 2016 SucharuHasija. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,iTextFieldProtocol{

    @IBOutlet weak var testTextField: iTextField!
    @IBOutlet var testTf: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.testTextField.initilizeiTextFieldWithStrictPasswordHavingRangeFrom(8, to: 12)
        self.testTextField.addIntialToTextFeild("$")
        self.testTextField.delegateOfiTextField = self
    
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isValidOnCondition(text: String) -> Bool {
        return true
    }
    func valueOfUnderProgrssBarWhileTypingWithText(text: String) -> (Float, String) {
        
        
        return (1,text)
    }


}