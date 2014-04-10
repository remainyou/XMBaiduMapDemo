//
//  BMapTestViewController.m
//  BaiduMap
//
//  Created by a on 14-3-3.
//  Copyright (c) 2014年 a. All rights reserved.
//

#import "BMapTestViewController.h"
#import "RouteSearchDemoViewController.h"
#import "BMKRouteNaviViewController.h"
#import "BMKLayoutCell.h"
#import "BMKCallOutActionPaopaoView.h"
#import "BMKTypeChooseView.h"

#define DETAIL_VIEW_WIDTH 340

@interface BMapTestViewController ()<BMKChooseDelegate>
{
    bool isGeoSearch;
}
@property(nonatomic, strong) BMKCircle* circle;

@end

@implementation BMapTestViewController

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
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    annotaionsArray = [NSMutableArray array];
    _mapView.showsUserLocation = YES;
    _mapView.showMapScaleBar = YES;
    _search = [[BMKSearch alloc] init];
    _search.delegate = self;
    _mapView.delegate = self;
    
    [self showPins];
    
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



-(void)onClickReverseGeocode
{
    isGeoSearch = false;
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){self.mapView.userLocation.coordinate.longitude, self.mapView.userLocation.coordinate.latitude};
	BOOL flag = [_search reverseGeocode:pt];
	if (flag) {
		NSLog(@"ReverseGeocode search success.");
        
	}
    else{
        NSLog(@"ReverseGeocode search failed!");
    }
}

- (void)showPins
{
    [annotaionsArray removeAllObjects];
    for (int i = 1; i != 11; i++) {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404 + 0.03 * i;
        annotation.coordinate = coor;
        //annotation.title = [NSString stringWithFormat:@"这里是北京%d", i];
        [_mapView addAnnotation:annotation];
        [annotaionsArray addObject:annotation];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)isOnSatellite:(UISwitch *)sender {
    [_mapView setMapType:sender.on ? BMKMapTypeSatellite : BMKMapTypeStandard];
}

- (IBAction)showPinOnMap:(UIButton *)sender {
    if (annotaionsArray.count > 0) {
        [_mapView removeAnnotations:annotaionsArray];
    }
    [self showPins];
}

- (IBAction)cleanPinOnMap:(UIButton *)sender {
    if (annotaionsArray.count > 0) {
        [_mapView removeAnnotations:annotaionsArray];
    }
    [annotaionsArray removeAllObjects];
}

- (IBAction)updateUserLocation:(id)sender {
    //定位成功后，可以通过mapView.userLocation来获取位置数据。您也可以通过以下代码来使用定位三态效果，包括普通态、跟随态和罗盘态：
    if(_mapView.userTrackingMode == BMKUserTrackingModeNone)
    {
            [self startFollowing:sender];
    }
    else if(_mapView.userTrackingMode == BMKUserTrackingModeFollow){
        [self startFollowHeading:sender];
    }
    else{
        [self startLocation:nil];
    }
    ((GPSLocationButton *)sender).trackMode = self.mapView.userTrackingMode;

}

- (IBAction)trafficButtonAction:(id)sender {
    
    TrafficButton *button = (TrafficButton *)sender;
    switch (self.mapView.mapType) {
        case BMKMapTypeStandard:
                //标准
            {
                if(!button.selected){
                    self.mapView.mapType = BMKMapTypeTrafficOn;
                    ((TrafficButton *)sender).mapType = self.mapView.mapType;
                    
                }

            }
            break;
        case BMKMapTypeTrafficOn:
        {
            if(button.selected){
                self.mapView.mapType = BMKMapTypeStandard;
                ((TrafficButton *)sender).mapType = self.mapView.mapType;
            }
        }
            break;
        case BMKMapTypeSatellite:
            {
                if(!button.selected)
                {
                    self.mapView.mapType = BMKMapTypeTrafficAndSatellite;
                    ((TrafficButton *)sender).mapType = self.mapView.mapType;
                    
                }
            }
            break;
            
        case BMKMapTypeTrafficAndSatellite:
            //卫星和交通混合模式
            {
                if(button.selected)
                self.mapView.mapType = BMKMapTypeSatellite;
                ((TrafficButton *)sender).mapType = self.mapView.mapType;
            }
            
            break;
            
        default:
            break;
    }

   
}

- (IBAction)mapLayerButtonAction:(id)sender {
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    containerView.height = DEVICE_HEIGHT;
    MapLayerButton *button = (MapLayerButton *)sender;
    CGRect rect = [button convertRect:button.frame toView:self.view];
                   
    containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    BMKTypeChooseView *bmkTypeChooseView = [[BMKTypeChooseView alloc] initWithFrame:CGRectMake(10, rect.origin.y,300, 100)];
    bmkTypeChooseView.delegate = self;
   
    
    [containerView addSubview:bmkTypeChooseView];
    [[UIApplication sharedApplication].keyWindow addSubview:containerView];
    
    
    if(self.mapView.overlooking !=0){
        bmkTypeChooseView.choosType = BMKMapChooseType3d;
        
    }
    else{
        if(self.mapView.mapType == BMKMapTypeStandard){
            bmkTypeChooseView.choosType = BMKMapChooseTypeStandard;
    
        }
        else if(self.mapView.mapType == BMKMapTypeSatellite){
            bmkTypeChooseView.choosType = BMKMapChooseTypeSatellite;
            self.trafficButton.selected = YES;
            
        }
        else if(self.mapView.mapType == BMKMapTypeTrafficOn){
            self.trafficButton.selected = YES;
        }
        else
        {
            bmkTypeChooseView.choosType = BMKMapChooseType3d;
        }
    }

    

}

#pragma mark - 
#pragma mark - BMKChooseDelegate

- (void)BMKChooseKind:(BMKMapChooseType)type
{
    switch (type) {
        case BMKMapChooseTypeSatellite:
            if(self.trafficButton.selected)
            self.mapView.mapType = BMKMapTypeTrafficAndSatellite;
            else
            self.mapView.mapType = BMKMapTypeSatellite;
            break;
        case BMKMapChooseTypeStandard:
            if(!self.trafficButton.selected){
                self.mapView.mapType = BMKMapTypeStandard;
            }
            else{
                  self.mapView.mapType = BMKMapTypeTrafficOn;
            }
            break;
        case BMKMapChooseType3d:
        {
            self.mapView.rotation = 90;
            self.mapView.overlooking = -30;
        
        }
            break;
        default:
            break;
    }
}

//普通态
-(void)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

//跟随态
-(void)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

//罗盘态
-(void)startFollowHeading:(id)sender
{
    NSLog(@"进入罗盘态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
}


#pragma mark - MapView Delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        

        BMKPinAnnotationView *newAnnotationView =
        [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        
        BMKLayoutCell *paopaoParentView = [[[NSBundle mainBundle] loadNibNamed:@"BMKLayoutCell" owner:self options:nil] objectAtIndex:0];
        paopaoParentView.backgroundColor = [UIColor clearColor];
        paopaoParentView.height = 80;
        
        UIButton *paopaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [paopaoButton setFrame:CGRectMake(0, 0, 200, 44)];
        [paopaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [paopaoButton setBackgroundColor:[UIColor clearColor]];
        [paopaoButton addTarget:self action:@selector(tapBubbleView:) forControlEvents:UIControlEventTouchUpInside];
        
        [paopaoButton setTitle: annotation.title forState:UIControlStateNormal];
        [paopaoParentView addSubview:paopaoButton];
        
        BMKCallOutActionPaopaoView *paopaoView = [[BMKCallOutActionPaopaoView alloc] initWithCustomView:paopaoParentView];
        paopaoView.backgroundColor = [UIColor clearColor];
        newAnnotationView.paopaoView = paopaoView;
        newAnnotationView.image = [UIImage imageNamed:@"icon_paopao_waterdrop_streetscape"];
        
        //用户位置用其他位置图片表示
        if(((BMKPointAnnotation *)annotation).coordinate.latitude == self.mapView.userLocation.coordinate.latitude && ((BMKPointAnnotation *)annotation).coordinate.longitude == self.mapView.userLocation.coordinate.longitude){
            newAnnotationView.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath:@"images/bnavi_icon_location_fixed.png"]];
            paopaoView.height = 44;
        }
        return newAnnotationView;
    }
    return nil;
}


- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if([overlay isKindOfClass:[BMKCircle class]]) {
		// Create the view for the radius overlay.
		BMKCircleView *circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
		circleView.strokeColor = [UIColor purpleColor];
		circleView.fillColor = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
		return circleView;
	}
	
	return nil;
}

- (NSString*)getMyBundlePath:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (void)tapBubbleView:(UIButton *)button
{
    
    if(IS_IPAD){//iPad上的效果
    button.userInteractionEnabled = NO;
    UIView *parentPaopao = [button superview];
//    isBlue = !isBlue;
    // 当前选中的泡泡
    currentPaopaoView = parentPaopao;
//    [parentPaopao setBackgroundColor:isBlue ? [UIColor blueColor] : [UIColor orangeColor]];
    
    // 移动map保持泡泡完整
    CGRect pinFrame = currentSelectedAnnot.frame;
    
    CGRect paopaoFrame = currentSelectedAnnot.paopaoView.frame;
    paoPaoOriginFrame = paopaoFrame;
    

    if (pinFrame.origin.x > 1024 - DETAIL_VIEW_WIDTH) {
        [UIView animateWithDuration:0.55 animations:^{
            currentSelectedAnnot.paopaoView.frame = CGRectMake(pinFrame.origin.x - paopaoFrame.size.width - 10, paopaoFrame.origin.y, paopaoFrame.size.width, paopaoFrame.size.height);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.5 animations:^{
                            currentSelectedAnnot.paopaoView.frame = CGRectMake(currentSelectedAnnot.paopaoView.frame.origin.x, 60, currentSelectedAnnot.paopaoView.frame.size.width, 648);
                        } completion:^(BOOL finished) {
                            currentSelectedAnnot.calloutOffset = CGPointMake((-1) * paopaoFrame.size.width / 2 - 20, (_mapView.frame.size.height - 60) - pinFrame.origin.y);
                            button.userInteractionEnabled = YES;
                        }];
        }];
    }
    else {
        [UIView animateWithDuration:0.55 animations:^{
            currentSelectedAnnot.paopaoView.frame = CGRectMake(pinFrame.origin.x + pinFrame.size.width + 10, paopaoFrame.origin.y, paopaoFrame.size.width, paopaoFrame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                currentSelectedAnnot.paopaoView.frame = CGRectMake(currentSelectedAnnot.paopaoView.frame.origin.x, 60, currentSelectedAnnot.paopaoView.frame.size.width, 648);
                
            } completion:^(BOOL finished) {
                currentSelectedAnnot.calloutOffset =  CGPointMake(paopaoFrame.size.width / 2 + 20, (_mapView.frame.size.height - 60) - pinFrame.origin.y);
                button.userInteractionEnabled = YES;
            }];
        }];
    }

//    CGFloat paopaoOffsetX = ;
    

    
//    BMKAnnotationView *bubbleView = (BMKAnnotationView *)tap.view;
//    bubbleView.frame = CGRectMake(bubbleView.frame.origin.x - 200, bubbleView.frame.origin.y, bubbleView.frame.size.width, bubbleView.frame.size.height + 200);
    }
    else{//iPhone上的效果点击气泡，气泡消失直接导航。
        //传入两个参数1.用户的按位置；2.气泡视图的位置
//        RouteSearchDemoViewController *bmkRouteVC = [[RouteSearchDemoViewController  alloc] initWithNibName:@"RouteSearchDemoViewController" bundle:nil];
//        [self.navigationController pushViewController:bmkRouteVC animated:YES];
        BMKRouteNaviViewController *bmkRouteVC = [[BMKRouteNaviViewController  alloc]
                                                  initWithNibName:@"BMKRouteNaviViewController" bundle:nil];
        bmkRouteVC.isBackButton = YES;
        [self.navigationController pushViewController:bmkRouteVC animated:YES];

    }
}

- (void)ensurePaopaoEntirely:(BMKAnnotationView *)view
{
    CGRect annotFrame = view.frame;
    CGPoint annotOrigin = annotFrame.origin;
    
    // 如果针太靠边，需要挪动地图
    CGPoint relativePoint = CGPointMake(0, 0);
    if (annotOrigin.x > 320) {
        relativePoint = CGPointMake(annotOrigin.x - 320, relativePoint.y);
    }
    else if (annotOrigin.x < 150) {
        relativePoint = CGPointMake(annotOrigin.x - 150, relativePoint.y);
    }
    else if (annotOrigin.y < 100) {
        relativePoint = CGPointMake(relativePoint.x, annotOrigin.y - 100);
    }
    else if (annotOrigin.y > 480) {
        relativePoint = CGPointMake(relativePoint.x, annotOrigin.y - 480);
    }
    
    if (relativePoint.x == 0.0 && relativePoint.y == 0.0) {
        return;
    }
    
    relativePoint = CGPointMake(relativePoint.x + _mapView.center.x, relativePoint.y + _mapView.center.y);

    CLLocationCoordinate2D Movedcoord = [_mapView convertPoint:relativePoint toCoordinateFromView:_mapView];

    [_mapView setCenterCoordinate:Movedcoord animated:YES];
}





- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
//    int index = 0;
    currentSelectedAnnot = view;
    [self ensurePaopaoEntirely:view];
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    // 重置之前选择的泡泡框体状态
    isBlue = NO;
    
    // 重置泡泡view回到原始状态，准备下一次点击
//    CGPoint newPoint = CGPointMake((-1) * lastCallOutPoint.x, (-1) * lastCallOutPoint.y);
    view.calloutOffset = CGPointMake(0, 0);
    view.paopaoView.frame = CGRectMake(0, 0, currentSelectedAnnot.paopaoView.frame.size.width, 44);
    view.paopaoView.height = 80;
    //用户位置用其他位置图片表示
    if(view.annotation.coordinate.latitude == self.mapView.userLocation.coordinate.latitude && view.annotation.coordinate.longitude == self.mapView.userLocation.coordinate.longitude)
    {
        view.paopaoView.height = 44;
    }
//    currentPaopaoView.backgroundColor = [UIColor whiteColor];
//    view.paopaoView.frame = paoPaoOriginFrame;
}



/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    
    BMKCoordinateRegion region =  BMKCoordinateRegionMake(self.mapView.userLocation.coordinate,  BMKCoordinateSpanMake(0.005,0.005));
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
    self.mapView.overlooking = 0;
    self.gpsLocationButton.trackMode = BMKUserTrackingModeNone;

}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{


}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

/**
 *地图状态改变完成后会调用此接口
 *@param mapview 地图View
 */
- (void)mapStatusDidChanged:(BMKMapView *)mapView
{
    
    
    
}


- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.geoPt;
		item.title = result.strAddr;
		[_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.geoPt;
        NSString* titleStr;
        NSString* showmeg;
        
        if(isGeoSearch)
        {
            titleStr = @"正向地理编码";
            showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
            
        }
        else
        {
            titleStr = @"反向地理编码";
            showmeg = [NSString stringWithFormat:@"%@",result.addressComponent.city];
        }
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
	}

}






@end
