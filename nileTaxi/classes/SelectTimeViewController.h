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

    
    NSArray *stations;
    
    
    NSIndexPath *lastSelectedIndexTabel11;
    UITableView *LastTbleTable11;
    
    NSIndexPath *lastSelectedIndexTabel2;
    UITableView *LastTbleTable2;
    
    
    
    CGRect tempRectRservation;
        CGRect tempRectReturn;
    
    CGRect tempRectReservationTabel;

}


- (IBAction)goNext:(id)sender;

@property (nonatomic,strong) NSMutableDictionary *allData;
@property NSUInteger TripType;

@property bool isRound;

@property bool isForStations;


//reservation is for from
//return is for to
@property (nonatomic,strong)    NSArray* timesArray_reservation;
@property (nonatomic,strong)    NSArray* timesArray_return;

@end
