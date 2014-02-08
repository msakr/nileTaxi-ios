//
//  SyncViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "SyncViewController.h"
#import "SWRevealViewController.h"
#import "WebServiceManagerAPI.h"
#import "Helpers.h"
#import "nilecodeAppDelegate.h"
#import "DBManager.h"
@interface SyncViewController ()

@end

@implementation SyncViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self performSelectorInBackground:@selector(loadAllStationsAndTimesAndDirectoins) withObject:Nil];
    
}



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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{
//    [_timeButton setTitle:[NSString stringWithFormat:@"%@",selectedDate] forState:UIControlStateNormal];
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    switch (code) {
        case stationsCode:
            [_stationsButton setTitle:[selectedItem  objectForKey:@"station_name"] forState:UIControlStateNormal];

            selectedStationObject=[[NSDictionary alloc]initWithDictionary:selectedItem];
            break;
        
        default:
            break;
    }
    
    [self enableOrDisablAll:YES];

}

-(NSString*)getTitleForRowInArray:(NSArray*)data andRow:(NSInteger)row{
    
    return [[data objectAtIndex:row] objectForKey:@"station_name"];
    
}

#pragma mark -getStationsBackground

-(void)loadAllStationsAndTimesAndDirectoins{
    stationsArray=[[NSMutableArray alloc]init];

    
    NSError *tempError;
    
    
    
//    anyError=tempError;
    NSArray *tempArray=[WebServiceManagerAPI getAllSatationsWithErrorMessage:&tempError];
    
    
    if (tempArray==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        return;
    }
    
    stationsArray=[[NSMutableArray alloc]initWithArray:tempArray];
    
    if (stationsArray.count>0) {
        [_stationsButton setTitle:[[stationsArray objectAtIndex:0] objectForKey:@"station_name"] forState:UIControlStateNormal ];
        selectedStationObject=[[NSDictionary alloc]initWithDictionary:[stationsArray objectAtIndex:0]];

        [Helpers addStationS:stationsArray];

    }else{
        [_stationsButton setTitle:@"NO Stations Available" forState:UIControlStateNormal ];

    }
    

    [MBProgressHUD hideHUDForView:self.view animated:YES];



}


#pragma mark -buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{

    [_stationsButton setEnabled:EnOrDisable];


}



#pragma mark -buttons Action

- (IBAction)stationButtonAction:(id)sender {
    
    
    if (stationsArray==Nil || stationsArray.count<=0) {
        return;
    }
    [self enableOrDisablAll:NO];

    customPickerView.itemsArray=stationsArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=stationsCode;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
//    selectedStationObject=nil;
    [UIView commitAnimations];
    
    
    
}

- (IBAction)startSyncAction:(id)sender {
    
    
    if (stationsArray.count<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must select station" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Helpers addSelectedStation:selectedStationObject];
    
    //start sync code
    
    
    [self performSelectorInBackground:@selector(processSyncServiceAndDB) withObject:nil];
    

    
    
}

#pragma mark -processSyncServiceAndDB

-(void)processSyncServiceAndDB{
    nilecodeAppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    //    [DBManager addTicketToDBWithTicket_id:@123 andDate:[NSDate date] andTime:@"1" andStationStartId:@11 andStationEndId:@12 andTicketType:@3 andReturnDate:[NSDate date] andReturnTime:@"33" withNSManagedObjectContext:self.managedObjectContext];
    
    NSError *errorDB;
    NSMutableArray *usedTicketsIds=[DBManager getAllUsedTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
    
    
    if (errorDB!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    NSString *stationID=[Helpers getSelectedStationID];
    
    
    NSError *tempError;
    
    
    
//    anyError=tempError;
    NSArray *newTickets=[WebServiceManagerAPI gatAllNewTicketsWithSatationID:stationID andUsedTickets:usedTicketsIds withErrorMessage:&tempError];

    
    
    if (newTickets==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        return;
    }

    
    
    
    BOOL ISallTicketsDeleted=[DBManager deleteAllTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
    
    
    if (!ISallTicketsDeleted && errorDB!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }


    for (NSDictionary *dicTicket in newTickets) {
        bool isAdded=[DBManager addTicketToDBWithT_email:[dicTicket objectForKey:@"email"] andT_from_name:[dicTicket objectForKey:@"from_name"] andt_idd:[dicTicket objectForKey:@"id"] andt_isUsed:[dicTicket objectForKey:@""] andt_mobile:[dicTicket objectForKey:@"mobile"] andt_name:[dicTicket objectForKey:@"name"] andt_num_tickets:[dicTicket objectForKey:@"number_of_tickets"] andt_rrn:[dicTicket objectForKey:@"rrn"] andt_ticket_type:[dicTicket objectForKey:@"ticket_type"] andt_to_name:[dicTicket objectForKey:@"to_name"] andt_trans_date:[dicTicket objectForKey:@"trans_date"] andt_trans_time:[dicTicket objectForKey:@"trans_time"] withNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
        
        if (!isAdded && errorDB!=nil) {
            UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertNO show];
            
            
        }
        
    }
    
    
    
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    /////
    

}

//- (IBAction)timeButtonAction:(id)sender {
//    
//////    customPickerView.itemsArray=[[NSMutableArray alloc]initWithObjects:@"aa",@"bb" , nil];
////    customPickerView.pickerType=type_DatePicker;
////    
////    [UIView beginAnimations:nil context:nil];
////    [UIView setAnimationDuration:0.5];
////    CGRect frame = customPickerView.frame;
////    frame.origin.y =  frame.origin.y-frame.size.height-10;
////    customPickerView.frame= frame;
////    [UIView commitAnimations];
//
//
//    [self enableOrDisablAll:NO];
//
//    if (TimesArray==Nil || TimesArray.count<=0) {
//        return;
//    }
//    customPickerView.itemsArray=TimesArray;
//    customPickerView.pickerType=type_itemsPicker;
//    customPickerView.componentCode=timesCode;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = customPickerView.frame;
//    frame.origin.y =  frame.origin.y-frame.size.height-10;
//    customPickerView.frame= frame;
//    [UIView commitAnimations];
//
//
//
//}
//- (IBAction)directionButtonAction:(id)sender {
//    [self enableOrDisablAll:NO];
//    
//    if (directionArray==Nil || directionArray.count<=0) {
//        return;
//    }
//    customPickerView.itemsArray=directionArray;
//    customPickerView.pickerType=type_itemsPicker;
//    customPickerView.componentCode=directionCode;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = customPickerView.frame;
//    frame.origin.y =  frame.origin.y-frame.size.height-10;
//    customPickerView.frame= frame;
//    
//    
//    [UIView commitAnimations];
//}
@end
