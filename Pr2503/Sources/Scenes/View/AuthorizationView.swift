//
//  AuthorizationView.swift
//  Pr2503
//
//  Created by Михаил Багмет on 13.05.2022.
//

import UIKit

class AuthorizationView: UIView, AuthorizationViewUserIterations {
    
    // MARK: - Properties
    
    var delegate: AuthorizationViewDelegate?
    
    private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.backgroundColor = .black
                passwordLabel.textColor = .white
                delegate?.changeNavigationTitleColor(color: .white)
            } else {
                self.backgroundColor = .white
                passwordLabel.textColor = .black
                delegate?.changeNavigationTitleColor(color: .black)
            }
        }
    }
    
    // MARK: - Views
    
    private lazy var passwordStackView = createStackView(axis: .vertical, distribution: .equalSpacing)
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: Metric.passwordLabelFontSize)
        label.textColor = .black
        label.text = Strings.passwordLabelTitle
        
        return label
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = Strings.passwordFieldPlaceholder
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var buttonsStackView = createStackView(axis: .horizontal, distribution: .fillEqually)
    
    lazy var generatePasswordButton = createButton(with: Strings.generatePasswordButtonTitle,
                                                           backgroundColor: .systemBlue,
                                                           action: #selector(generatePasswordButtonTappedAction(_:)))
    
    private lazy var changeColorButton = createButton(with: Strings.changeColorButtonTitle,
                                                      backgroundColor: .systemGray,
                                                      action: #selector(changeColorButtonTappedAction(_:)))
    
    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubview(passwordStackView)
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordField)
        passwordStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(generatePasswordButton)
        buttonsStackView.addArrangedSubview(changeColorButton)
    }
    
    private func setupLayout() {
        passwordStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.leftOffset).isActive = true
        passwordStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metric.rightOffset).isActive = true
        passwordStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        buttonsStackView.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: passwordStackView.trailingAnchor).isActive = true
    }
    
    // MARK: - Private functions

    private func createButton(with title: String, backgroundColor: UIColor, action: Selector) -> LoadingButton {
        let button = LoadingButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metric.buttonFontSize, weight: .regular)
        button.backgroundColor = backgroundColor

        button.layer.masksToBounds = true
        button.layer.cornerRadius = Metric.buttonHeight / 2

        button.heightAnchor.constraint(equalToConstant: Metric.buttonHeight).isActive = true

        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }

    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = Metric.stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}

// MARK: - Actions

extension AuthorizationView {
    @objc private func changeColorButtonTappedAction(_ sender: Any) {
        isBlack.toggle()
        print(Thread.current)
    }
    
    @objc private func generatePasswordButtonTappedAction(_ sender: Any) {
        delegate?.startPasswordGenerationAndBruteForce()
    }
}

// MARK: - Constants

extension AuthorizationView {
    enum Metric {

        static let leftOffset: CGFloat = 20
        static let rightOffset: CGFloat = -20

        static let stackViewSpacing: CGFloat = 16
        
        static let passwordLabelFontSize: CGFloat = 18
        
        static let buttonHeight: CGFloat = 40
        static let buttonFontSize: CGFloat = 16
    }
    
    enum Strings {
        static let generatePasswordButtonTitle = "Подобрать"
        static let changeColorButtonTitle = "Сменить цвет"
        static let passwordLabelTitle = "Пароль"
        static let passwordFieldPlaceholder = "введите пароль"
    }
}
