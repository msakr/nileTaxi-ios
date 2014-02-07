//
//  MainBookingViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/7/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "MainBookingViewController.h"
#import "SelectSationsViewController.h"
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
    if ([[segue identifier] isEqualToString:@"express"]) {
        ((SelectSationsViewController*)segue.destinationViewController).ScreenID=1;
        ((SelectSationsViewController*)segue.destinationViewController).title=@"From";

        
        ((SelectSationsViewController*)segue.destinationViewController).TripType=trip_type_Express;
    }else if ([[segue identifier] isEqualToString:@"onCall"]) {
        ((SelectSationsViewController*)segue.destinationViewController).ScreenID=1;
        ((SelectSationsViewController*)segue.destinationViewController).title=@"From";

        ((SelectSationsViewController*)segue.destinationViewController).TripType=trip_type_Oncall;
    }
    
    
    
    
}
@end
