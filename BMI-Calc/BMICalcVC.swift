//
//  BMICalcVC.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit
import Combine

class BMICalcVC: UIViewController {
    
    let logoView = LogoView()
    let resultView = ResultView()
    let bmiInputView = InputView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(), // spacer
            logoView,
            resultView,
            UIView(), // spacer
            bmiInputView,
            UIView(), // spacer
        ])
        stackView.axis = .vertical
        stackView.spacing = 60
        return stackView
    }()
    
    private let vm = BMICalculatorVM()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    private func bind() {
        
        let input = BMICalculatorVM.Input(
            heightPublisher: bmiInputView.heightValuePublisher,
            weightPublisher: bmiInputView.weightValuePublisher)
        
        let output = vm.transform(input: input)
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }

    private func layout() {
        view.backgroundColor = ThemeColor.bg
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(78)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(170)
        }
        
        bmiInputView.snp.makeConstraints { make in
            make.height.equalTo(220)
        }
    }

}

