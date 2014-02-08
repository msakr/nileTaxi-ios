//
//  TripsViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/7/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "TripsViewController.h"
#import "WebServiceManagerAPI.h"
#import "UserInfoViewController.h"
@interface TripsViewController ()

@end

@implementation TripsViewController

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
//    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    // Set the gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    
    customPickerView=[[[NSBundle mainBundle] loadNibNamed:@"CustomPicker" owner:self options:nil] objectAtIndex:0];
    customPickerView.callerDelegate=self;
    
    
    CGRect frm=customPickerView.frame;
    frm.origin.y=self.view.frame.size.height+10;
    customPickerView.frame=frm;
    
    
    [self.view addSubview:customPickerView];

}

-(void)viewWillAppear:(BOOL)animated
{
    tripsArray=[[NSMutableArray alloc]init];
    selectedTripDate=[NSDate date];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringDate = [dateFormat stringFromDate:selectedTripDate];
    //    NSLog(@"stringDate: %@",stringDate);
    
    
    [dateButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];

    
    myTripsTable.backgroundColor = [UIColor clearColor];

    [self performSelectorInBackground:@selector(startLoadTrips) withObject:Nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -buttons Action
- (IBAction)showDateButton:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    
   
    customPickerView.pickerType=type_DatePicker;
            
    customPickerView.componentCode=dateButtonCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;

}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tripsArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripsCell"];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TripsCell"];
    }
    cell.backgroundColor =  [UIColor clearColor];

    
    ((UILabel*)[cell viewWithTag:100]).text=[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"trip_name"];
    
    ((UILabel*)[cell viewWithTag:101]).text=[NSString stringWithFormat:@"%@ >> %@ ",[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"trip_from_station"],[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"trip_to_station"]];
    ((UILabel*)[cell viewWithTag:102]).text=[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"trip_time"];
    
    ((UILabel*)[cell viewWithTag:103]).text=[NSString stringWithFormat:@"Remaining %@ of %@ Ticket",[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"remain_number_of_tickets"],[[tripsArray objectAtIndex:indexPath.row] objectForKey:@"total_number_of_tickets"]];
    
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //show
    
    
    
    selectedTrip=[tripsArray objectAtIndex:indexPath.row];
    
    if (((NSNumber*)[selectedTrip objectForKey:@"remain_number_of_tickets"]).intValue<=0) {
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"out of tickets" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }else{
    
        [self performSegueWithIdentifier:@"showInfoTrips" sender:self];
    }
    //
    //        stationNameLabel.text=[mapsArray objectAtIndex:indexPath.row];
    //        stationLeavingNumbLabel.text=[NSString stringWithFormat:@"%i L",indexPath.row];
    //        stationWaitingNumLabel.text=[NSString stringWithFormat:@"%i W",indexPath.row];
    //
    //        [UIView beginAnimations:nil context:nil];
    //        [UIView setAnimationDuration:0.5];
    //        CGRect frame = dialogView.frame;
    //        frame.origin.y =  dialogOriginY-10;
    //        dialogView.frame= frame;
    //        [UIView commitAnimations];
    
}
#pragma mark -custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
   
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringDate = [dateFormat stringFromDate:selectedDate];
    //    NSLog(@"stringDate: %@",stringDate);
    

    selectedTripDate=selectedDate;
            [dateButton setTitle:[NSString stringWithFormat:@"%@",stringDate] forState:UIControlStateNormal];
            
    [self enableOrDisablAll:YES];


    [self performSelectorInBackground:@selector(startLoadTrips) withObject:Nil];
    
    
    
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    
    [self enableOrDisablAll:YES];
    
}

-(NSString *)getTitleForRowInArray:(NSArray *)data andRow:(NSInteger)row
{
    return Nil;
}
#pragma mark -buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{
    
    [dateButton setEnabled:EnOrDisable];


    
    
}

#pragma mark loadService

-(void)startLoadTrips
{
    

    NSError *tempError;
    
    
    NSString *TripDate=[NSString stringWithFormat:@"%i",(int)[selectedTripDate timeIntervalSince1970]];

    
    //    anyError=tempError;
    NSArray *tempDic=[WebServiceManagerAPI getTripsWithReservation_date:TripDate WithErrorMessage:&tempError];
    
    
    if (tempDic==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    
    tripsArray=[[NSMutableArray alloc]initWithArray:tempDic];
    [myTripsTable reloadData];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    
}


#pragma mark -segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showInfoTrips"]) {
        NSMutableDictionary *allData=[[NSMutableDictionary alloc]init];
        
        [allData setObject:selectedTrip forKey:booking_trips];
        
        
        ((UserInfoViewController*)segue.destinationViewController).allData=allData;
        ((UserInfoViewController*)segue.destinationViewController).TripType=trip_type_Trips;
        
        
        
    }
    
}





@end
