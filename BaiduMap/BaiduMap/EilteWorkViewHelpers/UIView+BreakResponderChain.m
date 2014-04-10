//
//  UIView+BreakResponderChain.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "UIView+BreakResponderChain.h"

@implementation UIView (BreakResponderChain)

- (UIViewController *)viewController
{
    UIResponder *next = [self nextResponder];
    do{
        if([next isKindOfClass:[UIViewController class]]){
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }while(next!=nil);
    return nil;
}


@end
