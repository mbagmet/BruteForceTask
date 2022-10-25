//
//  AuthorizationViewDelegate.swift
//  Pr2503
//
//  Created by Михаил Багмет on 14.05.2022.
//

import UIKit

protocol AuthorizationViewDelegate {
    func changeNavigationTitleColor(color: UIColor)
    func startPasswordGenerationAndBruteForce()
}
