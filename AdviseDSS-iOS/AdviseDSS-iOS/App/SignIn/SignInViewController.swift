import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func showSignup()
    func successfulLogin()
}


class SignInViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.signIn
    weak var delegate: SignInViewControllerDelegate?

    @IBOutlet weak var usernameTextField: LocalizedTextField!
    @IBOutlet weak var passwordTextField: LocalizedTextField!

    var viewModel: SignInViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissKeyboard()
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        delegate?.successfulLogin()
    }
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        delegate?.showSignup()
    }
}
