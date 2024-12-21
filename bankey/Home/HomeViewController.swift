//
//  HomeViewController.swift
//  bankey
//
//  Created by Emmanuel Biju on 27/11/24.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneytransferVC = MoneyTransferViewController()
        let moreOptionsVC = MoreOptionsViewController()

        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneytransferVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Transfer")
        moreOptionsVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyTransferNC = UINavigationController(rootViewController: moneytransferVC)
        let moreOptionsNC = UINavigationController(rootViewController: moreOptionsVC)

        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyTransferNC, moreOptionsNC]

        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

