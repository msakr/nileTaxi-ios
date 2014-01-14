//
//  LogInViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

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
    
    
    [userNameTxtField setLeftViewMode:UITextFieldViewModeAlways];
    userNameTxtField.leftView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a.png"]];
//    userNameTxtField.background=[UIImage imageNamed:@"Tsonoqua Mask.gif"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma buttons Action

-(IBAction)closeKeyBoard:(id)sender
{
    [userNameTxtField resignFirstResponder];
    [passwordTxtField resignFirstResponder];
}

#pragma  touch action


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordTxtField resignFirstResponder];
    [userNameTxtField resignFirstResponder];
}
#pragma delegate textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextView: YES];

    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextView: NO];
    
    [textField resignFirstResponder];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return NO;
}


- (void) animateTextView:(BOOL) up
{
    const int movementDistance =100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement= movement = (up ? -movementDistance : movementDistance);
    NSLog(@"%d",movement);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    CGRect rr=self.view.frame;
    rr.origin.y=rr.origin.y+movement;
    
    self.view.frame = rr;//CGRectOffset(self.inputView.frame, 0, movement);
    [UIView commitAnimations];
}





@end
