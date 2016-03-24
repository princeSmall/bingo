//
//  ScenicLocationViewController.m
//  MyTravel
//
//  Created by brother on 15/10/18.
//  Copyright © 2015年 young. All rights reserved.
//

#import "ScenicLocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JGScenic.h"
#import "AppDelegate.h"
#import "JGScenicAnnoation.h"

@interface ScenicLocationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapK;
@property (nonatomic,strong)CLLocationManager * manger;
@property (nonatomic,strong)UISegmentedControl * segment;
@property (nonatomic,strong)JGScenicAnnoation * scenicAnn;
@property (nonatomic,strong)CLGeocoder * gecoder;
@property (nonatomic,strong)NSMutableString * locationStr;
@property (nonatomic,strong)CLLocation * location;
@end

@implementation ScenicLocationViewController

- (CLGeocoder*)gecoder{
    
    

    

    if (_gecoder == nil) {
        _gecoder = [[CLGeocoder alloc]init];
    }

    return _gecoder;
}


- (void)dealloc{
//    [super dealloc];
    NSLog(@"对象销毁");
    self.gecoder = nil;
    self.myMapK = nil;
    self.manger = nil;
}

- (void)createSegmentedControl{
    
    CGFloat segmentY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, segmentY, self.view.frame.size.width, 40)];
    [segment insertSegmentWithTitle:@"标准模式" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"卫星模式" atIndex:1 animated:YES];
    [segment insertSegmentWithTitle:@"云图模式" atIndex:2 animated:YES];
    segment.tintColor = [UIColor orangeColor];
    [segment addTarget:self action:@selector(segmentIndexDidChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    self.segment = segment;
}

- (void)segmentIndexDidChange{
    if (self.segment.selectedSegmentIndex == 0) {
        self.myMapK.mapType = MKMapTypeStandard;
    }else if(self.segment.selectedSegmentIndex == 1)
    { self.myMapK.mapType = MKMapTypeSatellite;}
    else{
        self.myMapK.mapType = MKMapTypeHybrid;
    }
}


- (CLLocationManager*)manger{
    if (_manger == nil) {
        _manger = [[CLLocationManager alloc]init];
        _manger.delegate = self;
    }
    return _manger;
}

- (void)createAlertViewWith:(NSString *)string{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.view addSubview:alert];
    [alert show];
    [alert removeFromSuperview];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    userLocation.title = @"当前位置";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        userLocation.subtitle = self.locationStr;
    });
    
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.05, 0.05));
    [self.myMapK setRegion:region];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSegmentedControl];
    JGScenic * scenic = [AppDelegate shareApp].scenic;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(scenic.s_latitude, scenic.s_longitude);
    NSLog(@"%f__%f",scenic.s_latitude, scenic.s_longitude);
    self.scenicAnn = [[JGScenicAnnoation alloc]initWithCoordinate:coord title:scenic.s_name subtitle:scenic.s_address icon:@"1.png"];
    self.myMapK.userTrackingMode = MKUserTrackingModeFollow;
    [self.manger requestAlwaysAuthorization];
    [self.manger startUpdatingLocation];
    self.myMapK.layer.zPosition = -1;
}
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    
//    static NSString * ID = @"good";
//    MKAnnotationView * view1 = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
//    if (view1 == nil) {
//        view1 = [[MKAnnotationView alloc]init];
//        view1.canShowCallout = YES;
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeInfoDark];
//        
//        view1.leftCalloutAccessoryView = button;
//    }
//    view1.annotation = self.scenicAnn;
//    view1.image = [UIImage imageNamed:self.scenicAnn.icon];
//    return view1;
//    
//}



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [manager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            [self createAlertViewWith:@"定位服务被限制使用"];
            break;
        case kCLAuthorizationStatusDenied:
            [self createAlertViewWith:@"没有开启定位功能,请从后台打开定位功能!"];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.manger startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation * location = [locations firstObject];
    float longitude,latitude;
    //经度
    self.location = location;
    self.locationStr = [NSMutableString string];
    [self.gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * place = [placemarks firstObject];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            _locationStr = [NSMutableString stringWithString:place.name];
        }];
    }];
    longitude = location.coordinate.longitude;
    latitude = location.coordinate.latitude;
    [self.myMapK addAnnotation:self.scenicAnn];
    [self.manger stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
