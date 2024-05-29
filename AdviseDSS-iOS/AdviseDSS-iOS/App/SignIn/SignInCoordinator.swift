import Foundation

class SignInCoordinator: BaseCoordinator {
    private let viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }

    override func start() {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.delegate = self

        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [viewController]
    }
}

extension SignInCoordinator: SignInViewControllerDelegate {
    func showSignup() {
        let coordinator = AppDelegate.container.resolve(SignUpCoordinator.self)!
        start(coordinator: coordinator)

    }
}
