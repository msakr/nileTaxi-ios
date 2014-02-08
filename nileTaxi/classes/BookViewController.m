//
//  BookViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "BookViewController.h"
#import "SWRevealViewController.h"
#import "WebServiceManagerAPI.h"
#import "SelectTimeViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark -views Delegates
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    customPickerView=[[[NSBundle mainBundle] loadNibNamed:@"CustomPicker" owner:self options:nil] objectAtIndex:0];
    customPickerView.callerDelegate=self;
    
    
    CGRect frm=customPickerView.frame;
    frm.origin.y=self.view.frame.size.height+10;
    customPickerView.frame=frm;
        frm.size.width=self.view.frame.size.width;
    
    [self.view addSubview:customPickerView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    selectedDateTrip=[NSDate date];
    selectedDateTripRound=[NSDate date];
    [self performSelectorInBackground:@selector(loadAllStationsAndTimesAndDirectoins) withObject:Nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{


    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
    switch (_TripType) {
        case trip_type_Express:
            [dateFormat setDateFormat:@"yyyy-MM-dd"];

            break;
            
            case trip_type_Oncall:
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        default:
            [dateFormat setDateFormat:@"yyyy-MM-dd"];

            break;
    }
    
    NSString *stringDate = [dateFormat stringFromDate:selectedDate];
//    NSLog(@"stringDate: %@",stringDate);
    
    switch (code) {
        case dateButtonCodeTripIn:
            selectedDateTrip=selectedDate;
            [selectDateOfTripButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];

            break;
            
            case dateButtonCodeRound:
            selectedDateTripRound=selectedDate;
            [roundTripButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];

            break;
        default:
            break;
    }
    
    
    [self enableOrDisablAll:YES];

}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    
    [self enableOrDisablAll:YES];
    
}

-(NSString *)getTitleForRowInArray:(NSArray *)data andRow:(NSInteger)row
{
    return Nil;
}

#pragma mark -getStationsBackground

-(void)loadAllStationsAndTimesAndDirectoins{
//    stationsArray=[[NSMutableArray alloc]initWithObjects:@"ST1",@"ST2", nil];
//    [stationsButton setTitle:[stationsArray objectAtIndex:0] forState:UIControlStateNormal ];
//    
//    
//    
//    timesArray=[[NSMutableArray alloc]initWithObjects:@"T1",@"T2",@"T3", nil];
//    [timesButton setTitle:[timesArray objectAtIndex:0] forState:UIControlStateNormal ];
//    
//    directionArray=[[NSMutableArray alloc]initWithObjects:@"D1",@"D2",@"D3",@"D4", nil];
//    [directionButton setTitle:[directionArray objectAtIndex:0] forState:UIControlStateNormal ];
//
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
    switch (_TripType) {
        case trip_type_Express:
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            break;
            
        case trip_type_Oncall:
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        default:
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            break;
    }
    
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDate = [dateFormat stringFromDate:[NSDate date]];

    [roundTripButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];
    [selectDateOfTripButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];
    
}


#pragma mark -buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{
    
    [selectDateOfTripButton setEnabled:EnOrDisable];
    [roundTripButton setEnabled:EnOrDisable];

    
}

#pragma mark loadService 

-(void)startServiceLoading
{
    NSError *tempError;
    
    
    NSString *reservationDate=[NSString stringWithFormat:@"%i",(int)[selectedDateTrip timeIntervalSince1970]];
    NSString *returnDatee=[NSString stringWithFormat:@"%i",(int)[selectedDateTripRound timeIntervalSince1970]];
    
    //    anyError=tempError;
    NSDictionary *tempDic=[WebServiceManagerAPI getTimesWithFromStationID:[_stationFrom objectForKey:@"station_id"] andToStationID:(roundTripSwitch.isOn?[_stationTo objectForKey:@"station_id"]:nil) andReservation_date:reservationDate andReturn_date:(roundTripSwitch.isOn?returnDatee:nil) WithErrorMessage:&tempError];
    
    
    if (tempDic==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    
    timesDic=tempDic;
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [self performSegueWithIdentifier:@"selectTimes" sender:self];
    
}

#pragma mark -buttons Action



- (IBAction)ChangeroundTrip:(id)sender {

    [roundTripButton setHidden:![(UISwitch *)sender isOn ]];
}

- (IBAction)BookTicket:(id)sender {
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Ticket Will be sent by email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    
    [self performSelectorInBackground:@selector(startServiceLoading) withObject:nil];
  
    
    
}



- (IBAction)selectDate:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    
    switch (_TripType) {
        case trip_type_Express:
            customPickerView.pickerType=type_DatePicker;
            
            break;
            
        case trip_type_Oncall:
            customPickerView.pickerType=type_DatePickerFull;
            
            break;
        default:
            customPickerView.pickerType=type_DatePicker;
            
            break;
    }
    customPickerView.componentCode=dateButtonCodeRound;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
}

- (IBAction)selectTripDateAction:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    
    switch (_TripType) {
        case trip_type_Express:
            customPickerView.pickerType=type_DatePicker;
            
            break;
            
        case trip_type_Oncall:
            customPickerView.pickerType=type_DatePickerFull;

            break;
        default:
            customPickerView.pickerType=type_DatePicker;
            
            break;
    }
    

    customPickerView.componentCode=dateButtonCodeTripIn;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];

    
}

#pragma mark - segeuo preparation 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"selectTimes"]) {
        
        
        NSMutableDictionary *allD=[[NSMutableDictionary alloc]init];
        
        
        NSString *reservationDate=[NSString stringWithFormat:@"%i",(int)[selectedDateTrip timeIntervalSince1970]];
        NSString *returnDatee=[NSString stringWithFormat:@"%i",(int)[selectedDateTripRound timeIntervalSince1970]];
        
        
        [allD setObject:reservationDate forKey:booking_ReservationDate];
        [allD setObject:returnDatee      forKey:booking_ReturnDate];
        
        
        ((SelectTimeViewController *)segue.destinationViewController).timesArray_reservation=[[NSArray alloc]initWithArray:[timesDic objectForKey:@"time"]];
        
        ((SelectTimeViewController *)segue.destinationViewController).TripType=_TripType;

        [allD setObject:_stationFrom forKey:booking_stationFrom];
        [allD setObject:_stationTo forKey:booking_stationTo];
        [allD setObject:[NSNumber numberWithBool:roundTripSwitch.isOn] forKey:booking_isRound];
        
        ((SelectTimeViewController *)segue.destinationViewController).allData=allD;
        

        if (roundTripSwitch.isOn) {
            ((SelectTimeViewController *)segue.destinationViewController).timesArray_return=[[NSArray alloc]initWithArray:[timesDic objectForKey:@"return_time"]];
            ((SelectTimeViewController *)segue.destinationViewController).isRound=YES;
        }else{
            ((SelectTimeViewController *)segue.destinationViewController).timesArray_return=nil;
                        ((SelectTimeViewController *)segue.destinationViewController).isRound=NO;
        }

        
    }
    
    
    
}
@end
