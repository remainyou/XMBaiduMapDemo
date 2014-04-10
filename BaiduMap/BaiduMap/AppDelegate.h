//
//  AppDelegate.h
//  BaiduMap
//
//  Created by a on 14-3-3.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BMapTestViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
