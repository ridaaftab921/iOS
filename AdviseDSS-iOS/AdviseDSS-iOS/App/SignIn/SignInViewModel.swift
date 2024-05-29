
class SignInViewModel {
	private let sessionService: SessionService
    
    let email = ""
    let password = ""
    let isSignInActive = false
    let isLoading = false
    
    init(sessionService: SessionService) {
        self.sessionService = sessionService
    }
    
    func signIn() {

    }
}
