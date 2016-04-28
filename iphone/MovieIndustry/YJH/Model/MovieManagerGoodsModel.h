//
//  MovieManagerGoodsModel.h
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieManagerGoodsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *goodId;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *deliveryId;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
