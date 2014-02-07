//
//  ReviewDataAndTicketsViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewDataAndTicketsViewController : UIViewController
{
    
    __weak IBOutlet UILabel *dataReviewLabel;
    
}

@property NSUInteger TripType;
@property (nonatomic,strong) NSMutableDictionary *alldata;
@end
