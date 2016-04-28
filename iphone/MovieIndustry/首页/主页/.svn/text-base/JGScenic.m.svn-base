//
//  JGScenic.m
//  MovieIndustry
//
//  Created by aaa on 16/3/23.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "JGScenic.h"
#import <CoreLocation/CoreLocation.h>
@interface JGScenic ()

@property (nonatomic,strong)CLGeocoder * coder;

@end


@implementation JGScenic

- (CLGeocoder*)coder{

    if (_coder == nil) {
        _coder = [[CLGeocoder alloc]init];
    }
    return _coder;
}

- (void)setS_address:(NSString *)s_address{
    _s_address = s_address;
    //拿到地址 后 进行反向编码 拿到 经纬度
    [self.coder geocodeAddressString:s_address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * mark = [placemarks firstObject];
         self.s_latitude = mark.location.coordinate.latitude;
        self.s_longitude = mark.location.coordinate.longitude;
        self.block(self.s_latitude,self.s_longitude);
    }];
}


@end
