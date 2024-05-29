import UIKit

class SignInViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.signIn

    @IBOutlet weak var usernameTextField: LocalizedTextField!
    @IBOutlet weak var passwordTextField: LocalizedTextField!
    @IBOutlet weak var signInButton: ButtonWithProgress!

    var viewModel: SignInViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissKeyboard()
    }
}
