//
//  BMKTypeChooseView.h
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BMapKit.h"

enum {
    BMKMapChooseTypeStandard   = 1,               ///< 2d标准地图
    BMKMapChooseTypeSatellite  = 2,               ///< 卫星地图
    BMKMapChooseType3d = 3                        ///< 3d俯视图
};
typedef NSUInteger BMKMapChooseType;


@protocol BMKChooseDelegate <NSObject>

- (void)BMKChooseKind:(BMKMapChooseType)type;

@end


@interface BMKTypeChooseView : UIView

@property (nonatomic, assign)BMKMapChooseType choosType;
@property (nonatomic, assign) id<BMKChooseDelegate>delegate;

@end
