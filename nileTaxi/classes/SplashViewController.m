//
//  SplashViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/18/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:5];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma splashScreen
-(void)removeSplash
{
//    [UIView animateWithDuration:1.0 animations:^{splashView.alpha = 0.0;} completion:^(BOOL finished){ [splashView removeFromSuperview]; }];
    
    [self performSegueWithIdentifier:@"showFirst" sender:self];
}


@end
