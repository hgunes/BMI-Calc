//
//  InputView.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class InputView: UIView {
    
    enum SliderType {
        case weight
        case height
    }
    
    private lazy var heightStack: UIStackView = {
        labelStack(title: "Height", valueLabel: heightLabel)
    }()
    
    private lazy var weightStack: UIStackView = {
        labelStack(title: "Weight", valueLabel: weightLabel)
    }()
    
    private let heightLabel: UILabel = {
        LabelFactory.build(
            text: "0.00",
            font: ThemeFont.regular(ofSize: 12))
    }()
    
    private let weightLabel: UILabel = {
        LabelFactory.build(
            text: "0",
            font: ThemeFont.regular(ofSize: 12))
    }()
    
    private lazy var heightSlider: UISlider = {
        buildSlider(type: .height)
    }()
    
    private lazy var weightSlider: UISlider = {
        buildSlider(type: .weight)
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
    
    private let heightSubject: PassthroughSubject<Float, Never> = .init()
    
    var heightValuePublisher: AnyPublisher<Float, Never> {
        return heightSubject.eraseToAnyPublisher()
    }
    
    private let weightSubject: PassthroughSubject<Float, Never> = .init()
    
    var weightValuePublisher: AnyPublisher<Float, Never> {
        return weightSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observeHeight()
        observeWeight()
    }
    
    private func observeHeight() {
        heightSlider.valuePublisher.sink { [unowned self] height in
            heightLabel.text = String(format: "%.2f", heightSlider.value)
            heightSubject.send(height)
        }.store(in: &cancellables)
        
    }
    
    private func observeWeight() {
        weightSlider.valuePublisher.sink { [unowned self] weight in
            weightLabel.text = String(format: "%.0f", weightSlider.value)
            weightSubject.send(weight)
        }.store(in: &cancellables)
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
    
    private func buildSlider(type: SliderType) -> UISlider {
        let slider = UISlider()
        slider.tintColor = ThemeColor.primary
        slider.thumbTintColor = ThemeColor.text
        
        switch type {
        case .height:
            slider.minimumValue = 1
            slider.maximumValue = 3
        case .weight:
            slider.minimumValue = 0
            slider.maximumValue = 200
        }
        
        return slider
    }
    
    private func labelStack(title: String, valueLabel: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            LabelFactory.build(
                text: title,
                font: ThemeFont.regular(ofSize: 12)),
            UIView(),
            valueLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }
    
}
