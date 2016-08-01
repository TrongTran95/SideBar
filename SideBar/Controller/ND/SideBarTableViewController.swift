//
//  SlideBarTableViewController.swift
//  NavigationDrawer
//
//  Created by Tran Duc Trong on 7/3/16.
//  Copyright © 2016 Tran Duc Trong. All rights reserved.
//

import UIKit

//Determine when user touch up inside item of SideBar
protocol SideBarTableViewControllerDelegate{
    func sideBarControlDidSelectRow(indexPath:NSIndexPath)
}


class SideBarTableViewController: UITableViewController {
    
    var delegate:SideBarTableViewControllerDelegate?
    
    //Data received from HomeViewController
    var tableData:[[String]] = []
    var tableImageData:[[UIImage]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init() {
        self.init(style: .Grouped)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableData.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? CustomTableViewCell
        
        //First time, not have any cell. Create it
        if (cell == nil){
            cell = CustomTableViewCell(style: .Default, reuseIdentifier: "Cell")
            cell?.backgroundColor = UIColor.clearColor()
            cell?.lblTitle.textColor = UIColor.whiteColor()
            cell?.lblTitle.highlightedTextColor = UIColor(red: 70, green: 203, blue: 224, alpha: 1)
        }
        //Image and text of SideBar item
        cell?.imgIcon.image = tableImageData[indexPath.section][indexPath.row]
        cell?.lblTitle.text = tableData[indexPath.section][indexPath.row]

        return cell!
    }
    
    //In header of every section will have a white separator
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.clearColor()
        let whiteSeparator:UIView = UIView()
        whiteSeparator.backgroundColor = UIColor.whiteColor()
        whiteSeparator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whiteSeparator)
        
        let left = NSLayoutConstraint(item: whiteSeparator, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 15)
        let right = NSLayoutConstraint(item: whiteSeparator, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: whiteSeparator, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        let height = NSLayoutConstraint(item: whiteSeparator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1)
        view.addConstraints([left, right, top, height])
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sideBarControlDidSelectRow(indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }

}
