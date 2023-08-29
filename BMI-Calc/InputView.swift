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
        labelStack(title: "Height", value: "1.75m")
    }()
    
    private lazy var weightStack: UIStackView = {
        labelStack(title: "Weight", value: "70kg")
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
            let formattedHeight = String(format: "%.2f", heightSlider.value)
            heightSubject.send(Float(formattedHeight)!)
            print(formattedHeight)
        }.store(in: &cancellables)
        
    }
    
    private func observeWeight() {
        weightSlider.valuePublisher.sink { [unowned self] weight in
            let formattedWeight = String(format: "%.0f", weightSlider.value)
            weightSubject.send(Float(formattedWeight)!)
            print(formattedWeight)
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
        slider.minimumValue = 0
        
        switch type {
        case .height:
            slider.maximumValue = 3
        case .weight:
            slider.maximumValue = 200
        }
        
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
