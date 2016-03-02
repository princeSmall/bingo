//
//  MovieTuesdayGoodImageModel.m
//
//  Created by MACIO 猫爷 on 15/12/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTuesdayGoodImageModel.h"


NSString *const kMovieTuesdayGoodImageModelId = @"id";
NSString *const kMovieTuesdayGoodImageModelImg = @"img";
NSString *const kMovieTuesdayGoodImageModelDealId = @"deal_id";
NSString *const kMovieTuesdayGoodImageModelSort = @"sort";


@interface MovieTuesdayGoodImageModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTuesdayGoodImageModel

@synthesize movieTuesdayGoodImageModelIdentifier = _movieTuesdayGoodImageModelIdentifier;
@synthesize img = _img;
@synthesize dealId = _dealId;
@synthesize sort = _sort;


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
            self.movieTuesdayGoodImageModelIdentifier = [self objectOrNilForKey:kMovieTuesdayGoodImageModelId fromDictionary:dict];
            self.img = [self objectOrNilForKey:kMovieTuesdayGoodImageModelImg fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieTuesdayGoodImageModelDealId fromDictionary:dict];
            self.sort = [self objectOrNilForKey:kMovieTuesdayGoodImageModelSort fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.movieTuesdayGoodImageModelIdentifier forKey:kMovieTuesdayGoodImageModelId];
    [mutableDict setValue:self.img forKey:kMovieTuesdayGoodImageModelImg];
    [mutableDict setValue:self.dealId forKey:kMovieTuesdayGoodImageModelDealId];
    [mutableDict setValue:self.sort forKey:kMovieTuesdayGoodImageModelSort];

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

    self.movieTuesdayGoodImageModelIdentifier = [aDecoder decodeObjectForKey:kMovieTuesdayGoodImageModelId];
    self.img = [aDecoder decodeObjectForKey:kMovieTuesdayGoodImageModelImg];
    self.dealId = [aDecoder decodeObjectForKey:kMovieTuesdayGoodImageModelDealId];
    self.sort = [aDecoder decodeObjectForKey:kMovieTuesdayGoodImageModelSort];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_movieTuesdayGoodImageModelIdentifier forKey:kMovieTuesdayGoodImageModelId];
    [aCoder encodeObject:_img forKey:kMovieTuesdayGoodImageModelImg];
    [aCoder encodeObject:_dealId forKey:kMovieTuesdayGoodImageModelDealId];
    [aCoder encodeObject:_sort forKey:kMovieTuesdayGoodImageModelSort];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTuesdayGoodImageModel *copy = [[MovieTuesdayGoodImageModel alloc] init];
    
    if (copy) {

        copy.movieTuesdayGoodImageModelIdentifier = [self.movieTuesdayGoodImageModelIdentifier copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.sort = [self.sort copyWithZone:zone];
    }
    
    return copy;
}


@end
