//
//  ViewController.swift
//  CoreMotionUI
//
//  Created by Zhou Hao on 17/11/14.
//  Copyright (c) 2014年 Zhou Hao. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnLock: UIBarButtonItem!
    
    var expanded : Bool = true
    var locking : Bool = false  // unlocked
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if !self.locking {
            startMotionManager()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {

        stopMotionManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTest(sender: AnyObject) {

        self.locking = !self.locking
        let img = self.locking ? "Lock" : "Unlock"

        let barButton = UIBarButtonItem(image: UIImage(named: img), style: UIBarButtonItemStyle.Plain, target: self, action: "onTest:")
        self.navigationItem.rightBarButtonItem = barButton
        
        if locking {
            stopMotionManager()
        } else {
            startMotionManager()
        }
    }

    func updateUI(shouldExpand : Bool) -> Void {
    
        NSOperationQueue.mainQueue().addOperationWithBlock({
                            
            let dy = shouldExpand ? -self.headerView.bounds.size.height : 0
            self.topMarginConstraint.constant = dy
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }) { (Bool) -> Void in
                    
                    self.expanded = shouldExpand
            }
        })
    }
    
    func startMotionManager() {
        // device motion is combination of gyrometer and accelerameter
        if self.motionManager.deviceMotionAvailable {
            
            self.motionManager.deviceMotionUpdateInterval = 0.05
            let queue = NSOperationQueue()
            self.motionManager.startDeviceMotionUpdatesToQueue(queue, withHandler: { [weak self](data, error) -> Void in
                //println("\(data.gravity.x),\(data.gravity.y),\(data.gravity.z)")
                
                var goingToExpand = false
                var needToAnimate = false
                if abs(data.gravity.y) < 0.2 {
                    
                    goingToExpand = true
                    if self?.expanded != goingToExpand {
                        needToAnimate = true
                    }
                } else if abs(data.gravity.y) > 0.8 {
                    
                    goingToExpand = false
                    if self?.expanded != goingToExpand {
                        
                        needToAnimate = true
                    }
                }
                
                if needToAnimate {
                    self?.updateUI(goingToExpand)
                }
            })
        }
    }
    
    func stopMotionManager() {
        
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell") as SampleCell

        let name = NSString(format: "row%d.png", 3 - indexPath.row % 3)
        cell.sampleImageView.image = UIImage(named: name)
        
        return cell
    }
    
}

