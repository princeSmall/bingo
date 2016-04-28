//
//  MovieNeedsRushedGoodsInfoModel.m
//
//  Created by MACIO 猫爷 on 15/12/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieNeedsRushedGoodsInfoModel.h"


NSString *const kMovieNeedsRushedGoodsInfoModelId = @"id";
NSString *const kMovieNeedsRushedGoodsInfoModelImg = @"img";
NSString *const kMovieNeedsRushedGoodsInfoModelCurrentPrice = @"current_price";
NSString *const kMovieNeedsRushedGoodsInfoModelName = @"name";
NSString *const kMovieNeedsRushedGoodsInfoModelOriginPrice = @"origin_price";


@interface MovieNeedsRushedGoodsInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieNeedsRushedGoodsInfoModel

@synthesize goodId = _goodId;
@synthesize img = _img;
@synthesize currentPrice = _currentPrice;
@synthesize name = _name;
@synthesize originPrice = _originPrice;


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
            self.goodId = [self objectOrNilForKey:kMovieNeedsRushedGoodsInfoModelId fromDictionary:dict];
            self.img = [self objectOrNilForKey:kMovieNeedsRushedGoodsInfoModelImg fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kMovieNeedsRushedGoodsInfoModelCurrentPrice fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieNeedsRushedGoodsInfoModelName fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kMovieNeedsRushedGoodsInfoModelOriginPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.goodId forKey:kMovieNeedsRushedGoodsInfoModelId];
    [mutableDict setValue:self.img forKey:kMovieNeedsRushedGoodsInfoModelImg];
    [mutableDict setValue:self.currentPrice forKey:kMovieNeedsRushedGoodsInfoModelCurrentPrice];
    [mutableDict setValue:self.name forKey:kMovieNeedsRushedGoodsInfoModelName];
    [mutableDict setValue:self.originPrice forKey:kMovieNeedsRushedGoodsInfoModelOriginPrice];

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

    self.goodId = [aDecoder decodeObjectForKey:kMovieNeedsRushedGoodsInfoModelId];
    self.img = [aDecoder decodeObjectForKey:kMovieNeedsRushedGoodsInfoModelImg];
    self.currentPrice = [aDecoder decodeObjectForKey:kMovieNeedsRushedGoodsInfoModelCurrentPrice];
    self.name = [aDecoder decodeObjectForKey:kMovieNeedsRushedGoodsInfoModelName];
    self.originPrice = [aDecoder decodeObjectForKey:kMovieNeedsRushedGoodsInfoModelOriginPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_goodId forKey:kMovieNeedsRushedGoodsInfoModelId];
    [aCoder encodeObject:_img forKey:kMovieNeedsRushedGoodsInfoModelImg];
    [aCoder encodeObject:_currentPrice forKey:kMovieNeedsRushedGoodsInfoModelCurrentPrice];
    [aCoder encodeObject:_name forKey:kMovieNeedsRushedGoodsInfoModelName];
    [aCoder encodeObject:_originPrice forKey:kMovieNeedsRushedGoodsInfoModelOriginPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieNeedsRushedGoodsInfoModel *copy = [[MovieNeedsRushedGoodsInfoModel alloc] init];
    
    if (copy) {

        copy.goodId = [self.goodId copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
    }
    
    return copy;
}


@end
