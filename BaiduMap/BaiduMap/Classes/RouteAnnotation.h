//
//  RouteAnnotation.h
//  BaiduMap
//
//  Created by xiangming on 14-4-8.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface RouteAnnotation : BMKPointAnnotation

@property (nonatomic, assign) 	int type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
@property (nonatomic, assign) 	int degree;

@end
