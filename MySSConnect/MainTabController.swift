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
        
        if RealmBlog.getRealmBlogCount() == 0 {
            RealmBlog.create(name: "realm").put()
        }
        
        let homeStoryboard = UIStoryboard(name: "Result", bundle: nil)
        let homeViewController = homeStoryboard.instantiateInitialViewController() as! ResultViewController
        homeViewController.controllerName = "Home"
        let navigationControllerHome = UINavigationController(rootViewController: homeViewController)
        navigationControllerHome.tabBarItem.title = "home"
        navigationControllerHome.tabBarItem.image = UIImage(named: "ic_home")
        viewControllers.append(navigationControllerHome)
        
        let searchAndTableStoryboard = UIStoryboard(name: "SearchAndTable", bundle: nil)
        let searchAndTableViewController = searchAndTableStoryboard.instantiateInitialViewController()!
        searchAndTableViewController.title = "Tag"
        let navigationControllerSearchAndTable = UINavigationController(rootViewController: searchAndTableViewController)
        navigationControllerSearchAndTable.tabBarItem.title = "tag"
        navigationControllerSearchAndTable.tabBarItem.image = UIImage(named: "ic_label_outline")
        viewControllers.append(navigationControllerSearchAndTable)
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchViewController = searchStoryboard.instantiateInitialViewController()!
        searchViewController.title = "Search"
        let navigationControllerSearch = UINavigationController(rootViewController: searchViewController)
        viewControllers.append(navigationControllerSearch)
        
        let favoriteStoryboard = UIStoryboard(name: "SearchAndTable", bundle: nil)
        let favoriteViewController = favoriteStoryboard.instantiateInitialViewController() as! SearchAndTableViewController
        let navigationControllerFavorite = UINavigationController(rootViewController: favoriteViewController)
        favoriteViewController.title = "Favorite"
        navigationControllerFavorite.tabBarItem.title = "favorite"
        navigationControllerFavorite.tabBarItem.image = UIImage(named: "ic_favorite")
        viewControllers.append(navigationControllerFavorite)
        
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
