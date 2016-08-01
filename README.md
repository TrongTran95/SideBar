# SideBar
Custom side bar (navigation drawer) in Swift 2.

[alt tag](https://raw.github.com/TrongTran95/SideBar/master/path/to/SideBar.gif)

## In HomeViewController.swift ##
-Use **sideBarDidSelectButtonAtIndex** funtion to create handler for every clicked on SideBar item

-If you want to close SideBar when click on view, create a tap gesture and call “closeSideBarWhenTouchView” function.

var sideBar:SideBar = SideBar()
-Use sideBar.setUsername(“Text here”) to set user’s name in SideBar
or 
-Use sideBar.setProfileImage(UIImage here) to set profile image in SideBar

-Use “menuItems” and “menuImageItems” to set title and image for SideBar image

## In SideBar.swift or SideBarTableViewController.swift##
-Modify display of SideBar in “setupSideBar” funtion


## In CustomProfileView.swift ##
-Modify display of ProfileView in SideBar

