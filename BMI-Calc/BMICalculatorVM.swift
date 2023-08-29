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
        
        let updateViewPublisher = Publishers.CombineLatest(
            input.heightPublisher,
            input.weightPublisher).flatMap { [unowned self] (height, weight) in
                let bmiResult = calculateBMI(height: height, weight: weight)
                return Just(bmiResult).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func calculateBMI(height: Float, weight: Float) -> BMIResult {
        
        // bmi value
        let bmiValue = weight / (height * height)
        
        // advice
        var adviceText = "Just tell me about yourself"
        
        if bmiValue < 18.5 {
            adviceText = "Eat more pies!"
        } else if bmiValue < 24.9 {
            adviceText = "Fit as a fiddle!"
        } else {
            adviceText = "Eat less pies!"
        }
        
        return BMIResult(bmi: bmiValue, advice: adviceText)
    }
}
