//
//  BMKTypeChooseView.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKTypeChooseView.h"

@implementation BMKTypeChooseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,38, self.width, self.height)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [[UIImage imageNamed:@"button_main_sel_background_2.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:5];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        imageView.tag = 100;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(self.width-40, 0, 38, 38);
        [button setImage:[UIImage imageNamed:@"button_main_layer_close.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"button_main_sel_background_1.png"] forState:UIControlStateNormal];
        [self addSubview:button];
        
        NSArray *array = [NSArray arrayWithObjects:@"map_setting_view_btn_satellite.png",
                          @"map_setting_view_btn_normal.png",
                          @"map_setting_view_btn_3D.png",nil];
        for (int i=0; i<3; i++) {
            NSString *image = array[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i*94+10,42,90,60);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 88, 58)];
            imageView.image = [UIImage imageNamed:image];
            
            imageView.backgroundColor = [UIColor clearColor];
            imageView.userInteractionEnabled = NO;
            [button addSubview:imageView];
            
            button.tag = 1000+i;
            UILabel *label = [[UILabel alloc] initWithFrame:button.frame];
            label.top =button.bottom+2;
            label.height = 20;
            label.textAlignment = NSTextAlignmentCenter;
            
            
            if(i==0){
                label.text = @"卫星图";
            }
            else if(i==1){
                label.text = @"2D平面图";
            }
            else{
                label.text = @"3D俯视图";
            }
            label.font = [UIFont boldSystemFontOfSize:14.0f];
            label.backgroundColor = [UIColor clearColor];
            [button setBackgroundImage:[[UIImage imageNamed:@"map_setting_view_btn_highlighted.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateSelected];
            [self addSubview:button];
            [self addSubview:label];
        }

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
   
}

- (void)chooseAction:(UIButton *)button
{
    button.selected = YES;
    switch (button.tag) {
        case 1000:
            self.choosType = BMKMapChooseTypeSatellite;
            break;
        case 1001:
            self.choosType = BMKMapChooseTypeStandard;
            break;
        case 1002:
            self.choosType = BMKMapChooseType3d;
            break;
        default:
            break;
    }

    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(BMKChooseKind:)]){
            [self.delegate BMKChooseKind:self.choosType];
        }
    }

}

- (void)setChoosType:(BMKMapChooseType)choosType
{
    _choosType = choosType;
    if(choosType==BMKMapChooseTypeStandard){
        UIButton *buttonSatellite = (UIButton *)[self viewWithTag:1000];
        UIButton *button3d = (UIButton *)[self viewWithTag:1002];
        UIButton *buttonStandard = (UIButton *)[self viewWithTag:1001];
        buttonStandard.selected = YES;
        button3d.selected = NO;
        buttonSatellite.selected = NO;
    
        
    }
    else if(choosType == BMKMapChooseTypeSatellite){
        UIButton *buttonSatellite = (UIButton *)[self viewWithTag:1000];
        UIButton *button3d = (UIButton *)[self viewWithTag:1002];
        UIButton *buttonStandard = (UIButton *)[self viewWithTag:1001];
        buttonStandard.selected = NO;
        buttonSatellite.selected = YES;
        button3d.selected = NO;
    }
    else{
        UIButton *buttonSatellite = (UIButton *)[self viewWithTag:1000];
        UIButton *button3d = (UIButton *)[self viewWithTag:1002];
        UIButton *buttonStandard = (UIButton *)[self viewWithTag:1001];
        buttonSatellite.selected = NO;
        buttonStandard.selected = NO;
        button3d.selected = YES;
            
    }

}


- (void)closeAction:(UIButton *)button
{
    [self.superview removeFromSuperview];
}


@end
