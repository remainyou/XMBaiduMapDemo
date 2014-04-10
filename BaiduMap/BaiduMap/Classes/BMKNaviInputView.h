//
//  BMKNaviInputView.h
//  BaiduMap
//
//  Created by xiangming on 14-4-10.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface BMKNaviInputView : UIView

@property (nonatomic, strong) LocationModel *myLocation;  //我的位置
@property (nonatomic, strong) LocationModel *desLocation; //目的位置

@end
