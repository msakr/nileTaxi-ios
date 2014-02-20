//
//  UserInfoViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ReviewDataAndTicketsViewController.h"
#import "WebServiceManagerAPI.h"
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    TicketsNumberArrayGO=[[NSMutableArray alloc]init];

    
    selectedNumberOfTickets=@-1;
    [goTicketNumberButton setTitle:@"Number Of Tickets" forState:UIControlStateNormal];
    
    if (_TripType==trip_type_Trips) {
        
        int maxNumber=    ((NSNumber*)[[_allData objectForKey:booking_trips]objectForKey:@"remain_number_of_tickets"]).intValue/*modify Add*/+1;
        
        
        for (int i=1; i<=maxNumber; i++) {
            
            [TicketsNumberArrayGO addObject:[NSNumber numberWithInt:i]];
            
        }
    }else if(_TripType==trip_type_Express){
    NSNumber *numberOfticketsGO=[[_allData objectForKey:booking_reservationTime ] objectForKey:@"remining_quota"];
    
        NSNumber *numberOfticketsReturn=(((NSNumber*)[_allData objectForKey:booking_isRound]).boolValue?[[_allData objectForKey:booking_returnTime ] objectForKey:@"remining_quota"]:numberOfticketsGO);

            TicketsNumberArrayGO=[[NSMutableArray alloc]init];

    
    long maxNumber=    (numberOfticketsGO.intValue<numberOfticketsReturn.longValue ? numberOfticketsGO.longValue:numberOfticketsReturn.longValue);
    
    
    for (int i=1; i<=maxNumber; i++) {

        [TicketsNumberArrayGO addObject:[NSNumber numberWithInt:i]];
        
    }
    }else if(_TripType==trip_type_Oncall){
//        NSNumber *numberOfticketsGO=[NSNumber numberWithInt:10000];
        
//        NSNumber *numberOfticketsReturn=(((NSNumber*)[_allData objectForKey:booking_isRound]).boolValue?[[_allData objectForKey:booking_returnTime ] objectForKey:@"remining_quota"]:numberOfticketsGO);
        
        TicketsNumberArrayGO=[[NSMutableArray alloc]init];
        
        
        long maxNumber=    10000;
        
        
        for (int i=5; i<=maxNumber; i++) {
            
            [TicketsNumberArrayGO addObject:[NSNumber numberWithInt:i]];
            
        }
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    customPickerView=[[[NSBundle mainBundle] loadNibNamed:@"CustomPicker" owner:self options:nil] objectAtIndex:0];
    customPickerView.callerDelegate=self;
    
    
    CGRect frm=customPickerView.frame;
    frm.origin.y=self.view.frame.size.height+10;
    customPickerView.frame=frm;
        frm.size.width=self.view.frame.size.width;
    
    [self.view addSubview:customPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark handel keyboard
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeKeyBoard];
}

-(void)closeKeyBoard
{
    [nameTextField resignFirstResponder];
    [emailTextField   resignFirstResponder];
    [mobileTextField   resignFirstResponder];
   
}



#pragma mark -service preperation 

-(void)startServiceGetPrice
{


//    NSDictionary*dd=_allData;
    NSError *tempError;

    
    NSString *stationFromID=[[_allData objectForKey:booking_stationFrom] objectForKey:@"station_id"];
    NSString *stationToID=[[_allData objectForKey:booking_stationTo] objectForKey:@"station_id"];
    NSString *Type=(((NSNumber*)[_allData objectForKey:booking_isRound]).boolValue?@"2":@"1");
    NSString *numberOfTickets=[NSString stringWithFormat:@"%@",(NSNumber*)[_allData objectForKey:booking_numberOfTickets]];
    
    
    NSString *fromTimeID=[[_allData objectForKey:booking_reservationTime] objectForKey:@"code"];
    NSString *toTimeID=[[_allData objectForKey:booking_returnTime] objectForKey:@"code"];
    
    NSString *resrvationDatee=[_allData objectForKey:booking_ReservationDate];
    NSString *returnDatee=[_allData objectForKey:booking_ReturnDate];
    NSString *tripsJson=@"";
    if (_TripType==trip_type_Trips) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[_allData objectForKey:booking_trips]
                                                           options:0
                                                             error:&error];
        
        if (!jsonData) {
            NSLog(@"errro parsing nsdictinary to json str");
        } else {
            
            tripsJson = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
//            NSLog(@&quot;JSON OUTPUT: %@&quot;,JSONString);

        }
        
        
    }
   
    NSString *price =[WebServiceManagerAPI getPriceWithFrom_station:stationFromID andTo_station:stationToID andTicket_type:Type andNumber_of_tickets:numberOfTickets andReservationDate:resrvationDatee andFromTime:fromTimeID andToTime:toTimeID andReturnDate:returnDatee andTripsJson:tripsJson WithErrorMessage:&tempError];
    
    
    
    if (price==nil || tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }

    
    [_allData setObject:price forKey:booking_price];
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    
    [self performSegueWithIdentifier:@"startViewData" sender:self];

}


#pragma mark -custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{
    //    [_timeButton setTitle:[NSString stringWithFormat:@"%@",selectedDate] forState:UIControlStateNormal];
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    switch (code) {
        case TicketsGo:
            [goTicketNumberButton setTitle:[NSString stringWithFormat:@"%@ Tickets",(NSNumber*)selectedItem]   forState:UIControlStateNormal];
            selectedNumberOfTickets=(NSNumber*)selectedItem;
            break;
            
        

        default:
            break;
    }
    
    [self enableOrDisablAll:YES];
    
}

-(NSString*)getTitleForRowInArray:(NSArray*)data andRow:(NSInteger)row{
    
    return [NSString stringWithFormat:@"%@",(NSNumber*)[data objectAtIndex:row]] ;
    
}

#pragma mark buttons actions

- (IBAction)nextAction:(id)sender {
    

    if (mobileTextField.text ==nil || mobileTextField.text.length<5 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must insert full mobile number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;

    }
    
    if (selectedNumberOfTickets.intValue<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select number of tickets" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    
    
    
//    NSString *name=REMOVENULL(nameTextField.text);
    
        [_allData setObject:selectedNumberOfTickets forKey:booking_numberOfTickets];
        [_allData setObject:REMOVENULL(nameTextField.text) forKey:booking_name];
        [_allData setObject:REMOVENULL(emailTextField.text) forKey:booking_email];
        [_allData setObject:mobileTextField.text forKey:booking_mobileNumber];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    [self performSelectorInBackground:@selector(startServiceGetPrice) withObject:nil];
    
    
    
}

- (IBAction)selectTicketNumber:(id)sender {
    
    
    if (TicketsNumberArrayGO==Nil || TicketsNumberArrayGO.count<=0 ) {
        return;
    }
    [self enableOrDisablAll:NO];

    
    if (((UIButton*)sender).tag==1) {
        customPickerView.itemsArray=TicketsNumberArrayGO;
        customPickerView.pickerType=type_itemsPicker;
        customPickerView.componentCode=TicketsGo;

    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    //    selectedStationObject=nil;
    [UIView commitAnimations];
    

}
-(void)enableOrDisablAll:(BOOL)EnOrDisable{
    
    [goTicketNumberButton setEnabled:EnOrDisable];
//    [returnTicketNumberButton setEnabled:EnOrDisable];
    
    [nameTextField setEnabled:EnOrDisable];
    [mobileTextField setEnabled:EnOrDisable];
    [emailTextField setEnabled:EnOrDisable];
    
}


#pragma mark prepareBefore go



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"startViewData"]) {
        ((ReviewDataAndTicketsViewController*)segue.destinationViewController).alldata=_allData;
        ((ReviewDataAndTicketsViewController*)segue.destinationViewController).TripType=_TripType;
    }
}


@end
