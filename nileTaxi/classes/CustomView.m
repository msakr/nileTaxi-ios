//
//  CustomView.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/8/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"aaaa");
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *navBg = [UIImage imageNamed:@"main-bg.jpg"];
    [navBg drawInRect:rect];
}


@end
