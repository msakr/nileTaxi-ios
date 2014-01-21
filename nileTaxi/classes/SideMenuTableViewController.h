//
//  SideMenuTableViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "nilecodeAppDelegate.h"
@interface SideMenuTableViewController : UITableViewController
{
    nilecodeAppDelegate   *appDelegate;
}
@property (nonatomic, strong) NSArray *menuItems;
@end
