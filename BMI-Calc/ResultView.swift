//
//  ResultView.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit

class ResultView: UIView {
    
    private let resultLabel: UILabel = {
        LabelFactory.build(
            text: "0.0",
            font: ThemeFont.bold(ofSize: 54))
    }()
    
    private let adviceLabel: UILabel = {
        LabelFactory.build(
            text: "Enter your height and weight",
            font: ThemeFont.demiBold(ofSize: 18))
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            resultLabel,
            adviceLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: BMIResult) {
        resultLabel.text = String(format: "%.1f", result.bmi)
        adviceLabel.text = result.advice
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
