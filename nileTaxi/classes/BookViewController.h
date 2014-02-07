//
//  BookViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"



#define dateButtonCodeTripIn 1
#define dateButtonCodeRound 2


@interface BookViewController : UIViewController<SelectPickerDelegate>
{
    CustomPicker *customPickerView;

    
    NSDictionary *timesDic;

    NSDate *selectedDateTrip;
    NSDate *selectedDateTripRound;
    
    __weak IBOutlet UISwitch *roundTripSwitch;
    
    __weak IBOutlet UIButton *selectDateOfTripButton;
    
    __weak IBOutlet UIButton *roundTripButton;

    
    
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
@property  bool isOnCall;

@property (weak,nonatomic ) NSDictionary *stationFrom;
@property (weak,nonatomic ) NSDictionary *stationTo;

@property NSUInteger TripType;

- (IBAction)ChangeroundTrip:(id)sender;
- (IBAction)BookTicket:(id)sender;
- (IBAction)selectDate:(id)sender;
- (IBAction)selectTripDateAction:(id)sender;


@end
