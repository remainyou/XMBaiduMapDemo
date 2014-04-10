//
//  LocationModel.h
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic, strong) NSString *startCityName;       //导航起始城市
@property (nonatomic, strong) NSString *startAddress;        //导航起始地址

@property (nonatomic, strong) NSString *endAddress;          //导航目的地城市
@property (nonatomic, strong) NSString *endCityName;         //导航目的地地址

@property (nonatomic, strong) NSString *startCoordinateX;    //导航起始纬度
@property (nonatomic, strong) NSString *startCoordinateY;    //导航起始经度

@property (nonatomic, strong) NSString *endCoordinateX;      //导航目的地纬度
@property (nonatomic, strong) NSString *endCoordinateY;      //导航目的地经度


@end
