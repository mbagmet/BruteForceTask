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
        
        self.bruteForce.start(passwordToUnlock: "1"/*"1!gr"*/)
        
        // Do any additional setup after loading the view.
    }
}
