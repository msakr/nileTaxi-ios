//
//  ScanViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/26/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController
{
//    NSError *__autoreleasing* anyError;
    __weak IBOutlet UITextField *rrnTextFiled;
}
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
- (IBAction)SearchAction:(id)sender;

@end
