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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = AuthorizationView()
        setupNavigation()
        
        configureViewDelegate()
        
        self.bruteForce.start(passwordToUnlock: "1"/*"1!gr"*/)
        
        // Do any additional setup after loading the view.
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
