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
            text: "26.0",
            font: ThemeFont.bold(ofSize: 54))
    }()
    
    private let adviseLabel: UILabel = {
        LabelFactory.build(
            text: "You should eat more!",
            font: ThemeFont.demiBold(ofSize: 18))
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            resultLabel,
            adviseLabel
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
