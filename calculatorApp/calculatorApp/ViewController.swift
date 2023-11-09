//
//  ViewController.swift
//  calculatorApp
//
//  Created by Şehriban Yıldırım on 27.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet  var buttons      : [UIButton]!
    @IBOutlet weak var lbResult : UILabel!
        
    var firstNumber     : Double = 0
    var currentOperation: String = ""
    var isMath          : Bool = false
    var isNegative      : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize(){
        self.desingButton(btn: buttons)
        lbResult.text = "0"
    }
    
    func desingButton(btn : [UIButton]){
        for button in btn{
            let buttonSize            = button.frame.size
            button.layer.cornerRadius = buttonSize.width / 2
            button.clipsToBounds      = true
        }
    }
    
    @IBAction func numberButtons(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            if lbResult.text == "0" || isMath {
                lbResult.text = number
                isMath        = false
            } else {
                lbResult.text = lbResult.text! + number
            }
        }
    }
    
    @IBAction func operationButtons(_ sender: UIButton) {
        if let operation = sender.titleLabel?.text {
            isMath = true
            if let displayText = lbResult.text, let number = Double(displayText) {
                firstNumber = number
            }
            currentOperation = operation
        }
    }
    
    @IBAction func equalsButtons(_ sender: UIButton) {
        
        if let displayText = lbResult.text, let secondNumber = Double(displayText) {
            var result: Double = 0
            
            switch currentOperation {
            case "%":
                result = firstNumber.truncatingRemainder(dividingBy: secondNumber)
            case "+":
                result = firstNumber + secondNumber
            case "-":
                result = firstNumber - secondNumber
            case "X":
                result = firstNumber * secondNumber
            case "/":
                if secondNumber != 0 {
                    result = firstNumber / secondNumber
                } else {
                    lbResult.text = "Error"
                }
            default:
                break
            }
            
            lbResult.text = "\(result)"
            isMath = true
        }
    }
    
    @IBAction func clearButtons(_ sender: UIButton) {
        lbResult.text    = "0"
        firstNumber      = 0
        currentOperation = ""
        isMath           = false
    }
    
    @IBAction func decimalButtons(_ sender: UIButton) {
        let currentText = lbResult.text ?? ""
        if !currentText.contains(".") {
            lbResult.text = currentText + "."
        }
    }
    
    @IBAction func toggleSignButtons(_ sender: UIButton) {
        if let displayText = lbResult.text, var number = Double(displayText) {
                 number *= -1
                 lbResult.text = "\(number)"
                 isNegative = !isNegative
        }
    }
}
