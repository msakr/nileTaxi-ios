//
//  CustomPicker.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 1/14/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "CustomPicker.h"

@implementation CustomPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)setPickerType:(int)pickerType{
    
    _pickerType=pickerType;
    
    switch (_pickerType) {
        case type_DatePicker:
            [self createDatePicker];
            break;
        case type_itemsPicker:
            [self createItemsPicker];
            break;
            
        default:
            break;
    }
    
    
}


#pragma custom picker creation

-(void)createDatePicker
{

    if (datePicker==nil) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, _pivkerContainer.frame.size.width, _pivkerContainer.frame.size.height)];

    }
    
	datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.date = [NSDate date];
    
    [[_pivkerContainer subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];


    [_pivkerContainer addSubview:datePicker];



}
-(void)createItemsPicker
{
    
    if (itemsPicker==nil) {
        itemsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0, _pivkerContainer.frame.size.width, _pivkerContainer.frame.size.height)];
        
    }
    
    
    [itemsPicker selectRow:-1 inComponent:0 animated:YES];

    
    itemsPicker.dataSource=self;
    itemsPicker.delegate=self;
    [[_pivkerContainer subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [_pivkerContainer addSubview:itemsPicker];
    
    
    
}


#pragma items picker delegaes

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_itemsArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    return [_itemsArray objectAtIndex:row];
    
}




#pragma buttons actions

- (IBAction)DoneAction:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = self.frame;
    frame.origin.y =     frame.origin.y+frame.size.height+10;
    self.frame = frame;
    [UIView commitAnimations];
    
    switch (_pickerType) {
        case type_DatePicker:
            [_callerDelegate dateSelected:datePicker.date forComponentCode:_componentCode];
            break;
        case type_itemsPicker:
            [_callerDelegate itemSelected:[_itemsArray objectAtIndex:[itemsPicker selectedRowInComponent:0]] forComponentCode:_componentCode];
            break;
            
        default:
            break;
    }
    
    
    
}
@end
