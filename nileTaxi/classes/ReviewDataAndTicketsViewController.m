//
//  ReviewDataAndTicketsViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "ReviewDataAndTicketsViewController.h"

@interface ReviewDataAndTicketsViewController ()

@end

@implementation ReviewDataAndTicketsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    NSString *allTExt=@"";

    
    if (_TripType==trip_type_Trips) {
        allTExt=[NSString stringWithFormat:@"From :%@ \nTo :%@ \nDate :%@ \nTime :%@ \nPrice :%@ \n\nMobile:%@ \nName :%@ \nE-mail :%@ \nPassengers :%@ \n",
                 [[_alldata objectForKey:booking_trips]objectForKey:@"trip_from_station"],[[_alldata objectForKey:booking_trips] objectForKey:@"trip_to_station"],
                 
                 [[_alldata objectForKey:booking_trips]objectForKey:@"trip_date"],[[_alldata objectForKey:booking_trips]objectForKey:@"trip_time"],
                 @"11 $",
                 [_alldata objectForKey:booking_mobileNumber],[_alldata objectForKey:booking_name],[_alldata objectForKey:booking_email],[_alldata objectForKey:booking_numberOfTickets]
                 
                 ];
    }else{
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        
        NSString *ReservtionDate=   [dateFormat stringFromDate:    [NSDate dateWithTimeIntervalSince1970:[[_alldata objectForKey:booking_ReservationDate] doubleValue]]];
        NSString *returnDateDate=    [dateFormat stringFromDate:    [NSDate dateWithTimeIntervalSince1970:[[_alldata objectForKey:booking_ReturnDate] doubleValue]]];
        
        

    allTExt=[NSString stringWithFormat:@"From :%@ \nTo :%@ \nDate :%@ \nTime :%@ \nReturn Date :%@ \nReturnTime :%@ \nPrice :%@ \n\nMobile:%@ \nName :%@ \nE-mail :%@ \nPassengers :%@ \n",
                       [[_alldata objectForKey:booking_stationFrom]objectForKey:@"station_name"],[[_alldata objectForKey:booking_stationTo]objectForKey:@"station_name"],ReservtionDate,[[_alldata objectForKey:booking_reservationTime]objectForKey:@"time"],
                       returnDateDate,[[_alldata objectForKey:booking_returnTime]objectForKey:@"time"],[_alldata objectForKey:booking_price],
                       [_alldata objectForKey:booking_mobileNumber],[_alldata objectForKey:booking_name],[_alldata objectForKey:booking_email],[_alldata objectForKey:booking_numberOfTickets]
                       
                       ];
    }
    
    [dataReviewLabel setText:allTExt];
    
}

@end
