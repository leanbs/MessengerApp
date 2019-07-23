//
//  ViewController.swift
//  MessengerApp
//
//  Created by Davin on 19/07/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import AsyncDisplayKit

class ViewController: ASTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        self.tabBar.tintColor = UIColor(red:0.01, green:0.67, blue:0.05, alpha:1.0)
        
        viewControllers = [
            createTabItem(viewController: ASViewController(), title: "Chat"),
            createTabItem(viewController: ASViewController(), title: "Contact"),
            createTabItem(viewController: ASViewController(), title: "Discover"),
        ]
    }
    
    
    fileprivate func createTabItem(viewController: UIViewController, title: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.tabBarItem.title = title
        
        return viewController
    }
}
