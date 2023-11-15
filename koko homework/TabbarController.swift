//
//  TabbarController.swift
//  koko homework
//
//  Created by Shane Li on 2023/11/15.
//

import Foundation
import UIKit

class TabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let money = UIViewController()
        money.tabBarItem = UITabBarItem()
        money.tabBarItem.image = .icTabbarProductsOff.withRenderingMode(.alwaysOriginal)
        money.tabBarItem.selectedImage = .icTabbarProductsOff.withRenderingMode(.alwaysOriginal).withTintColor(.hotPink)
        
        let friend = UINavigationController(rootViewController: ViewController())
        friend.tabBarItem = UITabBarItem()
        friend.tabBarItem.image = .icTabbarFriendsOn.withRenderingMode(.alwaysOriginal).withTintColor(.brownGrey)
        friend.tabBarItem.selectedImage = .icTabbarFriendsOn.withRenderingMode(.alwaysOriginal).withTintColor(.hotPink)

        let koko = UIViewController()
        koko.tabBarItem = UITabBarItem()
        koko.tabBarItem.image = .icTabbarHomeOff.withRenderingMode(.alwaysOriginal)

        let manage = UIViewController()
        manage.tabBarItem = UITabBarItem()
        manage.tabBarItem.image = .icTabbarManageOff.withRenderingMode(.alwaysOriginal)
        manage.tabBarItem.selectedImage = .icTabbarManageOff.withRenderingMode(.alwaysOriginal).withTintColor(.hotPink)

        let setting = UIViewController()
        setting.tabBarItem = UITabBarItem()
        setting.tabBarItem.image = .icTabbarSettingOff.withRenderingMode(.alwaysOriginal)
        setting.tabBarItem.selectedImage = .icTabbarSettingOff.withRenderingMode(.alwaysOriginal).withTintColor(.hotPink)

        setViewControllers([
            money,
            friend,
            koko,
            manage,
            setting,
        ], animated: false)
        
        selectedIndex = 1
    }
}

#Preview {
    TabbarController()
}
