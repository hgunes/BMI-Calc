//
//  BMICalculatorVM.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 27/08/2023.
//

import Foundation
import Combine

class BMICalculatorVM {
    
    struct Input {
        let heightPublisher: AnyPublisher<Float, Never>
        let weightPublisher: AnyPublisher<Float, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<BMIResult, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let bmiResult = BMIResult(
            height: 170,
            weight: 70)
        
        return Output(updateViewPublisher: Just(bmiResult).eraseToAnyPublisher())
    }
}
