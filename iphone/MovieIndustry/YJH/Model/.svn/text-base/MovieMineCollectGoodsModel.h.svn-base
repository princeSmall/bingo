//
//  MovieMineCollectGoodsModel.h
//
//  Created by MACIO 猫爷 on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodCollectionInfo;

@interface MovieMineCollectGoodsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *movieMineCollectGoodsModelIdentifier;
@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) GoodCollectionInfo *info;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
