//
//  BMKRouteNaviViewController.m
//  BaiduMap
//
//  Created by xiangming on 14-4-8.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMKRouteNaviViewController.h"
#import "RouteAnnotation.h"



@interface BMKRouteNaviViewController ()

@property (nonatomic,retain)UIView* chooseView;

@property (nonatomic,assign)NSInteger selectIndex;


@end

@implementation BMKRouteNaviViewController

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}


//测试数据
- (void)test
{
	_startCityName = @"北京";
    _startAddress = @"天安门";
	_startCoordinateX = @"116.403981";
	_startCoordinateY = @"39.915101";
	_endCityName = @"北京";
    _endAddress = @"百度大厦";
	_endCoordinateX= @"116.307827";
	_endCoordinateY = @"40.056957";
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
    
    self.selectIndex = 0;
    [self initRouteNaviBar];
    _search = [[BMKSearch alloc]init];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    _search.delegate = self;
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
    _search.delegate = nil;
    [_mapView viewWillDisappear];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化路线选择条件视图
- (void)initRouteNaviBar
{
    self.selectIndex = 0;
    _chooseView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 180, 44)];
    _chooseView.backgroundColor = [UIColor clearColor];
    
    
    
    NSArray *imagesArray = @[
                            @[@"icon_navibar_bus.png",@"icon_navibar_bus_highlighted.png"],
                            @[@"icon_navibar_car.png",@"icon_navibar_car_highlighted.png"],
                            @[@"icon_navibar_foot.png",@"icon_navibar_foot_highlighted.png"]
                            ];
    
    for (int i = 0; i < 3; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 333+i;
        NSString *imageNormal;
        NSString *imageHighlight;
        NSArray *array = [imagesArray objectAtIndex:i];
        imageNormal  = array[0];
        imageHighlight = array[1];
        [button setBackgroundImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imageHighlight] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:imageHighlight] forState:UIControlStateSelected];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        //button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        button.frame = CGRectMake(60*i+20, 10, 24, 24);
        [button addTarget:self action:@selector(chooseToDestinationKind:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == _selectIndex) {
            button.selected = YES;
        }
        else
        {
            button.selected = NO;
        }
        
        [_chooseView addSubview:button];
    }
    self.navigationItem.titleView = _chooseView;
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 44, 32);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[[UIImage imageNamed:@"search_edit_bar_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    BMKNaviInputView *bmkInputView = [[BMKNaviInputView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    bmkInputView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bmkInputView];
    
    
}


- (void)searchAction:(UIButton *)button
{
    
}

//按钮事件
- (void)chooseToDestinationKind:(UIButton*)button
{
    UIButton* buttonOne = (UIButton*)[button.superview viewWithTag:333];
    UIButton* buttonTwo = (UIButton*)[button.superview viewWithTag:334];
    UIButton* buttonThree = (UIButton*)[button.superview viewWithTag:335];
    
    if (button.tag == 333) {
        buttonOne.selected = YES;
        buttonTwo.selected = NO;
        buttonThree.selected = NO;
        [self onClickBusSearch];
    }
    else if (button.tag == 334)
    {
        buttonOne.selected = NO;
        buttonTwo.selected = YES;
        buttonThree.selected = NO;
        [self onClickDriveSearch];
    }
    else if (button.tag == 335)
    {
        buttonOne.selected = NO;
        buttonTwo.selected = NO;
        buttonThree.selected = YES;
        [self onClickWalkSearch];
    }
}


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		default:
			break;
	}
	
	return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}


- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetTransitRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKTransitRoutePlan* plan = (BMKTransitRoutePlan*)[result.plans objectAtIndex:0];
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.startPt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
        
		item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.endPt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
		
		int size = [plan.lines count];
		int index = 0;
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			index += line.pointsCount;
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					index += len;
				}
				break;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			memcpy(points + index, line.points, line.pointsCount * sizeof(BMKMapPoint));
			index += line.pointsCount;
			
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOnStopPoiInfo.pt;
			item.title = line.tip;
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			
			[_mapView addAnnotation:item];
			route = [plan.routes objectAtIndex:i+1];
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOffStopPoiInfo.pt;
			item.title = route.tip;
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			[_mapView addAnnotation:item];
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
					memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
					index += len;
				}
				break;
			}
		}
		
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
}


- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetDrivingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
		
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
	
}

- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetWalkingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
        
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
}

- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
}


- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    
    
}

-(void)onClickBusSearch
{
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordinateX != nil && _startCoordinateY!= nil) {
		startPt = (CLLocationCoordinate2D){[_startCoordinateY floatValue], [_startCoordinateX  floatValue]};
	}
	if (_endCoordinateX != nil && _endCoordinateY!= nil) {
		endPt = (CLLocationCoordinate2D){[_endCoordinateY floatValue], [_endCoordinateX floatValue]};
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
    
	start.name = _startAddress;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddress;
    
	BOOL flag = [_search transitSearch:_startCityName startNode:start endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}
    
}

-(void)onClickDriveSearch
{
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordinateX != nil && _startCoordinateY!= nil) {
		startPt = (CLLocationCoordinate2D){[_startCoordinateY floatValue], [_startCoordinateX  floatValue]};
	}
	if (_endCoordinateX != nil && _endCoordinateY!= nil) {
		endPt = (CLLocationCoordinate2D){[_endCoordinateY floatValue], [_endCoordinateX floatValue]};
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
    
	start.name = _startAddress;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddress;
    
	BOOL flag = [_search drivingSearch:_startCityName startNode:start endCity:_endCityName endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}
    
	
}

-(void)onClickWalkSearch
{
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordinateX != nil && _startCoordinateY!= nil) {
		startPt = (CLLocationCoordinate2D){[_startCoordinateY floatValue], [_startCoordinateX  floatValue]};
	}
	if (_endCoordinateX != nil && _endCoordinateY!= nil) {
		endPt = (CLLocationCoordinate2D){[_endCoordinateY floatValue], [_endCoordinateX floatValue]};
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
    
	start.name = _startAddress;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddress;
    
	BOOL flag = [_search walkingSearch:_startCityName startNode:start endCity:_endCityName endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}
    
	
}


@end
