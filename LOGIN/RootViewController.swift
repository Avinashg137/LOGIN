//
//  ViewController.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 10/05/21.
//

import UIKit
import SidebarOverlay

class RootViewController: SOContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.menuSide = .left
        self.topViewController = self.storyboard?.instantiateViewController(withIdentifier: "topScreen")
        self.sideViewController = self.storyboard?.instantiateViewController(withIdentifier: "leftScreen")
    }


}

