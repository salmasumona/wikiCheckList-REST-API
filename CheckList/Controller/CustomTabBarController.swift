//
//  CustomTabController.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller1 = createNavController(title: "Search", imageName: "search.png", controllerName: SearchController())
        let controller2 = createNavController(title: "Bookmark", imageName: "bookmark.png", controllerName: BookMarkController())
        let controller3 = createNavController(title: "App Browser", imageName: "browser.png", controllerName: UIViewController())
        viewControllers = [controller1,controller2,controller3]
    }
    
    func createNavController(title:String, imageName:String, controllerName:UIViewController) -> UINavigationController {
        let vc = controllerName
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName)//?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: -5, right: 20)
        return nav
    }
}
