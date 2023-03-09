//
//  ViewController.swift
//  BIA-Books
//
//  Created by Dmitry Apenko on 07.03.2023.
//

import UIKit

class TabBarController: UITabBarController {
    private enum TabBarItem: Int {
        case main
        case shelf
        case profile
        
        var title: String {
            switch self {
                case .main:
                    return "Главная"
                case .shelf:
                    return "Моя полка"
                case .profile:
                    return "Профиль"
            }
        }
        var iconName: String {
            switch self {
                case .main:
                    return "Book_Open"
                case .shelf:
                    return "Shelve"
                case .profile:
                    return "UserCircle"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.main, .shelf, .profile]
        
        setViewControllers(dataSource.map {
            switch $0 {
            case .main:
                let mainViewController = UIViewController()
                mainViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 0)
                return self.wrappedInNavigationController(with: mainViewController)
            case .shelf:
                let shelfViewController = UIViewController()
                shelfViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 1)
                return self.wrappedInNavigationController(with: shelfViewController)
            case .profile:
//                let profileViewController = ProfileViewController()
////                return self.wrappedInNavigationController(with: profileViewController)
//                return profileViewController
                let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController")
                profileViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 2)
                return profileViewController
            }
        }, animated: false)
        
        if #available(iOS 15, *) { tabBar.scrollEdgeAppearance = tabBar.standardAppearance }
    }
    
    private func wrappedInNavigationController(with: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
}
