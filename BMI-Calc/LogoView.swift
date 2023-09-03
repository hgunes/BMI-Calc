//
//  LogoView.swift
//  BMI-Calc
//
//  Created by Harun Gunes on 23/08/2023.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    private let topLabel: UILabel = {
        LabelFactory.build(
            text: "Calculate",
            font: ThemeFont.bold(ofSize: 30),
            textColor: ThemeColor.logo)
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "your BMI",
                                               attributes: [.font: ThemeFont.bold(ofSize: 22)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 34)],
                           range: NSMakeRange(5, 3))
        label.attributedText = text
        label.textColor = ThemeColor.logo
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        stackView.alignment = .center
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
            make.leading.equalToSuperview()
        }
    }
}
