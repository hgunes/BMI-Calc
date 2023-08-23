//
//  BMICalcVC.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit

class BMICalcVC: UIViewController {
    
    let logoView = LogoView()
    let resultView = ResultView()
    let bmiInputView = InputView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(), // spacer
            logoView,
            UIView(), // spacer
            resultView,
            UIView(), // spacer
            bmiInputView,
            UIView(), // spacer
        ])
        stackView.axis = .vertical
        stackView.spacing = 60
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }

    private func layout() {
        view.backgroundColor = .green
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        bmiInputView.snp.makeConstraints { make in
            make.height.equalTo(170)
        }
    }

}

