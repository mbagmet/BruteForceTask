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
    
    func generatePasswordAndBruteForce() {
        self.bruteForce.start(passwordToUnlock: self.password.generatePassword(minLength: 4, maxLength: 5))
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
    }
}
