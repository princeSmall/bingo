//
//  MovieMineCollectGoodsModel.m
//
//  Created by MACIO 猫爷 on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineCollectGoodsModel.h"
#import "GoodCollectionInfo.h"


NSString *const kMovieMineCollectGoodsModelId = @"id";
NSString *const kMovieMineCollectGoodsModelDealId = @"deal_id";
NSString *const kMovieMineCollectGoodsModelUserId = @"user_id";
NSString *const kMovieMineCollectGoodsModelCreateTime = @"create_time";
NSString *const kMovieMineCollectGoodsModelInfo = @"info";


@interface MovieMineCollectGoodsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineCollectGoodsModel

@synthesize movieMineCollectGoodsModelIdentifier = _movieMineCollectGoodsModelIdentifier;
@synthesize dealId = _dealId;
@synthesize userId = _userId;
@synthesize createTime = _createTime;
@synthesize info = _info;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.movieMineCollectGoodsModelIdentifier = [self objectOrNilForKey:kMovieMineCollectGoodsModelId fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieMineCollectGoodsModelDealId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kMovieMineCollectGoodsModelUserId fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kMovieMineCollectGoodsModelCreateTime fromDictionary:dict];
            self.info = [GoodCollectionInfo modelObjectWithDictionary:[dict objectForKey:kMovieMineCollectGoodsModelInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.movieMineCollectGoodsModelIdentifier forKey:kMovieMineCollectGoodsModelId];
    [mutableDict setValue:self.dealId forKey:kMovieMineCollectGoodsModelDealId];
    [mutableDict setValue:self.userId forKey:kMovieMineCollectGoodsModelUserId];
    [mutableDict setValue:self.createTime forKey:kMovieMineCollectGoodsModelCreateTime];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kMovieMineCollectGoodsModelInfo];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.movieMineCollectGoodsModelIdentifier = [aDecoder decodeObjectForKey:kMovieMineCollectGoodsModelId];
    self.dealId = [aDecoder decodeObjectForKey:kMovieMineCollectGoodsModelDealId];
    self.userId = [aDecoder decodeObjectForKey:kMovieMineCollectGoodsModelUserId];
    self.createTime = [aDecoder decodeObjectForKey:kMovieMineCollectGoodsModelCreateTime];
    self.info = [aDecoder decodeObjectForKey:kMovieMineCollectGoodsModelInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_movieMineCollectGoodsModelIdentifier forKey:kMovieMineCollectGoodsModelId];
    [aCoder encodeObject:_dealId forKey:kMovieMineCollectGoodsModelDealId];
    [aCoder encodeObject:_userId forKey:kMovieMineCollectGoodsModelUserId];
    [aCoder encodeObject:_createTime forKey:kMovieMineCollectGoodsModelCreateTime];
    [aCoder encodeObject:_info forKey:kMovieMineCollectGoodsModelInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineCollectGoodsModel *copy = [[MovieMineCollectGoodsModel alloc] init];
    
    if (copy) {

        copy.movieMineCollectGoodsModelIdentifier = [self.movieMineCollectGoodsModelIdentifier copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
