//
//  ScanViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/26/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Ticket.h"
#import "ZBarSDK.h"
#import "ZBarReaderViewController.h"
#import "AlertView.h"

#define alert_ticketNOTfound_tag 1
#define alert_ticketUSE_tag 2
#define alert_ticketBook_tag 3
@interface ScanViewController : UIViewController<UIAlertViewDelegate,ZBarReaderViewDelegate>
{
//    NSError *__autoreleasing* anyError;
    __weak IBOutlet UITextField *rrnTextFiled;
    
    __weak IBOutlet ZBarReaderView *readerView;
    
//    ZBarReaderView *readerView;
    Ticket *inputTicket;
    NSString*tempRRN;
//    NSThread* thread;
//    UIAlertView *alertt;
}

//@property (retain,nonatomic)

@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
- (IBAction)SearchAction:(id)sender;

@end
