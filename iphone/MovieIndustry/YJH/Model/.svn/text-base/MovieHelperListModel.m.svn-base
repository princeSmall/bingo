//
//  MovieHelperListModel.m
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieHelperListModel.h"


NSString *const kMovieHelperListModelId = @"id";
NSString *const kMovieHelperListModelTitle = @"title";
NSString *const kMovieHelperListModelUpdateTime = @"update_time";


@interface MovieHelperListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieHelperListModel

@synthesize helperId = _helperId;
@synthesize title = _title;
@synthesize updateTime = _updateTime;


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
            self.helperId = [self objectOrNilForKey:kMovieHelperListModelId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMovieHelperListModelTitle fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieHelperListModelUpdateTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.helperId forKey:kMovieHelperListModelId];
    [mutableDict setValue:self.title forKey:kMovieHelperListModelTitle];
    [mutableDict setValue:self.updateTime forKey:kMovieHelperListModelUpdateTime];

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

    self.helperId = [aDecoder decodeObjectForKey:kMovieHelperListModelId];
    self.title = [aDecoder decodeObjectForKey:kMovieHelperListModelTitle];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieHelperListModelUpdateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_helperId forKey:kMovieHelperListModelId];
    [aCoder encodeObject:_title forKey:kMovieHelperListModelTitle];
    [aCoder encodeObject:_updateTime forKey:kMovieHelperListModelUpdateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieHelperListModel *copy = [[MovieHelperListModel alloc] init];
    
    if (copy) {

        copy.helperId = [self.helperId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
    }
    
    return copy;
}


@end
