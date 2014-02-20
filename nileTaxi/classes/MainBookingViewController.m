//
//  MainBookingViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/7/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "MainBookingViewController.h"
#import "SelectTimeViewController.h"
#import "SWRevealViewController.h"

@interface MainBookingViewController ()

@end

@implementation MainBookingViewController

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
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    _sidebarButton.target = self.revealViewController;
    //    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
    if ([[segue identifier] isEqualToString:@"express"]) {
//        ((SelectTimeViewController*)segue.destinationViewController).ScreenID=1;
//        ((SelectTimeViewController*)segue.destinationViewController).title=@"From";

        
        
        ((SelectTimeViewController*)segue.destinationViewController).TripType=trip_type_Express;
        ((SelectTimeViewController*)segue.destinationViewController).isForStations=YES;

    }else if ([[segue identifier] isEqualToString:@"onCall"]) {
//        ((SelectTimeViewController*)segue.destinationViewController).ScreenID=1;
//        ((SelectTimeViewController*)segue.destinationViewController).title=@"From";

        ((SelectTimeViewController*)segue.destinationViewController).TripType=trip_type_Oncall;
        ((SelectTimeViewController*)segue.destinationViewController).isForStations=YES;

    }
    
    
    
    
    
    
    
}
@end
