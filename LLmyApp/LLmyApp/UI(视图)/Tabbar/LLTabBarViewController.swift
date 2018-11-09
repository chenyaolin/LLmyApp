//
//  LLTabBarViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/8.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

class LLTabBarViewController: UITabBarController {
    
    // 单例
    @objc static let `shareTabBarVC` = LLTabBarViewController()
    @objc let customTabBar = LLCustomTabBar.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadViewControllers()
        self.setupCustomTabBar()
        let tabBarLine = UITabBar.appearance()
        tabBarLine.shadowImage = UIImage()
        tabBarLine.backgroundImage = UIImage()
    }
    
    func loadViewControllers() {
        
        // 首页
        let mainVc = self.addChildViewController(title: "", imageIcon: #imageLiteral(resourceName: "主页默认"), selectImaIcon: #imageLiteral(resourceName: "主页"), sbName: "LLMainUI")
        
        // 自诊
        let selfDiagnosisVc = self.addChildViewController(title: "", imageIcon: #imageLiteral(resourceName: "自诊默认"), selectImaIcon: #imageLiteral(resourceName: "自诊"), sbName: "LLMainUI")
        
        // 社区
        let communityVc = self.addChildViewController(title: "社区", imageIcon: #imageLiteral(resourceName: "社区默认"), selectImaIcon: #imageLiteral(resourceName: "社区"), sbName: "LLMainUI")
        //        let communityVc = self.addChildViewController(title: "圈子", imageIcon: #imageLiteral(resourceName: "社区默认"), selectImaIcon: #imageLiteral(resourceName: "社区"), sbName: "CircleUI")
        
        // 资讯
        let informationVc = self.addChildViewController(title: "", imageIcon: #imageLiteral(resourceName: "资讯默认"), selectImaIcon: #imageLiteral(resourceName: "资讯"), sbName: "LLMainUI")
        //        let informationVc = self.addChildViewController(title: "资讯", imageIcon: #imageLiteral(resourceName: "资讯默认"), selectImaIcon: #imageLiteral(resourceName: "资讯"), sbName: "CommunityUI")
        
        // 个人中心
        let meVc = self.addChildViewController(title: "", imageIcon: #imageLiteral(resourceName: "我的默认"), selectImaIcon: #imageLiteral(resourceName: "我的"), sbName: "LLMainUI")
        
        self.viewControllers = [mainVc, selfDiagnosisVc, communityVc, informationVc, meVc]
        
    }
    
    func addChildViewController(title: String, imageIcon: UIImage, selectImaIcon: UIImage, sbName: String) -> UINavigationController {
        
        let sb = UIStoryboard(name: sbName, bundle: nil)
        var vc = UIViewController()
//        if title == "资讯" || title == "圈子" {
//            vc = StoryboardHelper.getViewControllerFromStoryBoard(byName: sbName, andIdentify: sbName)
//        } else {
            vc = sb.instantiateInitialViewController() ?? UIViewController()
//        }
        
        vc.title = title
        vc.tabBarItem.image = imageIcon
        vc.tabBarItem.selectedImage = selectImaIcon.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: LLdefaultGreenColor], for: UIControlState.selected)
        
//        if title == "资讯" || title == "圈子" {
//            return vc as? UINavigationController ?? UINavigationController()
//        } else {
            let nav = BaseNavigationController(rootViewController: vc)
            return nav
//        }
        
    }
    
    private func setupCustomTabBar() {
        customTabBar.delegate = self
        customTabBar.frame = self.tabBar.bounds
        self.tabBar.addSubview(customTabBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
//            CRPublicData.share().safeAreaInsetsTop = Float(self.view.safeAreaInsets.top)
//            CRPublicData.share().safeAreaInsetsBottom = Float(self.view.safeAreaInsets.bottom)
//            kAppSafeTop = CGFloat(CRPublicData.share().safeAreaInsetsTop)
//            kAppSafeBottom = CGFloat(CRPublicData.share().safeAreaInsetsBottom)
//        } else {
//            CRPublicData.share().safeAreaInsetsTop = 20
//            CRPublicData.share().safeAreaInsetsBottom = 0
//            kAppSafeTop = CGFloat(CRPublicData.share().safeAreaInsetsTop)
//            kAppSafeBottom = CGFloat(CRPublicData.share().safeAreaInsetsBottom)
        }
    }
    
}

extension LLTabBarViewController: CustomTabBarDelegate {
    func customBarButton(from: Int?, to: TabBarType) {
        self.selectedIndex = to.rawValue
    }
}
