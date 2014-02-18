//
//  ReviewDataAndTicketsViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "ReviewDataAndTicketsViewController.h"
#import "WebServiceManagerAPI.h"
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
                 [_alldata objectForKey:booking_price],
                 [_alldata objectForKey:booking_mobileNumber],[_alldata objectForKey:booking_name],[_alldata objectForKey:booking_email],[_alldata objectForKey:booking_numberOfTickets]
                 
                 ];
    }else if(_TripType==trip_type_Express){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        
        NSString *ReservtionDate=   [dateFormat stringFromDate:    [NSDate dateWithTimeIntervalSince1970:[[_alldata objectForKey:booking_ReservationDate] doubleValue]]];
        NSString *returnDateDate=    [dateFormat stringFromDate:    [NSDate dateWithTimeIntervalSince1970:[[_alldata objectForKey:booking_ReturnDate] doubleValue]]];
        
        

    allTExt=[NSString stringWithFormat:@"From :%@ \nTo :%@ \nDate :%@ \nTime :%@ \nReturn Date :%@ \nReturnTime :%@ \nPrice :%@ \n\nMobile:%@ \nName :%@ \nE-mail :%@ \nPassengers :%@ \n",
                       [[_alldata objectForKey:booking_stationFrom]objectForKey:@"station_name"],[[_alldata objectForKey:booking_stationTo]objectForKey:@"station_name"],ReservtionDate,[[_alldata objectForKey:booking_reservationTime]objectForKey:@"time"],
                       returnDateDate,[[_alldata objectForKey:booking_returnTime]objectForKey:@"time"],[_alldata objectForKey:booking_price],
                       [_alldata objectForKey:booking_mobileNumber],[_alldata objectForKey:booking_name],[_alldata objectForKey:booking_email],[_alldata objectForKey:booking_numberOfTickets]
                       
                       ];
    }else if(_TripType==trip_type_Oncall){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy hh:mm a"];
        
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

- (IBAction)bookAction:(id)sender {
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self performSelectorInBackground:@selector(startServiceBook) withObject:Nil];
    
    
}
#pragma mark -service preperation

-(void)startServiceBook
{
    
    
    //    NSDictionary*dd=_allData;
    NSError *tempError;
    
    
    NSString *stationFromID=[[_alldata objectForKey:booking_stationFrom] objectForKey:@"station_id"];
    NSString *stationToID=[[_alldata objectForKey:booking_stationTo] objectForKey:@"station_id"];
    NSString *Type=(((NSNumber*)[_alldata objectForKey:booking_isRound]).boolValue?@"2":@"1");
    NSString *numberOfTickets=[NSString stringWithFormat:@"%@",(NSNumber*)[_alldata objectForKey:booking_numberOfTickets]];
    
    
    
    NSString *resrvationDatee=[_alldata objectForKey:booking_ReservationDate];
//    NSString *returnDatee=[_alldata objectForKey:booking_ReturnDate];
    
    NSDictionary *tempArr;
   
    if (_TripType==trip_type_Express) {
        NSString *fromTimeID=[[_alldata objectForKey:booking_reservationTime] objectForKey:@"code"];
        NSString *toTimeID=[[_alldata objectForKey:booking_returnTime] objectForKey:@"code"];

        tempArr =[WebServiceManagerAPI bookExpressTicketWithReservation_method:[NSString stringWithFormat:@"%i",_TripType] andNumber_of_tickets:numberOfTickets andReservation_date:resrvationDatee andMobile:[_alldata objectForKey:booking_mobileNumber] andName:[_alldata objectForKey:booking_name] andEmail:[_alldata objectForKey:booking_email] andFromStationId:stationFromID andToStationId:stationToID andReservationTimeID:fromTimeID andReturnTimeId:toTimeID andTicketType: Type WithErrorMessage:&tempError];
        

    }else if(_TripType==trip_type_Oncall) {
        
        tempArr =[WebServiceManagerAPI bookOnCallTicketWithReservation_method:[NSString stringWithFormat:@"%i",_TripType] andNumber_of_tickets:numberOfTickets andReservation_date:resrvationDatee andMobile:[_alldata objectForKey:booking_mobileNumber] andName:[_alldata objectForKey:booking_name] andEmail:[_alldata objectForKey:booking_email] andFromStationId:stationFromID andToStationId:stationToID  andTicketType: Type WithErrorMessage:&tempError];
        
        
    }else  if(_TripType==trip_type_Trips) {
        
//        tempArr =[WebServiceManagerAPI bookOnCallTicketWithReservation_method:[NSString stringWithFormat:@"%i",_TripType] andNumber_of_tickets:numberOfTickets andReservation_date:resrvationDatee andMobile:[_alldata objectForKey:booking_mobileNumber] andName:[_alldata objectForKey:booking_name] andEmail:[_alldata objectForKey:booking_email] andFromStationId:stationFromID andToStationId:stationToID  andTicketType: Type WithErrorMessage:&tempError];
//        
        
    }
    
    
    if (tempArr==nil || tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"success" message:@"the ticket has been booked successfully " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertNO show];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    [self.navigationController popToRootViewControllerAnimated:NO];
    
   
}


@end
