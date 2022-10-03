//
//  CustomTabBarViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTabBarController()
    }
    

    // MARK: - Helper
    private func setUI() {
        tabBar.tintColor = UIColor(red: 199/255, green: 156/255, blue: 255/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = .systemGray3
        tabBar.backgroundColor = .white
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
        
        setViewControllers([mainRootVC, chartRootVC], animated: true)
    }
}
