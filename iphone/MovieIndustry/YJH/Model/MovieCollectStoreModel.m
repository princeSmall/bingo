//
//  MovieCollectStoreModel.m
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieCollectStoreModel.h"


NSString *const kMovieCollectStoreModelPoints = @"points";
NSString *const kMovieCollectStoreModelBrief = @"brief";
NSString *const kMovieCollectStoreModelId = @"id";
NSString *const kMovieCollectStoreModelPreview = @"preview";
NSString *const kMovieCollectStoreModelCurrentPrice = @"current_price";
NSString *const kMovieCollectStoreModelAid = @"aid";
NSString *const kMovieCollectStoreModelShangpin = @"shangpin";
NSString *const kMovieCollectStoreModelOriginPrice = @"origin_price";
NSString *const kMovieCollectStoreModelName = @"name";


@interface MovieCollectStoreModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieCollectStoreModel

@synthesize points = _points;
@synthesize brief = _brief;
@synthesize movieCollectStoreModelIdentifier = _movieCollectStoreModelIdentifier;
@synthesize preview = _preview;
@synthesize currentPrice = _currentPrice;
@synthesize aid = _aid;
@synthesize shangpin = _shangpin;
@synthesize originPrice = _originPrice;
@synthesize name = _name;


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
            self.points = [self objectOrNilForKey:kMovieCollectStoreModelPoints fromDictionary:dict];
            self.brief = [self objectOrNilForKey:kMovieCollectStoreModelBrief fromDictionary:dict];
            self.movieCollectStoreModelIdentifier = [self objectOrNilForKey:kMovieCollectStoreModelId fromDictionary:dict];
            self.preview = [self objectOrNilForKey:kMovieCollectStoreModelPreview fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kMovieCollectStoreModelCurrentPrice fromDictionary:dict];
            self.aid = [self objectOrNilForKey:kMovieCollectStoreModelAid fromDictionary:dict];
            self.shangpin = [self objectOrNilForKey:kMovieCollectStoreModelShangpin fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kMovieCollectStoreModelOriginPrice fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieCollectStoreModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.points forKey:kMovieCollectStoreModelPoints];
    [mutableDict setValue:self.brief forKey:kMovieCollectStoreModelBrief];
    [mutableDict setValue:self.movieCollectStoreModelIdentifier forKey:kMovieCollectStoreModelId];
    [mutableDict setValue:self.preview forKey:kMovieCollectStoreModelPreview];
    [mutableDict setValue:self.currentPrice forKey:kMovieCollectStoreModelCurrentPrice];
    [mutableDict setValue:self.aid forKey:kMovieCollectStoreModelAid];
    [mutableDict setValue:self.shangpin forKey:kMovieCollectStoreModelShangpin];
    [mutableDict setValue:self.originPrice forKey:kMovieCollectStoreModelOriginPrice];
    [mutableDict setValue:self.name forKey:kMovieCollectStoreModelName];

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

    self.points = [aDecoder decodeObjectForKey:kMovieCollectStoreModelPoints];
    self.brief = [aDecoder decodeObjectForKey:kMovieCollectStoreModelBrief];
    self.movieCollectStoreModelIdentifier = [aDecoder decodeObjectForKey:kMovieCollectStoreModelId];
    self.preview = [aDecoder decodeObjectForKey:kMovieCollectStoreModelPreview];
    self.currentPrice = [aDecoder decodeObjectForKey:kMovieCollectStoreModelCurrentPrice];
    self.aid = [aDecoder decodeObjectForKey:kMovieCollectStoreModelAid];
    self.shangpin = [aDecoder decodeObjectForKey:kMovieCollectStoreModelShangpin];
    self.originPrice = [aDecoder decodeObjectForKey:kMovieCollectStoreModelOriginPrice];
    self.name = [aDecoder decodeObjectForKey:kMovieCollectStoreModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_points forKey:kMovieCollectStoreModelPoints];
    [aCoder encodeObject:_brief forKey:kMovieCollectStoreModelBrief];
    [aCoder encodeObject:_movieCollectStoreModelIdentifier forKey:kMovieCollectStoreModelId];
    [aCoder encodeObject:_preview forKey:kMovieCollectStoreModelPreview];
    [aCoder encodeObject:_currentPrice forKey:kMovieCollectStoreModelCurrentPrice];
    [aCoder encodeObject:_aid forKey:kMovieCollectStoreModelAid];
    [aCoder encodeObject:_shangpin forKey:kMovieCollectStoreModelShangpin];
    [aCoder encodeObject:_originPrice forKey:kMovieCollectStoreModelOriginPrice];
    [aCoder encodeObject:_name forKey:kMovieCollectStoreModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieCollectStoreModel *copy = [[MovieCollectStoreModel alloc] init];
    
    if (copy) {

        copy.points = [self.points copyWithZone:zone];
        copy.brief = [self.brief copyWithZone:zone];
        copy.movieCollectStoreModelIdentifier = [self.movieCollectStoreModelIdentifier copyWithZone:zone];
        copy.preview = [self.preview copyWithZone:zone];
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.aid = [self.aid copyWithZone:zone];
        copy.shangpin = [self.shangpin copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
