//
//  SignUpViewController.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 29/05/2024.
//

import UIKit

protocol SignUpViewControllerDelegate: AnyObject {
    
}

class SignUpViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.signUp
    weak var delegate: SignUpViewControllerDelegate?

    @IBOutlet weak var usernameTextField: LocalizedTextField!
    @IBOutlet weak var passwordTextField: LocalizedTextField!

    var viewModel: SignUpViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissKeyboard()
    }
}
