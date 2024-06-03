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
        coordinator.navigationController = self.navigationController
        start(coordinator: coordinator)

    }
    
    func successfulLogin() {
        let coordinator = AppDelegate.container.resolve(MainCoordinator.self)!
        coordinator.navigationController = self.navigationController
        start(coordinator: coordinator)
    }

}
