//
//  CustomPicker.h
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/14/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define type_DatePicker 1
#define type_itemsPicker 2
@protocol SelectPickerDelegate <NSObject>

-(void)dateSelected:(NSDate *)selectedDate forComponentCode:(int )code;
-(void)itemSelected:(id)selectedItem forComponentCode:(int )code;

@end
@interface CustomPicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *itemsPicker;
    UIDatePicker *datePicker;
    
}
@property(nonatomic)int componentCode;
@property(nonatomic) int pickerType;
@property(nonatomic, retain) id<SelectPickerDelegate> callerDelegate;
@property (nonatomic,retain)    NSMutableArray *itemsArray;


- (IBAction)DoneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pivkerContainer;

@end
