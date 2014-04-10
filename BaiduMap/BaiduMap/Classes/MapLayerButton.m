//
//  MapLayerButton.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "MapLayerButton.h"

@implementation MapLayerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"button_main_sel_background_light.png"] forState:UIControlStateNormal];
        self.mapType = BMKMapTypeStandard;
        [self setImage:[UIImage imageNamed:@"button_main_layer.png"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setBackgroundImage:[UIImage imageNamed:@"button_main_sel_background_light.png"] forState:UIControlStateNormal];
    self.mapType = BMKMapTypeStandard;
    [self setImage:[UIImage imageNamed:@"button_main_layer.png"] forState:UIControlStateNormal];
}



@end
