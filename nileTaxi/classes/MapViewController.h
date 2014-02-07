//
//  MapViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManagerAPI.h"
@interface MapViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *mapsArray;
//    NSError *anyError;
    __weak IBOutlet UILabel *stationWaitingNumLabel;
    __weak IBOutlet UILabel *stationLeavingNumbLabel;
    __weak IBOutlet UILabel *stationNameLabel;
    __weak IBOutlet UIView *dialogView;

    __weak IBOutlet UITableView *stationsTableView;
    
    int dialogOriginY;
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
- (IBAction)hideDialogView:(id)sender;

@end
