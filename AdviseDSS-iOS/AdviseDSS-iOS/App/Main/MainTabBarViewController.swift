//
//  MainTabBarViewController.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 03/06/2024.
//

import UIKit

protocol TabBarProtocol {
    func getViewController(forItem: TabItem) -> UIViewController
    func willTransistionTo(tab: TabItem)
}

class MainTabBarViewController: UITabBarController, Storyboarded {
    static var storyboard = AppStoryboard.main
    var tabBarDelegate: TabBarProtocol?
    private let tabItems: [TabItem] = [.observed, .advisory, .forecast, .feedback]


    override func viewDidLoad() {
        updateTabBarAppearance(items: tabItems)
        super.viewDidLoad()
    }
    
    private func updateTabBarAppearance(items: [TabItem]) {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        tabBarAppearance.backgroundColor = #colorLiteral(red: 0.5379658341, green: 0.6279124022, blue: 0.5405266285, alpha: 1)
        tabBarAppearance.backgroundImage = UIImage(named: "white_b")
        
        updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)
        
        self.tabBar.standardAppearance = tabBarAppearance        
        addItems(items: items)
    }
    
    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
        appearance.normal.iconColor = #colorLiteral(red: 0.5379658341, green: 0.6279124022, blue: 0.5405266285, alpha: 1)
        appearance.selected.iconColor = #colorLiteral(red: 0.5379658341, green: 0.6279124022, blue: 0.5405266285, alpha: 1)
        appearance.normal.titleTextAttributes = [.foregroundColor : UIColor.black]
        appearance.selected.titleTextAttributes = [.foregroundColor : #colorLiteral(red: 0.5379658341, green: 0.6279124022, blue: 0.5405266285, alpha: 1)]
    }
    
    private func addItems(items: [TabItem]) {
        var controllers = [UIViewController]()
        for tab in items {
            if let vc = tabBarDelegate?.getViewController(forItem: tab) {
                controllers.append(vc)
            }
        }
        self.viewControllers = controllers
        self.view.layoutIfNeeded()
    }
}

enum TabItem: String, CaseIterable {
    case observed = "Observed"
    case advisory = "Advisory"
    case forecast = "Forecast"
    case feedback = "Feedback"
    
    var icon: UIImage? {
        switch self {
        case .observed:
            return UIImage(systemName: "eye")!
        case .advisory:
            return UIImage(systemName: "homekit")!
        case .forecast:
            return UIImage(systemName: "chart.bar.fill")!
        case .feedback:
            return UIImage(systemName: "message.fill")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: self.rawValue, image: self.icon, selectedImage: self.icon)
    }
}
