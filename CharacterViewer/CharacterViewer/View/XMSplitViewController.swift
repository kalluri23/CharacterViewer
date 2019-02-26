//
//  XMSplitViewController.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

class XMSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {//Configure nav bar of master and detail before they appear on screen
        if let masterNavVC = self.viewControllers.first as? UINavigationController, let detailNavVc = self.viewControllers.last as? UINavigationController {
            masterNavVC.navigationBar.topItem?.title = Bundle.getAppName()
            if let masterVc = masterNavVC.topViewController as? XMCharcatersMasterViewController, let detailVc = detailNavVc.topViewController as? XMCharacterDetailViewController{
                if !UIDevice.isIphone() {
                    masterVc.navigationItem.rightBarButtonItems = nil
                }
                masterVc.delegate = detailVc //set character selection delegate to detailVC
                detailVc.navigationItem.leftItemsSupplementBackButton = true
                detailVc.navigationItem.leftBarButtonItem = self.displayModeButtonItem

            }
        }
    }

}

extension XMSplitViewController: UISplitViewControllerDelegate { //Display master screen first on iPhones
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
