//
//  ScanViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/26/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "ScanViewController.h"
#import "SWRevealViewController.h"
#import "WebServiceManagerAPI.h"
#import "Ticket.h"
@interface ScanViewController ()
{
//    NSError *anyError;
}
@end

@implementation ScanViewController

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
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSError *tempError;
    
    
    
//    anyError=tempError;
    NSDictionary *tempArray=[WebServiceManagerAPI getTicketInfoWithTicketRRN:@"123" WithErrorMessage:&tempError];
    
    
    if (tempArray==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        return;
    }
    
    NSLog(@"@%",tempArray);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SearchAction:(id)sender {
}
@end
