//
//  UserInfoViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"

#define TicketsGo 1
//#define TicketsReturn 2

@interface UserInfoViewController : UIViewController<SelectPickerDelegate>
{


    NSNumber *selectedNumberOfTickets;
    
    NSMutableArray *TicketsNumberArrayGO;
    
    
    CustomPicker *customPickerView;

    
    __weak IBOutlet UIButton *goTicketNumberButton;

    __weak IBOutlet UITextField *nameTextField;
    
    __weak IBOutlet UITextField *emailTextField;
    
    __weak IBOutlet UITextField *mobileTextField;
}
- (IBAction)nextAction:(id)sender;
- (IBAction)selectTicketNumber:(id)sender;

@property (nonatomic,strong) NSMutableDictionary *allData;
@property NSUInteger TripType;
@end
