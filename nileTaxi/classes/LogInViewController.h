//
//  LogInViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface LogInViewController : UIViewController<UITextFieldDelegate>
{


    __weak IBOutlet UITextField *userNameTxtField;
    
    __weak IBOutlet UITextField *passwordTxtField;

}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;


-(IBAction)closeKeyBoard:(id)sender;
@end
