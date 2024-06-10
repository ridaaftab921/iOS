//
//  MainCoordinator.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 03/06/2024.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    private let viewModel: SignUpViewModel

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = MainTabBarViewController.instantiate()
        viewController.tabBarDelegate = self
        DispatchQueue.main.async {
            self.navigationController.pushViewController(viewController, animated: false)
        }
    }
}

extension MainCoordinator: TabBarProtocol {
    
    func getViewController(forItem tabItem: TabItem) -> UIViewController {
        var vc: UIViewController!
        
        switch tabItem {
        case .observed:
            vc = MapViewController.instantiate()
        case .feedback, .advisory, .forecast:
            vc = FeedbackViewController.instantiate()
        }
        
        vc.tabBarItem = tabItem.tabBarItem
        return vc
    }
    
    func willTransistionTo(tab: TabItem) {
    }
}
