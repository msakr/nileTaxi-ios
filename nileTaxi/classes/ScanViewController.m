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
#import "MainBookingViewController.h"
#import "DBManager.h"
#import "nilecodeAppDelegate.h"
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
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
//    ZBarImageScanner *scanner = self.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance

//    readerView = [ZBarReaderView new];
    readerView.readerDelegate = self;
//    readerView.
    readerView.tracksSymbols = YES;
    
//    readerView.frame = CGRectMake(30,70,230,230);
    readerView.torchMode = 0;
//    readerView.device = [self frontFacingCameraIfAvailable];
    
    ZBarImageScanner *scanner = readerView.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    
//    [self relocateReaderPopover:[self interfaceOrientation]];
    
    [readerView start];
    readerView.captureReader.enableReader=YES;
    
    [self.view addSubview: readerView];
//    resultText.hidden=NO;

    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    self.readerDelegate = self;
//    self.supportedOrientationsMask = ZBarOrientationMaskAll;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark zbar delegate

- (void) readerView: (ZBarReaderView*) rreaderView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
    
//    [info objectForKey: ZBarReaderControllerResults];
    
    NSLog(@"%i aaaaa",symbols.count);
    

    
//    ZBarSymbol *symbol = nil;
    for(ZBarSymbol *sym  in symbols){
        // EXAMPLE: just grab the first barcode
//        break;
    
    // EXAMPLE: do something useful with the barcode data
    NSLog(@"%@ aasasasas",sym.data);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [self performSelector:@selector(recieveRRn:) withObject:sym.data afterDelay:10];
//        [readerView stop];
            readerView.captureReader.enableReader=NO;
        break;

        
    }
    
}

- (void) readerView: (ZBarReaderView*) readerView
   didStopWithError: (NSError*) error{
    

    
    UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error aaaaa" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: self];
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [alertNO show];
}
//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    NSLog(@"%@",symbol.data);
//    
//    // EXAMPLE: do something useful with the barcode image
////    resultImage.image =    [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
////    [reader dismissModalViewControllerAnimated: YES];
//}

#pragma mark -keyboard
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [rrnTextFiled resignFirstResponder];
}

#pragma mark -handel when recieve RRn from camera or text field

-(void)recieveRRn:(NSString*)input_RRn
{
    
    tempRRN=nil;
    nilecodeAppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    //    [DBManager addTicketToDBWithTicket_id:@123 andDate:[NSDate date] andTime:@"1" andStationStartId:@11 andStationEndId:@12 andTicketType:@3 andReturnDate:[NSDate date] andReturnTime:@"33" withNSManagedObjectContext:self.managedObjectContext];
    
    NSError *errorDB;
    inputTicket=[DBManager getTicketWithRRN:input_RRn WithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
    
    if (errorDB!=nil ) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: self];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [alertNO show];
        
        
        
        return;
    }


    if (inputTicket==nil) {
        ///
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        UIAlertView *alertForNotFound=[[UIAlertView alloc]initWithTitle:@"Wrong" message:@"The ticket was NOT found\n do you want to check for it on the service?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
        alertForNotFound.tag=alert_ticketNOTfound_tag;
        tempRRN=input_RRn;

        [alertForNotFound show];
        return;
    }
    
    
    if (inputTicket.isUsed.boolValue) {
        UIAlertView *alertForNotFound=[[UIAlertView alloc]initWithTitle:@"Wrong" message:@"The ticket was Used before" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        inputTicket=nil;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [alertForNotFound show];
        return;
    }
    
    NSString *Recieved_RRn=inputTicket.rrn;
    NSString *Recieved_fromStation=inputTicket.from_name;
    NSString *Recieved_toStation=inputTicket.to_name;
    NSString *Recieved_nane=inputTicket.name;
    
    UIAlertView *useTicketAlert=[[UIAlertView alloc]initWithTitle:@"Found" message:[NSString stringWithFormat:@"The Ticket Was Found\nname: %@\nFrom: %@\nTo: %@\nRRN: %@\nDo you want to use it?",Recieved_nane,Recieved_fromStation,Recieved_toStation,Recieved_RRn] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    useTicketAlert.tag=alert_ticketUSE_tag;
    [useTicketAlert show];
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    
}


#pragma mark -alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==alert_ticketNOTfound_tag) {
        if (buttonIndex==1) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];

            //checkOn the service
            NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
            [self performSelectorInBackground:@selector(checkOntheWebForTicketWithRRn:) withObject:tempRRN ];
        }else{
            readerView.captureReader.enableReader=YES;
            
        }
//        return;
    }else     if (alertView.tag==alert_ticketUSE_tag) {
        if (buttonIndex==1) {
            //use Ticket
            NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
            
            if (inputTicket!=nil) {
                    nilecodeAppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
                
                inputTicket.isUsed=[NSNumber numberWithBool:YES];
                NSError *errorDB;
                [appDelegate.managedObjectContext save:&errorDB];
                
                if (errorDB!=nil ) {
                    UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [alertNO show];
                    
                    
                    
                    return;
                }else {
                    UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Success Ticket was Used" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [alertNO show];
                }


            }
            
            
        }else{
readerView.captureReader.enableReader=YES;
            
        }
    }else if (alertView.tag==alert_ticketBook_tag) {
        if (buttonIndex==1) {
            //go to book View
            NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            MainBookingViewController   *dest = [storyboard instantiateViewControllerWithIdentifier:@"booking"];
                        [self.navigationController pushViewController:dest animated:YES];
            

        }else{
readerView.captureReader.enableReader=YES;

        }
        
    }else{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        readerView.captureReader.enableReader=YES;

//        [readerView.captureReader enableReader];
//        [readerView start];

    }
    
    
    
}



#pragma mark -service play on ticket rrn check



-(void)checkOntheWebForTicketWithRRn:(NSString*)rrn
{

    if (rrn==nil) {
        return ;
    }
    NSError *tempError;
    
    
    for (int i=0;i<1000000000; i++) {
//        NSLog(@"aaaa");
    }
    
    
    //    anyError=tempError;
    NSDictionary *tempArray=[WebServiceManagerAPI getTicketInfoWithTicketRRN:rrn WithErrorMessage:&tempError];
    
    
    if (tempArray==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [alertNO show];
        return;
    }
    

    if ([tempArray objectForKey:@"rrn"]==nil) {
            ///
            UIAlertView *alertForNotFound=[[UIAlertView alloc]initWithTitle:@"Wrong" message:@"The ticket was NOT found on the service\n do you want to book a ticket?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            alertForNotFound.tag=alert_ticketBook_tag;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            tempRRN=nil;
            
            [alertForNotFound show];
        
    }else{
    
    NSString *Recieved_RRn=[tempArray objectForKey:@"rrn"];
    NSString *Recieved_fromStation=[tempArray objectForKey:@"from_name"];
    NSString *Recieved_toStation=[tempArray objectForKey:@"to_name"];
    NSString *Recieved_nane=[tempArray objectForKey:@"name"];
    
    UIAlertView *useTicketAlert=[[UIAlertView alloc]initWithTitle:@"Found" message:[NSString stringWithFormat:@"The Ticket Was Found\nname: %@\nFrom: %@\nTo: %@\nRRN: %@\nDo you want to use it?",Recieved_nane,Recieved_fromStation,Recieved_toStation,Recieved_RRn] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    useTicketAlert.tag=alert_ticketUSE_tag;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    [useTicketAlert show];
    }
    
}

- (IBAction)SearchAction:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self recieveRRn:rrnTextFiled.text];
}
@end
