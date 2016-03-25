//
//  JGScenicAnnoation.m
//  MyTravel
//
//  Created by brother on 15/10/19.
//  Copyright © 2015年 young. All rights reserved.
//

#import "JGScenicAnnoation.h"

@implementation JGScenicAnnoation


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon{

    if (self = [super init]) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
        _icon = icon;
    }
    return self;
}


@end
