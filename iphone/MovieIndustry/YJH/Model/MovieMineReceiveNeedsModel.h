//
//  MovieMineReceiveNeedsModel.h
//
//  Created by MACIO 猫爷 on 15/11/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieReceiveNeedsOtherInfo;

@interface MovieMineReceiveNeedsModel : NSObject <NSCoding, NSCopying>

/** 0:未抢单 1:抢单成功 2:抢单失效  */
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *receiveMsgId;
@property (nonatomic, strong) NSString *rentId;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) MovieReceiveNeedsOtherInfo *otherInfo;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
