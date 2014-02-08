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
    
    
    if (_TripType==trip_type_Trips) {
        
        int maxNumber=    ((NSNumber*)[[_allData objectForKey:booking_trips]objectForKey:@"remain_number_of_tickets"]).intValue;
        
        
        for (int i=1; i<=maxNumber; i++) {
            
            [TicketsNumberArrayGO addObject:[NSNumber numberWithInt:i]];
            
        }
    }else{
    NSNumber *numberOfticketsGO=[[_allData objectForKey:booking_reservationTime ] objectForKey:@"remining_quota"];
    
    NSNumber *numberOfticketsReturn=[[_allData objectForKey:booking_returnTime ] objectForKey:@"remining_quota"];

            TicketsNumberArrayGO=[[NSMutableArray alloc]init];

    
    int maxNumber=    (numberOfticketsGO.intValue<numberOfticketsReturn.intValue ? numberOfticketsGO.intValue:numberOfticketsReturn.intValue);
    
    
    for (int i=1; i<=maxNumber; i++) {

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

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

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
    
   
    NSString *price =[WebServiceManagerAPI getPriceWithFrom_station:stationFromID andTo_station:stationToID andTicket_type:Type andNumber_of_tickets:numberOfTickets andReservationDate:resrvationDatee andFromTime:fromTimeID andToTime:toTimeID andReturnDate:returnDatee WithErrorMessage:&tempError];
    
    
    
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
            [goTicketNumberButton setTitle:[NSString stringWithFormat:@"%@",(NSNumber*)selectedItem]   forState:UIControlStateNormal];
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
    

    if (mobileTextField.text ==nil || mobileTextField.text.length<5 || nameTextField.text ==nil || nameTextField.text.length<5 || emailTextField.text ==nil || emailTextField.text.length<5) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must insert full mobile number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;

    }
    
    if (selectedNumberOfTickets.intValue<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select number of tickets" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    
    
        [_allData setObject:selectedNumberOfTickets forKey:booking_numberOfTickets];
        [_allData setObject:nameTextField.text forKey:booking_name];
        [_allData setObject:emailTextField.text forKey:booking_email];
        [_allData setObject:mobileTextField.text forKey:booking_mobileNumber];
    
    
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
