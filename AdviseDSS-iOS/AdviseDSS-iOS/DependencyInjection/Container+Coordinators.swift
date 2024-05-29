import Swinject

extension Container {
    func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SignInCoordinator.self, initializer: SignInCoordinator.init)
    }
}
