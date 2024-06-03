import Swinject

extension Container {
    func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SignInCoordinator.self, initializer: SignInCoordinator.init)
        autoregister(SignUpCoordinator.self, initializer: SignUpCoordinator.init)
        autoregister(MainCoordinator.self, initializer: MainCoordinator.init)
    }
}
