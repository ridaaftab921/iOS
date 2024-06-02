//
//  SignUpCoordinator.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 29/05/2024.
//

import Foundation

class SignUpCoordinator: BaseCoordinator {
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = SignUpViewController.instantiate()
        viewController.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationController.pushViewController(viewController, animated: false)
        }
    }
}
