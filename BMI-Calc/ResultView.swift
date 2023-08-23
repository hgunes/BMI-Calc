//
//  ResultView.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit

class ResultView: UIView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = ThemeColor.text
    }
}
