//
//  MainViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "SelectSationsViewController.h"
#import "Helpers.h"
#import "DBManager.h"
#import "WebServiceManagerAPI.h"
#import "nilecodeAppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    customPickerView=[[[NSBundle mainBundle] loadNibNamed:@"CustomPicker" owner:self options:nil] objectAtIndex:0];
    customPickerView.callerDelegate=self;
    
    
    CGRect frm=customPickerView.frame;
    frm.origin.y=self.view.frame.size.height+10;
    frm.size.width=self.view.frame.size.width;
    customPickerView.frame=frm;
    
    
    [self.view addSubview:customPickerView];
    
	// Do any additional setup after loading the view.
    
//    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    
//    _sidebarButton.target = self.revealViewController;
//    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    switch (_showNext) {
        case 1:
            [self performSegueWithIdentifier:@"showLogIn" sender:self];

            break;
        case 2:
            [self performSegueWithIdentifier:@"showSync" sender:self];
            
            break;
        case 3:
            [self performSegueWithIdentifier:@"showMap" sender:self];
            
            break;
        case 4:
            [self performSegueWithIdentifier:@"showBook" sender:self];
            
            break;
        case 5:
            [self performSegueWithIdentifier:@"showScan" sender:self];
            
            break;
            
            
            
            
        default:
            break;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self performSelectorOnMainThread:@selector(loadAllStationsAndTimesAndDirectoins) withObject:nil waitUntilDone:NO];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    _sidebarButton.target = self.revealViewController;
    //    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
    

    
    _lastUpdateLabel.text=    [NSString stringWithFormat:@"Successfully updated @%@",([Helpers getLastUpdatedHomeScreen]==nil?@"Not Updated":[Helpers getLastUpdatedHomeScreen])];
    
    _userNameLabel.text=([Helpers getName]==nil?@"":[Helpers getName]);
    
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if ([[segue identifier] isEqualToString:@"showBook"]) {
//        ((SelectSationsViewController*)segue.destinationViewController).ScreenID=1;
//                ((SelectSationsViewController*)segue.destinationViewController).title=@"From";
//    }
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



#pragma mark buttons action
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanAction:(id)sender {
    

    [self performSegueWithIdentifier:@"showScan" sender:self];
    

}

- (IBAction)bookAction:(id)sender {
    

    [self performSegueWithIdentifier:@"showBook" sender:self];
  
}

- (IBAction)mapsAction:(id)sender {

    [self performSegueWithIdentifier:@"showMap" sender:self];
    
}

- (IBAction)refreshAction:(id)sender {
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
- (IBAction)showStationsAction:(id)sender {
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
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    NSString *stringDate = [dateFormat stringFromDate:[NSDate date]];
    
    
    [Helpers saveLastUpdatedHomeScreen:stringDate];
    
    /////

    
    NSDictionary *dd=[Helpers getSelectedStation];
    _lastUpdateLabel.text=[NSString stringWithFormat:@"Successfully updated @%@",stringDate];
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    
}

@end
