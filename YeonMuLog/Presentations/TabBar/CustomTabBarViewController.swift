//
//  CustomTabBarViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit
import SwipeableTabBarController

class CustomTabBarViewController: SwipeableTabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTabBarController()
    }
    
    // MARK: - Helper
    private func setUI() {
        tabBar.tintColor = .CustomColor.purple100
        tabBar.unselectedItemTintColor = .systemGray3
        tabBar.backgroundColor = .white
        
        isCyclingEnabled = false
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
    }

    private func setTabBarController() {
        let mainVC = TaraeViewController()
        let mainRootVC = UINavigationController(rootViewController: mainVC)
        mainRootVC.tabBarItem = UITabBarItem(title: "mainTabName".localized,
                                         image: UIImage(systemName: "ticket"),
                                         selectedImage: UIImage(systemName: "ticket.fill"))
        
        let chartVC = ChartViewController()
        let chartRootVC = UINavigationController(rootViewController: chartVC)
        chartRootVC.tabBarItem = UITabBarItem(title: "chartTabName".localized,
                                              image: UIImage(systemName: "chart.pie"),
                                              selectedImage: UIImage(systemName: "chart.pie.fill"))
        
        let settingVC = SettingViewController()
        let settingRootVC = UINavigationController(rootViewController: settingVC)
        
        settingRootVC.tabBarItem = UITabBarItem(title: "settingTabName".localized,
                                                image: UIImage(systemName: "gearshape.2"),
                                                selectedImage: UIImage(systemName: "gearshape.2.fill"))
        
        setViewControllers([mainRootVC, chartRootVC, settingRootVC], animated: true)
    }
}
