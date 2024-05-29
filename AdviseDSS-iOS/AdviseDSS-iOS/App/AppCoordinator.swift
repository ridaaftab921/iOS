import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    var window = UIWindow(frame: UIScreen.main.bounds)
    
//    init(window: UIWindow) {
//        self.window = window
//    }
    
    override func start() {
        window.makeKeyAndVisible()
        showSignIn()
    }
    
    private func showSignIn() {
        removeChildCoordinators()
        
        let coordinator = AppDelegate.container.resolve(SignInCoordinator.self)!
        start(coordinator: coordinator)
        
        ViewControllerUtils.setRootViewController(
            window: window,
            viewController: coordinator.navigationController,
            withAnimation: true)
    }
    
    private func showDashboard() {
    
    }
}
