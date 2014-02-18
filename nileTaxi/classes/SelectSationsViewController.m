//
//  SelectSationsViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/29/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "SelectSationsViewController.h"
#import "Helpers.h"
#import "BookViewController.h"
@interface SelectSationsViewController ()

@end

@implementation SelectSationsViewController




-(void)viewWillAppear:(BOOL)animated{
    stationsArray=[Helpers getStations];
    
    stationTableview.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidLayoutSubviews
{
    if ([stationTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [stationTableview setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [stationsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stationsCell"];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stationsCell"];
    }
    cell.backgroundColor =  [UIColor clearColor];
    
    ((UILabel*)[cell viewWithTag:100]).text=[[stationsArray objectAtIndex:indexPath.row] objectForKey:@"station_name"];
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_ScreenID==1) {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SelectSationsViewController *dest = [storyboard instantiateViewControllerWithIdentifier:@"vv"];
        dest.ScreenID=2;
        _fromStation=[stationsArray objectAtIndex:indexPath.row];
        dest.fromStation=[stationsArray objectAtIndex:indexPath.row];
        dest.title=@"To";
        dest.TripType=_TripType;
        [self.navigationController pushViewController:dest animated:YES];
    
    
    }else if(_ScreenID==2){
        
        _toStation=[stationsArray objectAtIndex:indexPath.row];

        if ([[_toStation objectForKey:@"station_id"] isEqualToString:[_fromStation objectForKey:@"station_id"]]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"source and destination station must not be the same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
        [self performSegueWithIdentifier:@"nextStep" sender:self];
    }
    
    
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"nextStep"]) {
//        ((BookViewController*)segue.destinationViewController).ScreenID=2;
        
        
        
        ((BookViewController*)segue.destinationViewController).stationFrom=_fromStation;
        ((BookViewController*)segue.destinationViewController).stationTo=_toStation;
        ((BookViewController*)segue.destinationViewController).TripType=_TripType;
        
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
