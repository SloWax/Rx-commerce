//
//  MainTC.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import UIKit


class MainTC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        let nomalTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.gray
        ]
        let selectedTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 10),
            .foregroundColor: UIColor.black
        ]
        
        tabBarItemAppearance.normal.titleTextAttributes = nomalTitle
        tabBarItemAppearance.selected.titleTextAttributes = selectedTitle
        tabBarItemAppearance.selected.iconColor = .black

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.shadowImage = UIColor.gray.toImage(height: 0.5)
        
        tabBar.standardAppearance = tabBarAppearance
        
        UITabBar.appearance().backgroundColor = UIColor.white
        
        let viewController = [
            TabBarVC(vc: ListVC(), itme: UITabBarItem(
                title: "쇼핑몰",
                image: UIImage(systemName: "bag"),
                selectedImage: UIImage(systemName: "bag.fill")
            )),
            TabBarVC(vc: MyVC(), itme: UITabBarItem(
                title: "내정보",
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            ))
        ]

        viewControllers = viewController.map { $0.navi }
    }
}

fileprivate class TabBarVC {
    
    let vc: UIViewController
    let item: UITabBarItem
    
    init(vc: UIViewController, itme: UITabBarItem) {
        self.vc = vc
        self.item = itme
    }
    
    var navi: BaseNC {
        let navi = BaseNC(rootViewController: vc)
        navi.tabBarItem = item

        return navi
    }
}
