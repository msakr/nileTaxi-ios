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
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    _sidebarButton.target = self.revealViewController;
    //    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if ([[segue identifier] isEqualToString:@"showBook"]) {
//        ((SelectSationsViewController*)segue.destinationViewController).ScreenID=1;
//                ((SelectSationsViewController*)segue.destinationViewController).title=@"From";
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
