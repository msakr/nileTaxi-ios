//
//  LogInViewController.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "LogInViewController.h"
#import "nilecodeAppDelegate.h"
#import "WebServiceManagerAPI.h"
#import "Helpers.h"
@interface LogInViewController ()
{
    NSError *anyError;
}
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

-(void)viewWillAppear:(BOOL)animated
{
    [Helpers logOutUser];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
   
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    
    CGRect ff=self.view.frame;
    ff.origin.y-=40;
    
    [self.view setFrame:ff];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
    CGRect ff=self.view.frame;
    ff.origin.y+=40;
    [self.view setFrame:ff];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//        // Set the gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    
    
    [userNameTxtField setLeftViewMode:UITextFieldViewModeAlways];
    
    UIImageView *ii=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_b.png"]];
    [ii setContentMode:UIViewContentModeScaleToFill];
//    userNameTxtField.leftView= ii;
    
    [self.view viewWithTag:1].layer.borderColor = [UIColor colorWithRed:32 green:0 blue:21 alpha:1.0].CGColor;
    [self.view viewWithTag:1].layer.borderWidth=1;
    [self.view viewWithTag:1].layer.cornerRadius=4;
    
//    userNameTxtField.background=[UIImage imageNamed:@"Tsonoqua Mask.gif"];
    
//
    
    
    nilecodeAppDelegate   *appDelegate = (nilecodeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isLogin=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -buttons Action

-(IBAction)closeKeyBoard:(id)sender
{
    [userNameTxtField resignFirstResponder];
    [passwordTxtField resignFirstResponder];
}

- (IBAction)logInAction:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelectorInBackground:@selector(startLogInSerivce) withObject:nil];

}


#pragma mark -service handelers

-(void)startLogInSerivce{
    
    
    //validating data
    
    if (userNameTxtField.text==nil || userNameTxtField.text.length<=2) {
        //display Error
        UIAlertView *err=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must enter UserName" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [err show];
        
        
    }else if(passwordTxtField.text==nil || passwordTxtField.text.length<=2) {
        //display Error
        UIAlertView *err=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must enter password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [err show];


    }else{
        @autoreleasepool{
            
            NSError *tempError;
            
            NSNumber* state=[NSNumber numberWithBool:[WebServiceManagerAPI logMeInWithUserName:userNameTxtField.text andPassword:passwordTxtField.text withErrorMessage:&tempError]];
    
            [self performSelectorOnMainThread:@selector(finishLoggingInWithStatus:) withObject:state waitUntilDone:NO];
            
            
            if (tempError!=nil) {
                anyError=[[NSError alloc]initWithDomain:tempError.domain code:tempError.code userInfo:tempError.userInfo];

            }
            
        }

    }
    
    
    
    
    
    

}


#pragma mark -updateView

-(void)finishLoggingInWithStatus:(NSNumber*)IsLogIn{
    

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (!IsLogIn.boolValue) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:anyError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
    }else{
        nilecodeAppDelegate   *appDelegate = (nilecodeAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.isLogin=YES;
        

        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
    
    
}


#pragma  mark -touch action


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordTxtField resignFirstResponder];
    [userNameTxtField resignFirstResponder];
}
#pragma mark -delegate textField
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
