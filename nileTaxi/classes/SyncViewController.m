//
//  SyncViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "SyncViewController.h"
#import "SWRevealViewController.h"
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
    

    [self.view addSubview:customPickerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{
    [_timeButton setTitle:[NSString stringWithFormat:@"%@",selectedDate] forState:UIControlStateNormal];
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    switch (code) {
        case stationsCode:
            [_stationsButton setTitle:selectedItem forState:UIControlStateNormal];

            break;
        case timesCode:
            [_timeButton setTitle:selectedItem forState:UIControlStateNormal];
            
            break;
        case directionCode:
            [_directionButton setTitle:selectedItem forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
    [self enableOrDisablAll:YES];

}



#pragma getStationsBackground

-(void)loadAllStationsAndTimesAndDirectoins{
    stationsArray=[[NSMutableArray alloc]initWithObjects:@"ST1",@"ST2", nil];
    [_stationsButton setTitle:[stationsArray objectAtIndex:0] forState:UIControlStateNormal ];



    TimesArray=[[NSMutableArray alloc]initWithObjects:@"T1",@"T2",@"T3", nil];
    [_timeButton setTitle:[TimesArray objectAtIndex:0] forState:UIControlStateNormal ];
    
    directionArray=[[NSMutableArray alloc]initWithObjects:@"D1",@"D2",@"D3",@"D4", nil];
    [_directionButton setTitle:[directionArray objectAtIndex:0] forState:UIControlStateNormal ];

}


#pragma buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{

    [_stationsButton setEnabled:EnOrDisable];
    [_timeButton setEnabled:EnOrDisable];
    [_directionButton setEnabled:EnOrDisable];

}



#pragma buttons Action

- (IBAction)stationButtonAction:(id)sender {
    
    [self enableOrDisablAll:NO];
    
    if (stationsArray==Nil || stationsArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=stationsArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=stationsCode;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
    
    
    
}
- (IBAction)timeButtonAction:(id)sender {
    
////    customPickerView.itemsArray=[[NSMutableArray alloc]initWithObjects:@"aa",@"bb" , nil];
//    customPickerView.pickerType=type_DatePicker;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = customPickerView.frame;
//    frame.origin.y =  frame.origin.y-frame.size.height-10;
//    customPickerView.frame= frame;
//    [UIView commitAnimations];


    [self enableOrDisablAll:NO];

    if (TimesArray==Nil || TimesArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=TimesArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=timesCode;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    [UIView commitAnimations];



}
- (IBAction)directionButtonAction:(id)sender {
    [self enableOrDisablAll:NO];
    
    if (directionArray==Nil || directionArray.count<=0) {
        return;
    }
    customPickerView.itemsArray=directionArray;
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=directionCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    
    [UIView commitAnimations];
}
@end
