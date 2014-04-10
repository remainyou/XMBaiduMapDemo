//
//  BMKNaviInputView.m
//  BaiduMap
//
//  Created by xiangming on 14-4-10.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKNaviInputView.h"
#import <QuartzCore/QuartzCore.h>

@interface TipView : UIView

@property (nonatomic, assign)BOOL isStart;           //是否是目的地
@property (nonatomic, strong) NSString *address; //目的地地址
@property (nonatomic, assign)BOOL isMyLocation;  //是否是我的位置


@end

@implementation TipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22.5, 12, 12)];
        imageView.tag = 100;
        imageView.userInteractionEnabled = NO;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_route_st.png"];
        imageView.highlightedImage = [UIImage imageNamed:@"icon_route_end.png"];
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+5, self.height/2-15, 240, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.tag = 101;
        [self addSubview:label];
        
    }
    return self;
}

- (void)setIsStart:(BOOL)isStart
{
    _isStart = isStart;
    UIImageView *imagView = (UIImageView *)[self viewWithTag:100];
    if(_isStart)
    {
        imagView.highlighted = NO;
    }
    else{
        imagView.highlighted = YES;
    }
    
}

- (void)setIsMyLocation:(BOOL)isMyLocation
{
    _isMyLocation = isMyLocation;
    UILabel *label = (UILabel*)[self viewWithTag:101];
    if(_isMyLocation){
        label.textColor = [UIColor blueColor];
    }
    else{
        label.textColor = [UIColor blackColor];
    }
}
- (void)setAddress:(NSString *)address
{
    _address = address;
    UILabel *label = (UILabel*)[self viewWithTag:101];
    label.text = _address;
}

@end


@implementation BMKNaviInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
        UIButton *routeChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [routeChangeButton setImage:[UIImage imageNamed:@"icon_route_change.png"] forState:UIControlStateNormal];
        [routeChangeButton setImage:[UIImage imageNamed:@"icon_route_change_select.png"] forState:UIControlStateHighlighted];
        [routeChangeButton addTarget:self action:@selector(routeChange:) forControlEvents:UIControlEventTouchUpInside];
        routeChangeButton.frame = CGRectMake(10, 37.5, 25, 25);
        
        [self addSubview:routeChangeButton];
        
        
        UIButton *myLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myLocationButton.frame = CGRectMake(40, 0, 250, 60);
        
        TipView *myTipView = [[TipView alloc] initWithFrame:CGRectMake(0, 0, 250, 60)];
        myTipView.backgroundColor = [UIColor clearColor];
        myTipView.isStart = YES;
        myTipView.isMyLocation = YES;
        myTipView.address = @"我的位置";
        [myLocationButton addSubview:myTipView];
        
        [self addSubview:myLocationButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(40, 59, 260,1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    
        UIButton *mapLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mapLocationButton.frame = CGRectMake(40, 60, 250, 250);
        TipView *mapLocationTipView = [[TipView alloc] initWithFrame:CGRectMake(0, 0, 250, 60)];
        mapLocationTipView.backgroundColor = [UIColor clearColor];
        mapLocationTipView.isStart = NO;
        mapLocationTipView.isMyLocation = NO;
        mapLocationTipView.address = @"地图上的位置";
        [mapLocationButton addSubview:mapLocationTipView];
        
        [self addSubview:mapLocationButton];
    }
    return self;
}



- (void)routeChange:(UIButton *)button
{
    
}


@end
