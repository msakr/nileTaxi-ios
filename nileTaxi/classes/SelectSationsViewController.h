//
//  SelectSationsViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/29/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectSationsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    

    
    
    NSUInteger stationFromIndex;
    
    NSUInteger stationToIndex;
    
    NSArray *stationsArray;
    
    __weak IBOutlet UITableView *stationTableview;
}

@property (nonatomic,weak) NSDictionary *fromStation;
@property (nonatomic,weak) NSDictionary *toStation;
@property NSUInteger TripType;

@property (nonatomic) NSInteger ScreenID;
@end
