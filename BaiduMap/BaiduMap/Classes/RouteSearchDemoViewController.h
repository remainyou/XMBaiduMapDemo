//
//  RouteSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface RouteSearchDemoViewController : UIViewController<BMKMapViewDelegate, BMKSearchDelegate> {

}

@property (nonatomic, weak) IBOutlet BMKMapView* mapView;
@property (nonatomic, weak) IBOutlet UITextField* startCityText;
@property (nonatomic, weak) IBOutlet UITextField* startAddrText;
@property (nonatomic, weak) IBOutlet UITextField* startCoordainateXText;
@property (nonatomic, weak) IBOutlet UITextField* startCoordainateYText;
@property (nonatomic, weak) IBOutlet UITextField* endCityText;
@property (nonatomic, weak) IBOutlet UITextField* endAddrText;
@property (nonatomic, weak) IBOutlet UITextField* endCoordainateXText;
@property (nonatomic, weak) IBOutlet UITextField* endCoordainateYText;
@property (nonatomic, strong)BMKSearch* search;

-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
-(IBAction)onClickWalkSearch;

@end
