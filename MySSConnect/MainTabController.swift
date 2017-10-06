//
//  MainTabController.swift
//  KizunaAiChanAlarm
//
//  Created by Atsuo Yonehara on 2017/09/19.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SafariServices

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var viewControllers: [UIViewController] = []

        let homeStoryboard = UIStoryboard(name: "Result", bundle: nil)
        let homeViewController = homeStoryboard.instantiateInitialViewController() as! ResultViewController
        homeViewController.isHomeViewController = true
        let navigationControllerHome = UINavigationController(rootViewController: homeViewController)
        navigationControllerHome.tabBarItem.title = "Home"
        navigationControllerHome.tabBarItem.image = UIImage(named: "ic_home")
        viewControllers.append(navigationControllerHome)
        
        let tagStoryboard = UIStoryboard(name: "Tag", bundle: nil)
        let tagViewController = tagStoryboard.instantiateInitialViewController()!
        tagViewController.title = "Tag"
        let navigationControllerTag = UINavigationController(rootViewController: tagViewController)
        viewControllers.append(navigationControllerTag)
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchViewController = searchStoryboard.instantiateInitialViewController()!
        searchViewController.title = "Search"
        let navigationControllerSearch = UINavigationController(rootViewController: searchViewController)
        viewControllers.append(navigationControllerSearch)
        
        let settingStoryboard = UIStoryboard(name: "Setting", bundle: nil)
        let settingViewController = settingStoryboard.instantiateInitialViewController()!
        settingViewController.title = "Setting"
        let navigationControllerSetting = UINavigationController(rootViewController: settingViewController)
        viewControllers.append(navigationControllerSetting)

        self.setViewControllers(viewControllers, animated: false)
        
        // Do any additional setup after loading the view.
    }

    func showWebView() {
        let url = URL(string: "https://www.google.com")!
        let webView = SFSafariViewController(url: url)
        present(webView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
