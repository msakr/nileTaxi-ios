//
//  BookViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "BookViewController.h"
#import "SWRevealViewController.h"
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
    
    
    [self.view addSubview:customPickerView];
}

-(void)viewWillAppear:(BOOL)animated{
    
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
    [roundTripButton setTitle:[NSString stringWithFormat:@"%@",selectedDate] forState:UIControlStateNormal];
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    switch (code) {
        case stationsButtonCode:
            [stationsButton setTitle:selectedItem forState:UIControlStateNormal];
            
            break;
        case timesButtonCode:
            [timesButton setTitle:selectedItem forState:UIControlStateNormal];
            
            break;
        case directionButtonCode:
            [directionButton setTitle:selectedItem forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
    [self enableOrDisablAll:YES];
    
}



#pragma mark -getStationsBackground

-(void)loadAllStationsAndTimesAndDirectoins{
    stationsArray=[[NSMutableArray alloc]initWithObjects:@"ST1",@"ST2", nil];
    [stationsButton setTitle:[stationsArray objectAtIndex:0] forState:UIControlStateNormal ];
    
    
    
    timesArray=[[NSMutableArray alloc]initWithObjects:@"T1",@"T2",@"T3", nil];
    [timesButton setTitle:[timesArray objectAtIndex:0] forState:UIControlStateNormal ];
    
    directionArray=[[NSMutableArray alloc]initWithObjects:@"D1",@"D2",@"D3",@"D4", nil];
    [directionButton setTitle:[directionArray objectAtIndex:0] forState:UIControlStateNormal ];
    
    [roundTripButton setTitle:[NSString stringWithFormat:@"%@",[NSDate date]] forState:UIControlStateNormal];

    
}


#pragma mark -buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{
    
    [stationsButton setEnabled:EnOrDisable];
    [timesButton setEnabled:EnOrDisable];
    [directionButton setEnabled:EnOrDisable];
    
}

#pragma mark -buttons Action



- (IBAction)ChangeroundTrip:(id)sender {

    [roundTripButton setHidden:![(UISwitch *)sender isOn ]];
}

- (IBAction)BookTicket:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Ticket Will be sent by email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)selectStation:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    if (stationsArray==Nil || stationsArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=stationsArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=stationsButtonCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];

}

- (IBAction)selectDate:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    
    customPickerView.pickerType=type_DatePicker;
    customPickerView.componentCode=dateButtonCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
}

- (IBAction)selectTime:(id)sender {
    
    
    [self enableOrDisablAll:NO];
    
    if (timesArray==Nil || timesArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=timesArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=timesButtonCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
}

- (IBAction)selectDirection:(id)sender {
    
    
    [self enableOrDisablAll:NO];
    
    if (directionArray==Nil || directionArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=directionArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=directionButtonCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
}
@end
