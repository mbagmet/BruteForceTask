//
//  AuthorizationView.swift
//  Pr2503
//
//  Created by Михаил Багмет on 13.05.2022.
//

import UIKit

class AuthorizationView: UIView {
    
    // MARK: - Properties
    
    private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.backgroundColor = .black
            } else {
                self.backgroundColor = .white
            }
        }
    }
    
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
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        // TODO
    }
    
    private func setupLayout() {
        // TODO
    }
    
    // MARK: - Actions
    
    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }
}
