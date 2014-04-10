//
//  BMKBaseViewController.h
//  BaiduMap
//
//  Created by xiangming on 14-4-10.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMKBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isBackButton;
@property (nonatomic, assign) BOOL isCancelButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *cancleButton;

- (void)backAction:(id)sender;
- (void)cancleAction:(id)sender;
@end
