//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by Jeanne on 2017-09-09.
//  Copyright © 2017 Jeanne d'Arc Uwatowenimana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    var result = 0.0
    var operand = 0.0
    var operation = ""
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTyping) {
            let textCurrentlyInDisplay = display.text!
            // Consecutive 0 or more than 1 point => no change for display
            if((textCurrentlyInDisplay == "0" && digit == "0")
                || (digit == "." && textCurrentlyInDisplay.contains("."))) {
                return
            }
            else if(textCurrentlyInDisplay == "0" && digit != "." && digit != "0") {
                display.text = digit
                return
            }

            display.text = textCurrentlyInDisplay + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    // computed property
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if(userIsInTheMiddleOfTyping) {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}

