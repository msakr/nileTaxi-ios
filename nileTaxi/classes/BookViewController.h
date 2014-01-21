//
//  BookViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"

#define stationsButtonCode 1
#define timesButtonCode 2
#define directionButtonCode 3
#define dateButtonCode 4

@interface BookViewController : UIViewController<SelectPickerDelegate>
{
    CustomPicker *customPickerView;

    NSMutableArray *stationsArray;
    NSMutableArray *timesArray;
    NSMutableArray *directionArray;
    
    
    
    __weak IBOutlet UIButton *roundTripButton;
    __weak IBOutlet UIButton *stationsButton;
    
    __weak IBOutlet UIButton *directionButton;
    __weak IBOutlet UIButton *timesButton;
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;

- (IBAction)ChangeroundTrip:(id)sender;
- (IBAction)BookTicket:(id)sender;
- (IBAction)selectStation:(id)sender;
- (IBAction)selectDate:(id)sender;

- (IBAction)selectTime:(id)sender;
- (IBAction)selectDirection:(id)sender;

@end
