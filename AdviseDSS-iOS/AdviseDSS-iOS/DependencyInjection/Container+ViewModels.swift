import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(SignInViewModel.self, initializer: SignInViewModel.init)
    }
}
