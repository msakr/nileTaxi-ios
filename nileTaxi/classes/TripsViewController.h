//
//  TripsViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/7/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#define dateButtonCode 1

@interface TripsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SelectPickerDelegate>
{
    
    CustomPicker *customPickerView;

    __weak IBOutlet UIButton *dateButton;
    __weak IBOutlet UITableView *myTripsTable;
    
    
    NSDate *selectedTripDate;
    
    NSDictionary *selectedTrip;
    
    NSMutableArray *tripsArray;
}


- (IBAction)showDateButton:(id)sender;

@end
