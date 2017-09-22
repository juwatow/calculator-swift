//
//  CalculatorBrain.swift
//  CalculatorSwift
//
//  Created by Jeanne on 2017-09-21.
//  Copyright © 2017 Jeanne d'Arc Uwatowenimana. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}

func percentage(operand: Double) -> Double {
    return operand / 100
}

func division(operand1: Double, operand2: Double) -> Double {
    return operand1 / operand2
}

func addition(op1: Double, op2: Double) -> Double {
    return op1 + op2
}

func soustraction(operand1: Double, operand2: Double) -> Double {
    return operand1 - operand2
}

func multiply(operand1: Double, operand2: Double) -> Double {
    return operand1 * operand2
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "C" : Operation.constant(0),
        "+/-" : Operation.unaryOperation(changeSign),
        "%" : Operation.unaryOperation(percentage),
        "÷" : Operation.binaryOperation(division),
        "+" : Operation.binaryOperation(addition),
        "-" : Operation.binaryOperation(soustraction),
        "*" : Operation.binaryOperation(multiply),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                if pbo != nil && accumulator != nil {
                    accumulator = pbo!.perform(with: accumulator!)
                    pbo = nil
                }
            }
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
