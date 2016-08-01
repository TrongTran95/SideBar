//
//  SideBar.swift
//  NavigationDrawer
//
//  Created by Tran Duc Trong on 7/3/16.
//  Copyright © 2016 Tran Duc Trong. All rights reserved.
//

import UIKit

//Use @objc because of "obtional func" of objective-C
@objc protocol SideBarDelegate{
    ///Determine index clicked of Sidebar item
    func sideBarDidSelectButtonAtIndex(section: Int, row: Int)
    
    ///Determine when close SideBar
    @objc optional func sideBarWillClose()
    
    ///Determine when open SideBar
    @objc optional func sideBarWillOpen()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate {
    
    ///SideBar width
    var barWidth:CGFloat!
    
    ///TableViewController
    let sideBarContainerView:UIView = UIView()
    var sideBarTableViewController:SideBarTableViewController = SideBarTableViewController()
    
    /// Home view
    var originView:UIView = UIView()
    
    ///Animation of SideBar
    var animator:UIDynamicAnimator!
    
    var delegate:SideBarDelegate?
    
    ///Xác định khi SideBar đóng hay mở
    var isSideBarOpen:Bool = false
    
    //Variable for avatar area
    var profileView = UIView()
    var avatar = CustomProfileView()
    var lblName = UILabel()
    
    var sideBarImageView: UIImageView!
    
    override init(){
        super.init()
    }
    
    ///Initialize SideBar
    init(sourceView:UIView, menuItems: [[String]], menuImageItems: [[UIImage]], barButtonImage: UIImageView){
        super.init()
        //Assign and use parameter from HomeViewController
        originView = sourceView
        sideBarImageView = barButtonImage
        barWidth = originView.frame.size.width*2/3
        sideBarTableViewController.tableData = menuItems
        sideBarTableViewController.tableImageData = menuImageItems
        
        //Use those parameter to create SideBar
        setupSideBar()
        
        //Create animation, referenceView is where animation happen
        animator = UIDynamicAnimator(referenceView: originView)
        
        ///Swipe gesture to turn on SideBar
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        //Swipe left to right
        showGestureRecognizer.direction = .Right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        ///Swipe gesture to turn off SideBar
        let hideGestureBySwipeRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        //Swipe right to left
        hideGestureBySwipeRecognizer.direction = .Left
        originView.addGestureRecognizer(hideGestureBySwipeRecognizer)
    }
    
    ///Swipe screen handler
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        //Turn on SideBar when right swipe
        if (recognizer.direction == .Right){
            if isSideBarOpen == false{
                sideBarImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
                UIView.animateWithDuration(0.2, animations: {
                    self.sideBarImageView.transform = CGAffineTransformIdentity
                }) { (finished) in
                    self.sideBarImageView.image = backImage
                }
                showSideBar(true)
                delegate?.sideBarWillOpen?()
            }
        }
        //Turn off SideBar when left swipe
        else if (recognizer.direction == .Left){
            if isSideBarOpen == true{
                sideBarImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
                UIView.animateWithDuration(0.2, animations: {
                    self.sideBarImageView.transform = CGAffineTransformIdentity
                }) { (finished) in
                    self.sideBarImageView.image = sideBarImage
                }
                showSideBar(false)
                delegate?.sideBarWillClose?()
            }
        }
    }
    
    ///Animation of SideBar
    func showSideBar(shouldOpen: Bool){
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX:CGFloat = shouldOpen ? 0.5 : -0.5
        let magnitude:CGFloat = shouldOpen ? 20 : -21
        let boundaryX:CGFloat = shouldOpen ? barWidth : -barWidth - 1
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVector(dx: gravityX, dy: 0)
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundaryWithIdentifier("sideBoundary", fromPoint: CGPoint(x: boundaryX, y: 20), toPoint: CGPoint(x: boundaryX, y: originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: .Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
    }
    
    ///Set username text
    func setUsername(str: String){
        lblName.text = str
    }
    
    ///Set user's profile image
    func setProfileImage(img:UIImage){
        avatar.image = img
    }
    
    func sideBarControlDidSelectRow(indexPath: NSIndexPath) {
        //this indexPath is SideBarTableViewController's indexPath whenever user click on item
        delegate?.sideBarDidSelectButtonAtIndex(indexPath.section, row: indexPath.row)
    }
    
    ///Create SideBar programmatically
    func setupSideBar(){
        //Create sideBarContainer view
        sideBarContainerView.frame = CGRect(x:-barWidth - 1, y: 64, width: barWidth, height: originView.frame.size.height - 64)
        sideBarContainerView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        originView.addSubview(sideBarContainerView)
        
        //------------------------------------------------------------
        
        //Avatar view (Image + Username)
        profileView.backgroundColor = UIColor.clearColor()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        sideBarContainerView.addSubview(profileView)
        
        let left = NSLayoutConstraint(item: profileView, attribute: .Leading, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Leading, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint(item: profileView, attribute: .Trailing, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: profileView, attribute: .Top, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Top, multiplier: 1.0, constant: 15)
        sideBarContainerView.addConstraints([left, top, right])
        
        //Image
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage(named: "Yoshi")
        profileView.addSubview(avatar)
        
        let centerX5 = NSLayoutConstraint(item: avatar, attribute: .CenterX, relatedBy: .Equal, toItem: profileView, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let top5 = NSLayoutConstraint(item: avatar, attribute: .Top, relatedBy: .Equal, toItem: profileView, attribute: .Top, multiplier: 1.0, constant: 0)
        let width5 = NSLayoutConstraint(item: avatar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: barWidth/2)
        let height5 = NSLayoutConstraint(item: avatar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: barWidth/2)
        profileView.addConstraints([centerX5, top5, width5, height5])
        
        //Username
        lblName.textAlignment = .Center
        lblName.text = "Guest"
        lblName.textColor = UIColor.whiteColor()
        lblName.font = lblName.font.fontWithSize(13)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(lblName)
        
        let left2 = NSLayoutConstraint(item: lblName, attribute: .Leading, relatedBy: .Equal, toItem: profileView, attribute: .Leading, multiplier: 1.0, constant: 0)
        let right2 = NSLayoutConstraint(item: lblName, attribute: .Trailing, relatedBy: .Equal, toItem: profileView, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let top2 = NSLayoutConstraint(item: lblName, attribute: .Top, relatedBy: .Equal, toItem: avatar, attribute: .Bottom, multiplier: 1.0, constant: 15)
        let bottom2 = NSLayoutConstraint(item: lblName, attribute: .Bottom, relatedBy: .Equal, toItem: profileView, attribute: .Bottom, multiplier: 1.0, constant: -15)
        profileView.addConstraints([left2, right2, top2, bottom2])
        
        //------------------------------------------------------------
        
        //Create view contain UITableViewController inside
        let tableViewContainer:UIView = UIView()
        //Background color of this view
        tableViewContainer.backgroundColor = UIColor.clearColor()
        //Don't let tableview contentsize height over this view
        tableViewContainer.clipsToBounds = true
        
        //Autolayout for tableViewContainer
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        sideBarContainerView.addSubview(tableViewContainer)
        
        let left6 = NSLayoutConstraint(item: tableViewContainer, attribute: .Leading, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Leading, multiplier: 1.0, constant: 0)
        let right6 = NSLayoutConstraint(item: tableViewContainer, attribute: .Trailing, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let top6 = NSLayoutConstraint(item: tableViewContainer, attribute: .Top, relatedBy: .Equal, toItem: profileView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let bottom6 = NSLayoutConstraint(item: tableViewContainer, attribute: .Bottom, relatedBy: .Equal, toItem: sideBarContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        sideBarContainerView.addConstraints([left6, right6, top6, bottom6])
        
        //Custom attribute for tableviewcontroller
        sideBarTableViewController.delegate = self
        //Turn off separator of tableView
        sideBarTableViewController.tableView.separatorStyle = .None
        //Background color of SideBarTableView
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        //Turn off handler back to top when click on status bar
        sideBarTableViewController.tableView.scrollsToTop = false
        //Load data when received data from HomeViewController
        sideBarTableViewController.tableView.reloadData()
        
        //Autolayout for tableviewcontroller
        sideBarTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.addSubview(sideBarTableViewController.tableView)
        let left3 = NSLayoutConstraint(item: sideBarTableViewController.tableView, attribute: .Leading, relatedBy: .Equal, toItem: tableViewContainer, attribute: .Leading, multiplier: 1.0, constant: 0)
        let right3 = NSLayoutConstraint(item: sideBarTableViewController.tableView, attribute: .Trailing, relatedBy: .Equal, toItem: tableViewContainer, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let top3 = NSLayoutConstraint(item: sideBarTableViewController.tableView, attribute: .Top, relatedBy: .Equal, toItem: tableViewContainer, attribute: .Top, multiplier: 1.0, constant: 0)
        let bottom3 = NSLayoutConstraint(item: sideBarTableViewController.tableView, attribute: .Bottom, relatedBy: .Equal, toItem: tableViewContainer, attribute: .Bottom, multiplier: 1.0, constant: 0)
        tableViewContainer.addConstraints([left3, right3, top3, bottom3])
    }
}
