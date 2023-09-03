//
//  BMI_CalcTests.swift
//  BMI-CalcTests
//
//  Created by Harun Gunes on 23/08/2023.
//

import XCTest
import Combine
@testable import BMI_Calc

final class BMI_CalcTests: XCTestCase {

    private var sut: BMICalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultWithoutWeightAndHeight() {
        // given
        let height: Float = 1.00
        let weight: Float = 0
        let input = buildInput(
            height: height,
            weight: weight)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.bmi, 0.0)
            XCTAssertEqual(result.advice, "Eat more pies!")
        }.store(in: &cancellables)
    }
    
    func testResultWithLowBMI() {
        // given
        let height: Float = 1.80
        let weight: Float = 50
        let input = buildInput(
            height: height,
            weight: weight)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            let formattedBMI = String(format: "%.1f", result.bmi)
            XCTAssertEqual(formattedBMI, String(15.4))
            XCTAssertEqual(result.advice, "Eat more pies!")
        }.store(in: &cancellables)
    }
    
    func testResultWithHighBMI() {
        // given
        let height: Float = 1.50
        let weight: Float = 90
        let input = buildInput(
            height: height,
            weight: weight)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.bmi, 40.0)
            XCTAssertEqual(result.advice, "Eat less pies!")
        }.store(in: &cancellables)
    }
    
    func testIdealBMI() {
        // given
        let height: Float = 1.70
        let weight: Float = 69
        let input = buildInput(
            height: height,
            weight: weight)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            let formattedBMI = String(format: "%.1f", result.bmi)
            XCTAssertEqual(formattedBMI, String(23.9))
            XCTAssertEqual(result.advice, "Fit as a fiddle!")
        }.store(in: &cancellables)
    }
    
    private func buildInput(height: Float, weight: Float) -> BMICalculatorVM.Input {
        return .init(
            heightPublisher: Just(height).eraseToAnyPublisher(),
            weightPublisher: Just(weight).eraseToAnyPublisher()
        )
    }
    
}
