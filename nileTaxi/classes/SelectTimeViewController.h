//
//  SelectTimeViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoViewController.h"
@interface SelectTimeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UITableView *times_return_TabelView;
    __weak IBOutlet UITableView *times_reservation_TabelView;

}
- (IBAction)goNext:(id)sender;

@property (nonatomic,strong) NSMutableDictionary *allData;
@property NSUInteger TripType;

@property bool isRound;
@property (nonatomic,strong)    NSArray* timesArray_reservation;
@property (nonatomic,strong)    NSArray* timesArray_return;

@end
