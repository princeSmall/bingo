//
//  MovieArticleDetailModel.m
//
//  Created by MACIO 猫爷 on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieArticleDetailModel.h"


NSString *const kMovieArticleDetailModelAuthor = @"author";
NSString *const kMovieArticleDetailModelContent = @"content";
NSString *const kMovieArticleDetailModelBrief = @"brief";
NSString *const kMovieArticleDetailModelId = @"id";
NSString *const kMovieArticleDetailModelUpdateTime = @"update_time";
NSString *const kMovieArticleDetailModelTitle = @"title";
NSString *const kMovieArticleDetailModelImage = @"image";
NSString *const kMovieArticleDetailModelCommentNumber = @"comment_number";
NSString *const kMovieArticleDetailModelClickCount = @"click_count";


@interface MovieArticleDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieArticleDetailModel

@synthesize author = _author;
@synthesize content = _content;
@synthesize brief = _brief;
@synthesize movieArticleDetailModelIdentifier = _movieArticleDetailModelIdentifier;
@synthesize updateTime = _updateTime;
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
            self.author = [self objectOrNilForKey:kMovieArticleDetailModelAuthor fromDictionary:dict];
            self.content = [self objectOrNilForKey:kMovieArticleDetailModelContent fromDictionary:dict];
            self.brief = [self objectOrNilForKey:kMovieArticleDetailModelBrief fromDictionary:dict];
            self.movieArticleDetailModelIdentifier = [self objectOrNilForKey:kMovieArticleDetailModelId fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieArticleDetailModelUpdateTime fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMovieArticleDetailModelTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kMovieArticleDetailModelImage fromDictionary:dict];
            self.commentNumber = [self objectOrNilForKey:kMovieArticleDetailModelCommentNumber fromDictionary:dict];
            self.clickCount = [[self objectOrNilForKey:kMovieArticleDetailModelClickCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.author forKey:kMovieArticleDetailModelAuthor];
    [mutableDict setValue:self.content forKey:kMovieArticleDetailModelContent];
    [mutableDict setValue:self.brief forKey:kMovieArticleDetailModelBrief];
    [mutableDict setValue:self.movieArticleDetailModelIdentifier forKey:kMovieArticleDetailModelId];
    [mutableDict setValue:self.updateTime forKey:kMovieArticleDetailModelUpdateTime];
    [mutableDict setValue:self.title forKey:kMovieArticleDetailModelTitle];
    [mutableDict setValue:self.image forKey:kMovieArticleDetailModelImage];
    [mutableDict setValue:self.commentNumber forKey:kMovieArticleDetailModelCommentNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clickCount] forKey:kMovieArticleDetailModelClickCount];

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

    self.author = [aDecoder decodeObjectForKey:kMovieArticleDetailModelAuthor];
    self.content = [aDecoder decodeObjectForKey:kMovieArticleDetailModelContent];
    self.brief = [aDecoder decodeObjectForKey:kMovieArticleDetailModelBrief];
    self.movieArticleDetailModelIdentifier = [aDecoder decodeObjectForKey:kMovieArticleDetailModelId];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieArticleDetailModelUpdateTime];
    self.title = [aDecoder decodeObjectForKey:kMovieArticleDetailModelTitle];
    self.image = [aDecoder decodeObjectForKey:kMovieArticleDetailModelImage];
    self.commentNumber = [aDecoder decodeObjectForKey:kMovieArticleDetailModelCommentNumber];
    self.clickCount = [aDecoder decodeDoubleForKey:kMovieArticleDetailModelClickCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kMovieArticleDetailModelAuthor];
    [aCoder encodeObject:_content forKey:kMovieArticleDetailModelContent];
    [aCoder encodeObject:_brief forKey:kMovieArticleDetailModelBrief];
    [aCoder encodeObject:_movieArticleDetailModelIdentifier forKey:kMovieArticleDetailModelId];
    [aCoder encodeObject:_updateTime forKey:kMovieArticleDetailModelUpdateTime];
    [aCoder encodeObject:_title forKey:kMovieArticleDetailModelTitle];
    [aCoder encodeObject:_image forKey:kMovieArticleDetailModelImage];
    [aCoder encodeObject:_commentNumber forKey:kMovieArticleDetailModelCommentNumber];
    [aCoder encodeDouble:_clickCount forKey:kMovieArticleDetailModelClickCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieArticleDetailModel *copy = [[MovieArticleDetailModel alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.brief = [self.brief copyWithZone:zone];
        copy.movieArticleDetailModelIdentifier = [self.movieArticleDetailModelIdentifier copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.commentNumber = [self.commentNumber copyWithZone:zone];
        copy.clickCount = self.clickCount;
    }
    
    return copy;
}


@end
