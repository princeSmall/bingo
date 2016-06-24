//
//  HHLocationService.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHLocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface HHLocationService () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
//@property (nonatomic,copy) NSString *locationString;
@end

@implementation HHLocationService

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    return _locationManager;
}


- (void)openLocationService
{
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位平率，每隔多少米定位一次
        CLLocationDistance distance = 10.0;
        self.locationManager.distanceFilter = distance;
        //启动定位
        [self.locationManager startUpdatingLocation];
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {//如果使用时开启授权
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位平率，每隔多少米定位一次
        CLLocationDistance distance = 10.0;
        self.locationManager.distanceFilter = distance;
        //启动定位
        [self.locationManager startUpdatingLocation];
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
    {
        //如果已经授权
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位平率，每隔多少米定位一次
        CLLocationDistance distance = 10.0;
        self.locationManager.distanceFilter = distance;
        //启动定位
        [self.locationManager startUpdatingLocation];
    }
    
}

#pragma mark CllocationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
    //根据经纬度获取位置信息
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    //如果不需要实时定位，使用完毕后关闭定位服务
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark - 解析经纬度
#pragma mark 根据坐标取到地名
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
 
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    //反地理编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        
        CLPlacemark *placemark = [placemarks firstObject];//取出第一个位置信息
            if (placemark.addressDictionary.count == 0)
            {//如果没有定位到数据
                [self openLocationService];
                HHNSLog(@"%@",placemark.addressDictionary);
            }else
            {
                 NSString *locationString = [NSString stringWithFormat:@"%@",placemark.locality];
                HHNSLog(@"locationString %@",locationString);
                
                
                if (self.delegate) {
                    [self.delegate locationAddressString:locationString];
                }
                HHNSLog(@"%@",placemark.addressDictionary);
                
            
            }
    }];
}
@end
