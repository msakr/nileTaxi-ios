//
//  MapViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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

    
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    CGRect frm=dialogView.frame;
    dialogOriginY=frm.origin.y;
    frm.origin.y=self.view.frame.size.height+10;
    dialogView.frame=frm;
    
    
}

-(void)viewDidLayoutSubviews
{
    if ([stationsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [stationsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    
    stationsTableView.backgroundColor = [UIColor clearColor];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self performSelectorInBackground:@selector(loadAllMaps) withObject:Nil];
    
    mapsArray=[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -getStationsBackground

-(void)loadAllMaps{
    mapsArray=[[NSMutableArray alloc]init];
    
    
    NSError *tempError;
    
    
    
//    anyError=tempError;
    NSArray *tempArray=[WebServiceManagerAPI getAllMapsWithErrorMessage:&tempError];
    
    
    if (tempArray==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        return;
    }
    
    mapsArray=[[NSMutableArray alloc]initWithArray:tempArray];
    
    
    
    [stationsTableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
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
    return [mapsArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stationsCell"];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stationsCell"];
    }
    cell.backgroundColor =  [UIColor clearColor];

    
    ((UILabel*)[cell viewWithTag:100]).text=[[mapsArray objectAtIndex:indexPath.row] objectForKey:@"station_name"];
    
     ((UILabel*)[cell viewWithTag:102]).text=[NSString stringWithFormat:@"waiting passengers %@",[[mapsArray objectAtIndex:indexPath.row] objectForKey:@"passengers"]];
    

    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //show
    
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



/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)hideDialogView:(id)sender {
   

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = dialogView.frame;
    frame.origin.y =     self.view.frame.size.height+10;
    dialogView.frame = frame;
    [UIView commitAnimations];
}
@end
