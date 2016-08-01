//
//  CustomTableViewCell.swift
//  NavigationDrawer
//
//  Created by Tran Duc Trong on 7/4/16.
//  Copyright © 2016 Tran Duc Trong. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let imgIcon = UIImageView()
    let lblTitle = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Selected View
        let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height))
        selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
        self.selectedBackgroundView = selectedView
        imgIcon.contentMode = .ScaleAspectFit
        
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgIcon)
        contentView.addSubview(lblTitle)
        
        //Autolayout of Icon
        let left = NSLayoutConstraint(item: imgIcon, attribute: .LeadingMargin, relatedBy: .Equal, toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 10)
        let bottom = NSLayoutConstraint(item: imgIcon, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 2)
        let top = NSLayoutConstraint(item: imgIcon, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 2)
        contentView.addConstraints([left, top, bottom])
        
        //Autolayout of Label
        let left1 = NSLayoutConstraint(item: lblTitle, attribute: .LeadingMargin, relatedBy: .Equal, toItem: contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 60)
        let bottom1 = NSLayoutConstraint(item: lblTitle, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 2)
        let top1 = NSLayoutConstraint(item: lblTitle, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 2)
        let right1 = NSLayoutConstraint(item: lblTitle, attribute: .TrailingMargin, relatedBy: .Equal, toItem: contentView, attribute: .TrailingMargin, multiplier: 1.0, constant: 2)
        contentView.addConstraints([left1, right1, top1, bottom1])
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
