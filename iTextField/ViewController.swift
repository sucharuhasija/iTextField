//
//  ViewController.swift
//  iTextField
//
//  Created by Sucharu hasija on 12/03/16.
//  Copyright © 2016 SucharuHasija. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,iTextFieldProtocol{

    @IBOutlet weak var itfTypeSimplePassword: iTextField!
    @IBOutlet weak var itfTypeDateOfBirth: iTextField!
    @IBOutlet weak var testTextField: iTextField!
    @IBOutlet weak var itfTypeStrongPassword: iTextField!
    @IBOutlet weak var itfTypeUserDefined: iTextField!
    @IBOutlet var testTf: UIView!
    @IBOutlet weak var iTextFieldType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.testTextField.initilizeiTextFieldWithEmailHavingDefaultSettings()
    
        
    
        self.itfTypeSimplePassword.initilizeiTextFieldWithSimplePasswordHavingRangeFrom(8, to: 15)
        
        self.itfTypeStrongPassword.initilizeiTextFieldWithStrictPasswordHavingRangeFrom(8, to: 15)
        
        self.itfTypeDateOfBirth.initilizeiTextFieldWithDateOfBirthHavingAgeLimitFrom(15, to: 85)
        self.itfTypeUserDefined.intitlizeiTextFieldWithTypeUserDefinedMustAddDelegateWithAllowedCharacterRangeFrom(8, to: 25, andSuggestionArray: ["Hello","Where" , "Am" ,"I"])
        self.itfTypeUserDefined.delegateOfiTextField = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard)))
        
        
    }

    
    func hideKeyboard()
    {
        testTextField.resignFirstResponder()
    
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