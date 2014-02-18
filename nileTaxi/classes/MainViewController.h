//
//  MainViewController.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/12/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#define stationsCode 1

@interface MainViewController : UIViewController<SelectPickerDelegate>
{
    
    NSUInteger usedTicketsNumber;
    NSUInteger allTicketsNumber;
    
    
    CustomPicker *customPickerView;

    NSMutableArray *stationsArray;
    
    __weak IBOutlet UIImageView *progressImageView;
    

    NSDictionary *selectedStationObject;
    NSUInteger *selectedStationindex;

}
- (IBAction)goNextStation:(id)sender;
- (IBAction)goPreviousStation:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;

- (IBAction)showStationsAction:(id)sender;
@property int showNext;
- (IBAction)scanAction:(id)sender;
- (IBAction)bookAction:(id)sender;
- (IBAction)mapsAction:(id)sender;
- (IBAction)refreshAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stationsButton;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *PassengersprogressBar;
@property (weak, nonatomic) IBOutlet UILabel *numberPassengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
