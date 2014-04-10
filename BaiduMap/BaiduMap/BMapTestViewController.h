//
//  BMapTestViewController.h
//  BaiduMap
//
//  Created by a on 14-3-3.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "TrafficButton.h"
#import "MapLayerButton.h"
#import "GPSLocationButton.h"
#import "BMKBaseViewController.h"

@interface BMapTestViewController : BMKBaseViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    NSMutableArray *annotaionsArray;
    BOOL isBlue;
    UIView *currentPaopaoView;
    CGRect paoPaoOriginFrame;
    BMKAnnotationView *currentSelectedAnnot;
    CGPoint lastCallOutPoint;
}
@property (weak, nonatomic) IBOutlet TrafficButton *trafficButton;
@property (weak, nonatomic) IBOutlet MapLayerButton *mapLayerButton;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet GPSLocationButton *gpsLocationButton;
@property (strong, nonatomic) BMKSearch *search;

- (IBAction)isOnSatellite:(UISwitch *)sender;
- (IBAction)showPinOnMap:(UIButton *)sender;
- (IBAction)cleanPinOnMap:(UIButton *)sender;
- (IBAction)updateUserLocation:(id)sender;
- (IBAction)trafficButtonAction:(id)sender;
- (IBAction)mapLayerButtonAction:(id)sender;

@end
