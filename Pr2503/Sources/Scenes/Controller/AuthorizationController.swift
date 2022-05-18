//
//  AuthorizationController.swift
//  Pr2503
//
//  Created by Михаил Багмет on 13.05.2022.
//

import UIKit

class AuthorizationController: UIViewController {
    
    // MARK: - Properties
    
    private var authorizationView: AuthorizationView? {
        guard isViewLoaded else { return nil }
        return view as? AuthorizationView
    }
    
    private var bruteForce = BruteForce()
    private var password = Password()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = AuthorizationView()
        setupNavigation()
        
        configureViewDelegate()
    }
}

// MARK: - Navigation

extension AuthorizationController {
    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - AuthorizationViewDelegate

extension AuthorizationController: AuthorizationViewDelegate {
    func changeNavigationTitleColor(color: UIColor) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    
    func startPasswordGenerationAndBruteForce() {
        self.authorizationView?.passwordField.isSecureTextEntry = true
        self.authorizationView?.passwordLabel.text = Strings.generatePasswordTitle
        self.authorizationView?.generatePasswordButton.showLoading()
        
        var passwordToUnlock: String = ""
        
        self.password.startPasswordGeneration() {
            passwordToUnlock = self.password.generatedPassword
            self.authorizationView?.passwordField.text = passwordToUnlock
            
            self.bruteForce.start(passwordToUnlock: passwordToUnlock) {
                self.authorizationView?.passwordField.isSecureTextEntry = false
                self.authorizationView?.passwordLabel.text = self.bruteForce.password
                self.authorizationView?.generatePasswordButton.hideLoading()
            }
        }
    }
}

// MARK: - Configuration

private extension AuthorizationController {
    func configureViewDelegate() {
        authorizationView?.delegate = self
    }
}

// MARK: - Constants

extension AuthorizationController {
    enum Strings {
        static let navigationTitle = "Авторизация"
        static let generatePasswordTitle = "Подбираем пароль..."
    }
}
