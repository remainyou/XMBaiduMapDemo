//
//  UIImage+Rotate.m
//  BaiduMap
//
//  Created by xiangming on 14-4-8.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "UIImage+Rotate.h"

@implementation UIImage (Rotate)


- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
	CGSize rotatedSize = self.size;
	if ([self isRetina]) {
		rotatedSize.width *= 2;
		rotatedSize.height *= 2;
	}
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

- (BOOL)isRetina
{
    BOOL retina = NO;
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
	if (((screenSize.width >= 639.9f))
		&& (fabs(screenSize.height >= 959.9f)))
	{
		retina = TRUE;
	}
    return retina;
}

@end
