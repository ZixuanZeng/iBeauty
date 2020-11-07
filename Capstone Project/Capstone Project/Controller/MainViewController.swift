//
//  ViewController.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 9/10/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // Label variable for the app name
    @IBOutlet var appName: UILabel!
    
    // Constraint on x axis for the name label for animation
    @IBOutlet weak var nameLabelConstraint: NSLayoutConstraint!
    
    var segueTimer : Timer!
    var timer = Timer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //This is to hide navigation bar in main view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // Place it right on the constrainted position
        nameLabelConstraint.constant -= view.bounds.width
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // animate it from the right to the left
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
            self.nameLabelConstraint.constant += self.view.bounds.width
              self.view.layoutIfNeeded()
        }, completion: nil)
        // Setup timer to show next view controller
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {_ in
            self.showNextViewController()
            self.timer.invalidate()
        }
        
    }
    
    // Setup for jumping to carema view controller
    @objc func showNextViewController() {
        DispatchQueue.main.async () {
            let nextViewController = self.storyboard!.instantiateViewController(identifier: "cameraViewController") as UIViewController
            self.present(nextViewController, animated: true, completion: self.viewDidLoad)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


