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
#import "Helpers.h"
#import "DBManager.h"
#import "WebServiceManagerAPI.h"
#import "nilecodeAppDelegate.h"

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


- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef maskedImageRef = CGImageCreateWithMask([image CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    
    CGImageRelease(mask);
    CGImageRelease(maskedImageRef);
    
    // returns new image with mask applied
    return maskedImage;
}
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    
    
    
    UITapGestureRecognizer *tapRecognizerScan = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(scanAction:)];
    [tapRecognizerScan setNumberOfTouchesRequired:1];
    [tapRecognizerScan setDelegate:self];
    
    
    UITapGestureRecognizer *tapRecognizerBook = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(bookAction:)];
    [tapRecognizerBook setNumberOfTouchesRequired:1];
    [tapRecognizerBook setDelegate:self];

    
    
    UITapGestureRecognizer *tapRecognizerMap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(mapsAction:)];
    [tapRecognizerMap setNumberOfTouchesRequired:1];
    [tapRecognizerMap setDelegate:self];

    //Don't forget to set the userInteractionEnabled to YES, by default It's NO.

    
            [scanImagev addGestureRecognizer:tapRecognizerScan];
            [mapsImagev addGestureRecognizer:tapRecognizerMap];
            [bookimagev addGestureRecognizer:tapRecognizerBook];
//    
//    if (!((nilecodeAppDelegate *)[[UIApplication sharedApplication] delegate]).isLogin) {
//        [self performSegueWithIdentifier:@"showLogIn" sender:self];
//        return;
//        
//    }
    customPickerView=[[[NSBundle mainBundle] loadNibNamed:@"CustomPicker" owner:self options:nil] objectAtIndex:0];
    customPickerView.callerDelegate=self;
    
    
    CGRect frm=customPickerView.frame;
    frm.origin.y=self.view.frame.size.height+10;
    frm.size.width=self.view.frame.size.width;
    customPickerView.frame=frm;
    
    
    [self.view addSubview:customPickerView];
    
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



-(void)drawPercent:(CGFloat)percent forImageView:(UIImageView*)imageView{
    
    UIImage *bottomImage =[UIImage imageNamed:@"progressbar_empty.jpg"];
    UIImage *image = [UIImage imageNamed:@"progressbar_full.jpg"];
    

    if (percent==1) {
    percent=0.99999;
    }

    
//    bottomImage=[self imageByCropping:bottomImage toRect:CGRectMake(0, 0, bottomImage.size.width, bottomImage.size.height)];
//    
//    image=[self imageByCropping:image toRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    
    CGSize newSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext( newSize );
    
    
    
    // Use existing opacity as is
//    [bottomImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // Apply supplied opacity
    
    
    //
    //    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, image.size.width*2.0f*percent, image.size.height*2));
    //    // or use the UIImage wherever you like
    //    image=[UIImage imageWithCGImage:imageRef];
    //    CGImageRelease(imageRef);
    
    image=[MainViewController imageWithImage:image scaledToSize:newSize];
    bottomImage=[MainViewController imageWithImage:bottomImage scaledToSize:newSize];

    
    bottomImage=[self imageByCropping:bottomImage toRect:CGRectMake(newSize.width*percent, 0, newSize.width*(1.0-percent), newSize.height)];

    [bottomImage drawInRect:CGRectMake(newSize.width*percent, 0, newSize.width*(1.0-percent), newSize.height)];


//    CGRect cc=CGRectMake(0, 0, newSize.width*percent, newSize.height);
    
                         
    image=[self imageByCropping:image toRect:CGRectMake(0, 0, newSize.width*percent+1, newSize.height)];
    

    [image drawInRect:CGRectMake(0,0,newSize.width*percent,newSize.height) blendMode:kCGBlendModeNormal alpha:1];
    

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   
    
    [imageView setImage:newImage];
    
    UIGraphicsEndImageContext();
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)imageByCropping:(UIImage *)image toRect:(CGRect)rect
{
    if (UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(rect.size,
                                               /* opaque */ NO,
                                               /* scaling factor */ 0.0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    
    // stick to methods on UIImage so that orientation etc. are automatically
    // dealt with for us
    [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:NO];

    
    if ([Helpers getToken]!=nil) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self performSelectorInBackground:@selector(loadAllStationsAndTimesAndDirectoins) withObject:nil ];
        
        
        
    }

    if ([Helpers getToken]==nil) {
        [self performSegueWithIdentifier:@"showLogIn" sender:self];
        return;

    }
    
    
    
    
    float f=usedTicketsNumber/(allTicketsNumber==0?1:allTicketsNumber);
    
    [self drawPercent:f forImageView:progressImageView];
    _numberPassengersLabel.text=[NSString stringWithFormat:@"%i/%i",usedTicketsNumber,allTicketsNumber];

//    UIImage *EmptyIMAGE = [UIImage imageNamed:@"boat_gray.png"];
//    UIImage *progressIMAGE = [UIImage imageNamed:@"boat_blue.png"];
    
    // result of the masking method
//    UIImage *maskedImage = [self maskImage:image withMask:mask];

//    UIProgr?]
   

//    [progresss setMeterType:DPMeterTypeLinearHorizontal];
//    [progresss setShape:[UIBezierPath stars:5 shapeInFrame:progresss.bounds].CGPath];
//
//    CGRect imgFrame = CGRectMake(0, 0, progressIMAGE.size.width, progressImage.frame.size.height);
//    CGImageRef imageRef = CGImageCreateWithImageInRect([progressIMAGE CGImage], imgFrame);
//    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
//    CGImageRelease(imageRef);
//    
//    [progressImage setImage:subImage];

    
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    _sidebarButton.target = self.revealViewController;
    //    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
    

    
    _lastUpdateLabel.text=    [NSString stringWithFormat:@"Successfully updated @%@",([Helpers getLastUpdatedHomeScreen]==nil?@"Not Updated":[Helpers getLastUpdatedHomeScreen])];
    
    _userNameLabel.text=([Helpers getName]==nil?@"":[Helpers getName]);
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if ([[segue identifier] isEqualToString:@"showBook"]) {
//        ((SelectSationsViewController*)segue.destinationViewController).ScreenID=1;
//                ((SelectSationsViewController*)segue.destinationViewController).title=@"From";
//    }
}


#pragma mark -custom pickerDelegat


-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code
{
    //    [_timeButton setTitle:[NSString stringWithFormat:@"%@",selectedDate] forState:UIControlStateNormal];
}
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code
{
    
    switch (code) {
        case stationsCode:
            [_stationsButton setTitle:[selectedItem  objectForKey:@"station_name"] forState:UIControlStateNormal];
            
//            selectedStationindex=[stationsArray fi]
            selectedStationObject=[[NSDictionary alloc]initWithDictionary:selectedItem];
            [self refreshAction:nil];
            break;
            
        default:
            break;
    }
    
    [self enableOrDisablAll:YES];
    
}

-(NSString*)getTitleForRowInArray:(NSArray*)data andRow:(NSInteger)row{
    
    return [[data objectAtIndex:row] objectForKey:@"station_name"];
    
}

#pragma mark -getStationsBackground

-(void)loadAllStationsAndTimesAndDirectoins{
    stationsArray=[[NSMutableArray alloc]init];
    
    
    NSError *tempError;
    
    
    
    //    anyError=tempError;
    NSArray *tempArray=[WebServiceManagerAPI getAllSatationsWithErrorMessage:&tempError];
    
    
    if (tempArray==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    stationsArray=[[NSMutableArray alloc]initWithArray:tempArray];
    
    if (stationsArray.count>0) {
        [_stationsButton setTitle:[[stationsArray objectAtIndex:0] objectForKey:@"station_name"] forState:UIControlStateNormal ];
        selectedStationObject=[[NSDictionary alloc]initWithDictionary:[stationsArray objectAtIndex:0]];
        
        [Helpers addStationS:stationsArray];
        
        nilecodeAppDelegate   *appDelegate = (nilecodeAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        

        if (appDelegate.firstTime) {
            [self refreshAction:Nil];
            appDelegate.firstTime=NO;

        }else {
        
        [self processProgressBar:appDelegate];
        }
        
        
    }else{
        [_stationsButton setTitle:@"NO Stations Available" forState:UIControlStateNormal ];
        
    }
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
}


#pragma mark -buttons Enable handler

-(void)enableOrDisablAll:(BOOL)EnOrDisable{
    
    [_stationsButton setEnabled:EnOrDisable];
    
    
}



#pragma mark buttons action
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanAction:(id)sender {
    

    [self performSegueWithIdentifier:@"showScan" sender:self];
    

}

- (IBAction)bookAction:(id)sender {
    

    [self performSegueWithIdentifier:@"showBook" sender:self];
  
}

- (IBAction)mapsAction:(id)sender {

    [self performSegueWithIdentifier:@"showMap" sender:self];
    
}

- (IBAction)refreshAction:(id)sender {
    if (stationsArray.count<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must select station" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Helpers addSelectedStation:selectedStationObject];
    
    //start sync code
    
    
    [self performSelectorInBackground:@selector(processSyncServiceAndDB) withObject:nil];
    

}
- (IBAction)showStationsAction:(id)sender {
    if (stationsArray==Nil || stationsArray.count<=0) {

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self performSelectorInBackground:@selector(loadAllStationsAndTimesAndDirectoins) withObject:nil];
        

        return;
    }
    [self enableOrDisablAll:NO];
    
    customPickerView.itemsArray=stationsArray;
    customPickerView.titlee=@"Choose Station :";
    customPickerView.pickerType=type_itemsPicker;
    customPickerView.componentCode=stationsCode;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = customPickerView.frame;
    frame.origin.y =  frame.origin.y-frame.size.height-10;
    customPickerView.frame= frame;
    
    //    selectedStationObject=nil;
    [UIView commitAnimations];

}

#pragma mark -processSyncServiceAndDB

-(void)processSyncServiceAndDB{
    nilecodeAppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    //    [DBManager addTicketToDBWithTicket_id:@123 andDate:[NSDate date] andTime:@"1" andStationStartId:@11 andStationEndId:@12 andTicketType:@3 andReturnDate:[NSDate date] andReturnTime:@"33" withNSManagedObjectContext:self.managedObjectContext];
    
    NSError *errorDB;
    NSMutableArray *usedTicketsIds=[DBManager getAllUsedTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
    
    
    
    if (errorDB!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    NSString *stationID=[Helpers getSelectedStationID];
    
    
    NSError *tempError;
    
    
    
    //    anyError=tempError;
    NSArray *newTickets=[WebServiceManagerAPI gatAllNewTicketsWithSatationID:stationID andUsedTickets:usedTicketsIds withErrorMessage:&tempError];
    
    
    
    if (newTickets==nil && tempError!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:tempError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    
    
    
    BOOL ISallTicketsDeleted=[DBManager deleteAllTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
    
    
    if (!ISallTicketsDeleted && errorDB!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    
    for (NSDictionary *dicTicket in newTickets) {
        bool isAdded=[DBManager addTicketToDBWithT_email:[dicTicket objectForKey:@"email"] andT_from_name:[dicTicket objectForKey:@"from_station"] andt_idd:[dicTicket objectForKey:@"id"] andt_isUsed:[dicTicket objectForKey:@""] andt_mobile:[dicTicket objectForKey:@"mobile"] andt_name:[dicTicket objectForKey:@"name"] andt_num_tickets:[dicTicket objectForKey:@"number_of_tickets"] andt_rrn:[dicTicket objectForKey:@"rrn"] andt_ticket_type:[dicTicket objectForKey:@"ticket_type"] andt_to_name:[dicTicket objectForKey:@"to_station"] andt_trans_date:[dicTicket objectForKey:@"trans_date"] andt_trans_time:[dicTicket objectForKey:@"trans_time"] withNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDB];
        
        if (!isAdded && errorDB!=nil) {
            UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDB.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertNO show];
            
            
        }
        
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    NSString *stringDate = [dateFormat stringFromDate:[NSDate date]];
    
    
    [Helpers saveLastUpdatedHomeScreen:stringDate];
    
    /////

    
    NSDictionary *dd=[Helpers getSelectedStation];
    _lastUpdateLabel.text=[NSString stringWithFormat:@"Successfully updated @%@",stringDate];
    
    
    
    ///// handle the progress bar
    
    NSError *errorDBForCounting=nil;

    
    
    usedTicketsNumber=[DBManager getAllUsedTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDBForCounting].count;
    
    if (errorDBForCounting!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDBForCounting.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    allTicketsNumber=[DBManager getAllTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDBForCounting].count;
    if (errorDBForCounting!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDBForCounting.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    float f=usedTicketsNumber*1.0/(allTicketsNumber*1.0==0.0?1:allTicketsNumber*1.0);
    
    [self drawPercent:f forImageView:progressImageView];
    
    _numberPassengersLabel.text=[NSString stringWithFormat:@"%i/%i",usedTicketsNumber,allTicketsNumber];
    
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    
}


-(void)processProgressBar:(nilecodeAppDelegate* )appDelegate
{
        NSError *errorDBForCounting=nil;
//      = [UIApplication sharedApplication].delegate;

    usedTicketsNumber=[DBManager getAllUsedTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDBForCounting].count;
    
    if (errorDBForCounting!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDBForCounting.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    allTicketsNumber=[DBManager getAllTicketsWithNSManagedObjectContext:appDelegate.managedObjectContext withErrorMessage:errorDBForCounting].count;
    if (errorDBForCounting!=nil) {
        UIAlertView *alertNO=[[UIAlertView alloc]initWithTitle:@"Error" message:errorDBForCounting.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertNO show];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        return;
    }
    
    float f=usedTicketsNumber*1.0/(allTicketsNumber*1.0==0.0?1:allTicketsNumber*1.0);
    
    [self drawPercent:f forImageView:progressImageView];
    
    _numberPassengersLabel.text=[NSString stringWithFormat:@"%i/%i",usedTicketsNumber,allTicketsNumber];
    
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}
- (IBAction)goNextStation:(id)sender {
//    NSArray* aa=[stationsArray filteredArrayUsingPredicate:[NSPredicate                                                             predicateWithFormat:@"self == %@", selectedStationObject]];
    
    
    int ind=[stationsArray indexOfObject:selectedStationObject]+1;
    
    
    if (ind>-1 && ind< stationsArray.count) {
        [self itemSelected:[stationsArray objectAtIndex:ind] forComponentCode:stationsCode];

    }
    
    
}

- (IBAction)goPreviousStation:(id)sender {
    
    int ind=[stationsArray indexOfObject:selectedStationObject]-1;
    
    
    if (ind>-1 && ind< stationsArray.count) {
        [self itemSelected:[stationsArray objectAtIndex:ind] forComponentCode:stationsCode];
        
    }

}
@end
