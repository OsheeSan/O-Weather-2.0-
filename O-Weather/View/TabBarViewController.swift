//
//  TabBarViewController.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.clipsToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.alpha = 0.9
    }
    

    

}
