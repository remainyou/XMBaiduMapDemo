//
//  BaiduMapMacro.h
//  BaiduMap
//
//  Created by xiangming on 14-4-8.
//  Copyright (c) 2014年 a. All rights reserved.
//

#ifndef  BaiduMapMacro_H
#define  BaiduMapMacro_H
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define DEVICE_WIDTH       [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#define APPLICATION_WIDTH  [[UIScreen mainScreen] applicationFrame].size.width
#define APPLICATION_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height

#endif
