//
//  InputView.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit

class InputView: UIView {
    
    private lazy var heightStack: UIStackView = {
        labelStack(title: "Height", value: "1.75m")
    }()
    
    private lazy var weightStack: UIStackView = {
        labelStack(title: "Weight", value: "70kg")
    }()
    
    private lazy var heightSlider: UISlider = {
        buildSlider()
    }()
    
    private lazy var weightSlider: UISlider = {
        buildSlider()
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            heightStack,
            heightSlider,
            weightStack,
            weightSlider,
        ])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
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
        
        addSubview(vStack)
        
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func buildSlider() -> UISlider {
        let slider = UISlider()
        slider.tintColor = ThemeColor.primary
        return slider
    }
    
    private func labelStack(title: String, value: String) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            LabelFactory.build(
                text: title,
                font: ThemeFont.regular(ofSize: 12)),
            UIView(),
            LabelFactory.build(
                text: value,
                font: ThemeFont.regular(ofSize: 12))
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }
    
}
