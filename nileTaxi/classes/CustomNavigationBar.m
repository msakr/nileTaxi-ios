//
//  CustomNavigationBar.m
//  nileTaxi
//
//  Created by mohamed sakr macBook on 2/8/14.
//  Copyright (c) 2014 mohamed sakr. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    [self setBackgroundImage:[UIImage imageNamed: @"bar.png"]
//                                                  forBarMetrics:UIBarMetricsDefault];
    
    // Drawing code
    UIImage *navBg = [UIImage imageNamed:@"bar_yello.png"];
    [navBg drawInRect:rect];
}


@end
