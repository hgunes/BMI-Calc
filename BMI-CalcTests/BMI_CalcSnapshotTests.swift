//
//  BMI_CalcSnapshotTests.swift
//  BMI-CalcTests
//
//  Created by Harun Gunes on 03/09/2023.
//

import XCTest
import SnapshotTesting
@testable import BMI_Calc

final class BMI_CalcSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    // MARK: - LogoView
    
    func testLogoView() {
        // given
        let size = CGSize(width: screenWidth, height: 78)
        // when
        let view = LogoView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    // MARK: - ResultView
    
    func testResultView() {
        // given
        let size = CGSize(width: screenWidth, height: 170)
        // when
        let view = ResultView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    // MARK: - InputView
    
    func testBMIInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 220)
        // when
        let view = InputView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
}
