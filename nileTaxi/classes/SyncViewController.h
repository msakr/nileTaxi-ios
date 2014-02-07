//
//  SyncViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"

#define stationsCode 1


@interface SyncViewController : UIViewController<SelectPickerDelegate>
{
    CustomPicker *customPickerView;
    NSMutableArray *stationsArray;
    
//    NSError *anyError;
    
    NSDictionary *selectedStationObject;
    
//    NSMutableArray *TimesArray;
//    NSMutableArray *directionArray;


    
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *stationsButton;
- (IBAction)stationButtonAction:(id)sender;
- (IBAction)startSyncAction:(id)sender;

@end
