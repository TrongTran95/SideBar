//
//  HomeViewController.swift
//  SideBar
//
//  Created by Tran Duc Trong on 8/1/16.
//  Copyright © 2016 TDT. All rights reserved.
//

import UIKit

var sideBarImage:UIImage = UIImage(named: "SideBar_icon")!
var backImage:UIImage = UIImage(named: "Back_icon")!

class HomeViewController: UIViewController, SideBarDelegate {
    
    var menuItems:[[String]] = []
    
    var menuImageItems:[[UIImage]] = []
    
    var sideBar:SideBar = SideBar()
    
    var btnSideBar:UIButton = UIButton()
    
    let imgvSideBar:UIImageView = UIImageView(image: sideBarImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up left bar button item (SideBar button)
        let rectSideBar = CGRect(x: 0, y: 0, width: 28, height: 20)
        setUpCustomBarButton(barButtonImage: imgvSideBar, barButton: &btnSideBar, barButtonFrame: rectSideBar, action: #selector(HomeViewController.tappedSideBarIcon))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnSideBar)
        
        //Setup SideBar
        //Label
        menuItems = [["A", "B", "C", "D"],["E", "F", "G", "H"]]
        //Image
        menuImageItems = [[sideBarImage, sideBarImage, sideBarImage, sideBarImage],[sideBarImage, sideBarImage, sideBarImage, sideBarImage]]
        
        sideBar = SideBar(sourceView: self.view, menuItems: menuItems, menuImageItems: menuImageItems, barButtonImage: imgvSideBar)
        sideBar.delegate = self
    }
    
    ///Customize bar button on navigation bar
    func setUpCustomBarButton(barButtonImage barButtonImage: UIImageView, inout barButton: UIButton, barButtonFrame: CGRect, action: Selector){
        barButtonImage.contentMode = .Center
        barButton = UIButton(type: .Custom)
        barButton = UIButton(frame: barButtonFrame)
        barButton.addSubview(barButtonImage)
        barButton.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        barButtonImage.center = barButton.center
    }
    
    ///Open/Close SideBar button
    func tappedSideBarIcon(sender: AnyObject) {
        //Rotate button
        imgvSideBar.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
        UIView.animateWithDuration(0.2, animations: {
            self.imgvSideBar.transform = CGAffineTransformIdentity
        }) { (finished) in
            //If SideBar did not open
            if (self.imgvSideBar.image == sideBarImage) {
                self.imgvSideBar.image = backImage
            }
                //If SideBar opened
            else {
                self.imgvSideBar.image = sideBarImage
            }
        }
        //If SideBar did not open
        if (sideBar.isSideBarOpen == false){
            sideBar.showSideBar(true)
            sideBar.delegate?.sideBarWillOpen?()
        }
            //If SideBar opened
        else {
            sideBar.showSideBar(false)
            sideBar.delegate?.sideBarWillClose?()
        }
    }
    
    ///Handler for every click on items
    func sideBarDidSelectButtonAtIndex(section: Int, row: Int) {
        switch menuItems[section][row]{
        case "A":
            //Do something when clicked item "A"
            print("A Clicked")
        case "B":
            //Do something when clicked item "B"
            print("B Clicked")
        default: break
            
        }
    }
    
    ///Handler for closing SideBar when touch view
    func closeSideBarWhenTouchView(){
        //Animation
        imgvSideBar.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
        UIView.animateWithDuration(0.2, animations: {
            self.imgvSideBar.transform = CGAffineTransformIdentity
        }) { (finished) in
            self.imgvSideBar.image = sideBarImage
        }
        //Close SideBar
        sideBar.showSideBar(false)
        sideBar.delegate?.sideBarWillClose?()
    }
}