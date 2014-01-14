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
#define timesCode 2
#define directionCode 3


@interface SyncViewController : UIViewController<SelectPickerDelegate>
{
    CustomPicker *customPickerView;
    NSMutableArray *stationsArray;
    NSMutableArray *TimesArray;
    NSMutableArray *directionArray;


    
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *stationsButton;
- (IBAction)stationButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
- (IBAction)timeButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *directionButton;
- (IBAction)directionButtonAction:(id)sender;

@end
