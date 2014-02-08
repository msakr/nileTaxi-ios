//
//  SelectTimeViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/1/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "SelectTimeViewController.h"
#import "UserInfoViewController.h"
@interface SelectTimeViewController ()

@end

@implementation SelectTimeViewController

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
    
    if (_timesArray_reservation.count>0) {
//        times_reservation_TabelView
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    if (!_isRound) {
        [times_return_TabelView setHidden:YES];
    }
    
    if ([_timesArray_reservation count]<=0) {
        //diableButton
        
        [nextButton setEnabled:NO];
    }
    
    times_return_TabelView.backgroundColor = [UIColor clearColor];
    times_reservation_TabelView.backgroundColor = [UIColor clearColor];

}

#pragma mark - times table datasource and delegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:times_return_TabelView]) {

            return [_timesArray_return count];
    }else if ([tableView isEqual:times_reservation_TabelView]) {
        
      
            return [_timesArray_reservation count];
    }

    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timesCell"];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"timesCell"];
    }
    
    cell.backgroundColor =  [UIColor clearColor];
    NSDictionary *tempD;
    if ([tableView isEqual:times_return_TabelView]) {
        tempD=[_timesArray_return objectAtIndex:indexPath.row];
    }else if ([tableView isEqual:times_reservation_TabelView]) {
        tempD=[_timesArray_reservation objectAtIndex:indexPath.row];
    }
    
    ((UILabel*)[cell viewWithTag:100]).text=[tempD objectForKey:@"time"];
    
    ((UILabel*)[cell viewWithTag:101]).text=[NSString stringWithFormat:@"remain %@ from %@",[tempD objectForKey:@"remining_quota"],[tempD objectForKey:@"taxi_quota"]];

    
    return cell;
    
}

#pragma mark segue prepare

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"userInfo"]) {
        
        ((UserInfoViewController*)segue.destinationViewController).allData=_allData;
        ((UserInfoViewController*)segue.destinationViewController).TripType=_TripType;

        
        
    }
    
    
    
}
#pragma mark -buttons action



- (IBAction)goNext:(id)sender {

    if (times_reservation_TabelView.indexPathForSelectedRow ==nil || times_reservation_TabelView.indexPathForSelectedRow.row<0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    if (_isRound && (times_return_TabelView.indexPathForSelectedRow ==nil || times_return_TabelView.indexPathForSelectedRow.row<0 )) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"you must select Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    [_allData setObject:[_timesArray_reservation objectAtIndex:times_reservation_TabelView.indexPathForSelectedRow.row]  forKey:booking_reservationTime];
    
    
    if (_isRound) {
        [_allData setObject:[_timesArray_return objectAtIndex:times_return_TabelView.indexPathForSelectedRow.row]  forKey:booking_returnTime];
        
    }
    
    [self performSegueWithIdentifier:@"userInfo" sender:self];
    
    
}






@end
