//
//  JGScenicAnnoation.h
//  MyTravel
//
//  Created by brother on 15/10/19.
//  Copyright © 2015年 young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface JGScenicAnnoation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,copy) NSString * icon;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon;

@end
