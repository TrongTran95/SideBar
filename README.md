# SideBar
Custom SideBar (navigation drawer) in Swift 2.

Custom from [this tutorial](https://www.youtube.com/watch?v=qaLiZgUK2T0).

![sidebar](https://cloud.githubusercontent.com/assets/20257815/17294125/f48ab2d8-581e-11e6-9338-11384410e44e.gif)

## HomeViewController.swift ##
-Use *sideBarDidSelectButtonAtIndex* funtion to create handler for every clicked on SideBar item.

-If you want to close SideBar when click on view, create a tap gesture and call *closeSideBarWhenTouchView* function.

-Var sideBar:SideBar.
-Use *sideBar.setUsername(“Text here”)* to set user’s name in SideBar.
-Use *sideBar.setProfileImage(UIImage here)* to set profile image in SideBar.

-Use *menuItems* and *menuImageItems* variable to set title and image for SideBar image

## SideBar.swift or SideBarTableViewController.swift##
-Modify display of SideBar in *setupSideBar* funtion


## CustomProfileView.swift ##
-Modify display of ProfileView in SideBar

