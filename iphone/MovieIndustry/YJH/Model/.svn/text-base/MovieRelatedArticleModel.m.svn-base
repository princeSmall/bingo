//
//  MovieRelatedArticleModel.m
//
//  Created by MACIO 猫爷 on 15/12/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieRelatedArticleModel.h"


NSString *const kMovieRelatedArticleModelId = @"id";
NSString *const kMovieRelatedArticleModelTitle = @"title";
NSString *const kMovieRelatedArticleModelTime = @"time";
NSString *const kMovieRelatedArticleModelUserName = @"user_name";


@interface MovieRelatedArticleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieRelatedArticleModel

@synthesize relatedArticleId = _relatedArticleId;
@synthesize title = _title;
@synthesize time = _time;
@synthesize userName = _userName;


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
            self.relatedArticleId = [self objectOrNilForKey:kMovieRelatedArticleModelId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMovieRelatedArticleModelTitle fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMovieRelatedArticleModelTime fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kMovieRelatedArticleModelUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.relatedArticleId forKey:kMovieRelatedArticleModelId];
    [mutableDict setValue:self.title forKey:kMovieRelatedArticleModelTitle];
    [mutableDict setValue:self.time forKey:kMovieRelatedArticleModelTime];
    [mutableDict setValue:self.userName forKey:kMovieRelatedArticleModelUserName];

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

    self.relatedArticleId = [aDecoder decodeObjectForKey:kMovieRelatedArticleModelId];
    self.title = [aDecoder decodeObjectForKey:kMovieRelatedArticleModelTitle];
    self.time = [aDecoder decodeObjectForKey:kMovieRelatedArticleModelTime];
    self.userName = [aDecoder decodeObjectForKey:kMovieRelatedArticleModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_relatedArticleId forKey:kMovieRelatedArticleModelId];
    [aCoder encodeObject:_title forKey:kMovieRelatedArticleModelTitle];
    [aCoder encodeObject:_time forKey:kMovieRelatedArticleModelTime];
    [aCoder encodeObject:_userName forKey:kMovieRelatedArticleModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieRelatedArticleModel *copy = [[MovieRelatedArticleModel alloc] init];
    
    if (copy) {

        copy.relatedArticleId = [self.relatedArticleId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
