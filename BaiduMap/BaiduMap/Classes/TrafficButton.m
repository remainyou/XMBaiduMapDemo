//
//  TrafficButton.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "TrafficButton.h"

@implementation TrafficButton

//代码方式创建
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [super initWithFrame:frame];
        if (self) {
            [self setBackgroundImage:[UIImage imageNamed:@"button_main_sel_background_light.png"] forState:UIControlStateNormal];
            
            [self setImage:[UIImage imageNamed:@"button_main_traffic_off.png"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"button_main_traffic_on.png"] forState:UIControlStateSelected];
        }
        return self;
    }
    return self;
}

//xib方式创建
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setBackgroundImage:[UIImage imageNamed:@"button_main_sel_background_light.png"] forState:UIControlStateNormal];
    
    [self setImage:[UIImage imageNamed:@"button_main_traffic_off.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"button_main_traffic_on.png"] forState:UIControlStateSelected];

}


- (void)setMapType:(BMKMapType)mapType
{
    switch (mapType) {
        case BMKMapTypeStandard:
            //标准
            self.selected = NO;
            break;
        case BMKMapTypeTrafficOn:
            //交通状况开启
            self.selected = YES;
            break;
        case BMKMapTypeSatellite:
            //卫星模式
            self.selected = NO;
            break;
        case BMKMapTypeTrafficAndSatellite:
            //卫星和交通混合模式
            self.selected = YES;
            break;
        default:
            break;
    }
    
}


@end
