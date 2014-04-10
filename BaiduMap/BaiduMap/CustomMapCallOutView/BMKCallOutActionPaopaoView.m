//
//  BMKCallOutActionPaopaoView.m
//  BaiduMap
//
//  Created by xiangming on 14-4-9.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKCallOutActionPaopaoView.h"
#import <QuartzCore/QuartzCore.h>

#define  ARROR_HEIGHT 15 //泡泡三角高度

//定义绘制泡泡的私有函数
@interface BMKCallOutActionPaopaoView()

-(void)drawInContext:(CGContextRef)context;
- (void)getDrawPath:(CGContextRef)context;

@end


@implementation BMKCallOutActionPaopaoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithCustomView:(UIView *)customView
{
    self = [super initWithCustomView:customView];
    if(self){
           customView.height = 64;
    }
    return self;
}


//利用上下文绘制
-(void)drawInContext:(CGContextRef)context
{
	
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
    //    CGContextSetLineWidth(context, 1.0);
    //     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //    [self getDrawPath:context];
    //    CGContextStrokePath(context);
    
}


//获取泡泡绘制路径
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
	CGFloat radius = 6.0;
    
	CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect),
    // midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect)-ARROR_HEIGHT;
    CGContextMoveToPoint(context, midx+ARROR_HEIGHT, maxy);
    CGContextAddLineToPoint(context,midx, maxy+ARROR_HEIGHT);
    CGContextAddLineToPoint(context,midx-ARROR_HEIGHT, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

//重写其绘制函数
- (void)drawRect:(CGRect)rect
{
	[self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    //  self.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}


@end
