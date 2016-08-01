//
//  CustomProfileView.swift
//  NavigationDrawer
//
//  Created by Tran Duc Trong on 7/4/16.
//  Copyright © 2016 Tran Duc Trong. All rights reserved.
//

import UIKit

class CustomProfileView:UIImageView{
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 3.0
        self.contentMode = .ScaleAspectFit
    }
}
