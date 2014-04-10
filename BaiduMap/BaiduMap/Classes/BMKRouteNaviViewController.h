//
//  BMKRouteNaviViewController.h
//  BaiduMap
//
//  Created by xiangming on 14-4-8.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BMKBaseViewController.h"
#import "BMKNaviInputView.h"

@interface BMKRouteNaviViewController : BMKBaseViewController<BMKMapViewDelegate,
                                                         BMKSearchDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong)BMKSearch* search;

@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, strong) NSString *startAddress;

@property (nonatomic, strong) NSString *endAddress;
@property (nonatomic, strong) NSString *endCityName;

@property (nonatomic, strong) NSString *startCoordinateX;
@property (nonatomic, strong) NSString *startCoordinateY;

@property (nonatomic, strong) NSString *endCoordinateX;
@property (nonatomic, strong) NSString *endCoordinateY;

@end
