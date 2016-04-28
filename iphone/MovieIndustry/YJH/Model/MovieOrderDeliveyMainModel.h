//
//  MovieOrderDeliveyMainModel.h
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieOrderDeliveyMainModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *orderName;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *delivery;
@property (nonatomic, strong) NSArray *goods;
@property (nonatomic, strong) NSString *deliveryImg;
@property (nonatomic, strong) NSString *deliveryStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
