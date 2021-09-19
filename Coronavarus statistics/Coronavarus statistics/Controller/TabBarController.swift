//
//  MainTabController.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTabBar()
        configureViewControllers()
    }
    
    func configureNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = .black
    }
    
    func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func configureViewControllers() {
        let overviewNav = UINavigationController(rootViewController: OverviewVC())
        overviewNav.title = "Overview"
        overviewNav.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        overviewNav.navigationBar.barTintColor = .white
        
        let byCountryNav = UINavigationController(rootViewController: ByCountryVC())
        byCountryNav.title = "By country"
        byCountryNav.tabBarItem.image = UIImage(systemName: "globe")
        byCountryNav.navigationBar.barTintColor = .white
        
        viewControllers = [overviewNav, byCountryNav]
    }
}
