//
//  GoodCollectionInfo.h
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GoodCollectionInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *deliveryId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *originPrice;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
