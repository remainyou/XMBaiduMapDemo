//
//  GPSLocationButton.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "GPSLocationButton.h"

@implementation GPSLocationButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"button_main_background"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setBackgroundImage:[UIImage imageNamed:@"button_main_background"] forState:UIControlStateNormal];
}


- (void)setTrackMode:(BMKUserTrackingMode)trackMode
{
    UIImage*image;
    switch (trackMode) {
        case BMKUserTrackingModeNone:
            //默认
              image = [UIImage imageNamed:@"icon_location_button.png"];
            break;
        case BMKUserTrackingModeFollow:
            //跟随
               image = [UIImage imageNamed:@"icon_location_fixed.png"];
            break;
        case BMKUserTrackingModeFollowWithHeading:
            //罗盘
               image = [UIImage imageNamed:@"icon_location_compass.png"];
            break;
        default:
            break;
    }
    [self setImage:image forState:UIControlStateNormal];
}



@end
