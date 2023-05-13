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
                    return "Shelf"
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
        
        setViewControllers(dataSource.compactMap {
            switch $0 {
            case .main:
                let storyboard = UIStoryboard(name: "BooksViewController", bundle: nil)
                guard let booksListViewController = storyboard.instantiateViewController(withIdentifier: "BooksListViewController") as? BooksListViewController else { return nil }
                booksListViewController.viewModel = BooksViewModel()
                booksListViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 1)
                return self.wrappedInNavigationController(with: booksListViewController)
                
            case .shelf:
                let storyboard = UIStoryboard(name: "MyShelf", bundle: nil)
                guard let myShelfViewController = storyboard.instantiateViewController(withIdentifier: "myShelfViewController") as? MyShelfViewController else { return nil }
                myShelfViewController.viewModel = MyShelfViewModel()
                myShelfViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 1)
                return self.wrappedInNavigationController(with: myShelfViewController)
                
            case .profile:
                let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                guard let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController") as? ProfileViewController else { return nil }
                profileViewController.viewModel = ProfileViewModel()
                profileViewController.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.iconName), tag: 2)
                return self.wrappedInNavigationController(with: profileViewController)
            }
        }, animated: false)
        
        if #available(iOS 15, *) { tabBar.scrollEdgeAppearance = tabBar.standardAppearance }
    }
    
    private func wrappedInNavigationController(with: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
        guard let _ = (scene as? UIWindowScene) else { return }
            
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
                   
            appearance.backgroundColor = UIColor.clear
            appearance.shadowImage = nil
            appearance.shadowColor = nil

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}
