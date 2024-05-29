import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func showSignup()
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
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        delegate?.showSignup()
    }
}
