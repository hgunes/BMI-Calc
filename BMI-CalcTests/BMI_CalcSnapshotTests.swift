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
    
    func testInitialLogoView() {
        // given
        let size = CGSize(width: screenWidth, height: 78)
        // when
        let view = LogoView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    // MARK: - ResultView
    
    func testInitialResultView() {
        // given
        let size = CGSize(width: screenWidth, height: 170)
        // when
        let view = ResultView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 170)
        let result = BMIResult(bmi: 24.6, advice: "I love eating!")
        // when
        let view = ResultView()
        view.configure(result: result)
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    // MARK: - InputView
    
    func testInitialBMIInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 220)
        // when
        let view = InputView()
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBMIInputViewWithHeightSliderValue() {
        // given
        let size = CGSize(width: screenWidth, height: 220)
        // when
        let view = InputView()
        let slider = view.allSubViewsOf(type: UISlider.self).first
        slider?.value = 1.70
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBMIInputViewWithHeightWeightValue() {
        // given
        let size = CGSize(width: screenWidth, height: 220)
        // when
        let view = InputView()
        let slider = view.allSubViewsOf(type: UISlider.self).last
        slider?.value = 80
        // then
        assertSnapshot(matching: view, as: .image(size: size))
    }
}

extension UIView {
    
    /**
     This is a function to get subViews of a particular type from view recursively.
     It would look recursively in all subviews and return back the subviews of the type T
     */
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
