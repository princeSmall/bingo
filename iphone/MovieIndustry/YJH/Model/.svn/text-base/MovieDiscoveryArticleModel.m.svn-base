//
//  MovieDiscoveryArticleModel.m
//
//  Created by MACIO 猫爷 on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieDiscoveryArticleModel.h"


NSString *const kMovieDiscoveryArticleModelBrief = @"brief";
NSString *const kMovieDiscoveryArticleModelUpdateTime = @"update_time";
NSString *const kMovieDiscoveryArticleModelId = @"id";
NSString *const kMovieDiscoveryArticleModelTitle = @"title";
NSString *const kMovieDiscoveryArticleModelImage = @"image";
NSString *const kMovieDiscoveryArticleModelCommentNumber = @"comment_number";
NSString *const kMovieDiscoveryArticleModelClickCount = @"click_count";


@interface MovieDiscoveryArticleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieDiscoveryArticleModel

@synthesize brief = _brief;
@synthesize updateTime = _updateTime;
@synthesize articleId = _articleId;
@synthesize title = _title;
@synthesize image = _image;
@synthesize commentNumber = _commentNumber;
@synthesize clickCount = _clickCount;


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
            self.brief = [self objectOrNilForKey:kMovieDiscoveryArticleModelBrief fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieDiscoveryArticleModelUpdateTime fromDictionary:dict];
            self.articleId = [self objectOrNilForKey:kMovieDiscoveryArticleModelId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMovieDiscoveryArticleModelTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kMovieDiscoveryArticleModelImage fromDictionary:dict];
            self.commentNumber = [self objectOrNilForKey:kMovieDiscoveryArticleModelCommentNumber fromDictionary:dict];
            self.clickCount = [self objectOrNilForKey:kMovieDiscoveryArticleModelClickCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.brief forKey:kMovieDiscoveryArticleModelBrief];
    [mutableDict setValue:self.updateTime forKey:kMovieDiscoveryArticleModelUpdateTime];
    [mutableDict setValue:self.articleId forKey:kMovieDiscoveryArticleModelId];
    [mutableDict setValue:self.title forKey:kMovieDiscoveryArticleModelTitle];
    [mutableDict setValue:self.image forKey:kMovieDiscoveryArticleModelImage];
    [mutableDict setValue:self.commentNumber forKey:kMovieDiscoveryArticleModelCommentNumber];
    [mutableDict setValue:self.clickCount forKey:kMovieDiscoveryArticleModelClickCount];

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

    self.brief = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelBrief];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelUpdateTime];
    self.articleId = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelId];
    self.title = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelTitle];
    self.image = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelImage];
    self.commentNumber = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelCommentNumber];
    self.clickCount = [aDecoder decodeObjectForKey:kMovieDiscoveryArticleModelClickCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_brief forKey:kMovieDiscoveryArticleModelBrief];
    [aCoder encodeObject:_updateTime forKey:kMovieDiscoveryArticleModelUpdateTime];
    [aCoder encodeObject:_articleId forKey:kMovieDiscoveryArticleModelId];
    [aCoder encodeObject:_title forKey:kMovieDiscoveryArticleModelTitle];
    [aCoder encodeObject:_image forKey:kMovieDiscoveryArticleModelImage];
    [aCoder encodeObject:_commentNumber forKey:kMovieDiscoveryArticleModelCommentNumber];
    [aCoder encodeObject:_clickCount forKey:kMovieDiscoveryArticleModelClickCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieDiscoveryArticleModel *copy = [[MovieDiscoveryArticleModel alloc] init];
    
    if (copy) {

        copy.brief = [self.brief copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.articleId = [self.articleId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.commentNumber = [self.commentNumber copyWithZone:zone];
        copy.clickCount = [self.clickCount copyWithZone:zone];
    }
    
    return copy;
}


@end
