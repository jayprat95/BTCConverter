//
//  ViewController.swift
//  BTCConverter
//
//  Created by Jayanth Prathipati on 10/6/15.
//  Copyright © 2015 TouchTap. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var convertedValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextField.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
//        convertCurrencyToBTC(); 
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func convertCurrencyToBTC(convValue: String) {
 
        Alamofire.request(.GET, "https://blockchain.info/tobtc?", parameters: ["currency": "USD", "value": convValue])
            .responseJSON { response in
                if let JSON = response.result.value {
                    
                    let foo = String(format: "%.7f", JSON.doubleValue);
                    self.convertedValueLabel.text = foo;
                }
        }
    }
    
    func dismissKeyboard() {
        self.inputTextField.resignFirstResponder();
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        
        print("\(self.inputTextField.text)");
        
        self.convertCurrencyToBTC(self.inputTextField.text!); 
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }


}

