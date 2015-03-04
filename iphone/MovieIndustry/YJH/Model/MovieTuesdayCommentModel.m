//
//  MovieTuesdayCommentModel.m
//
//  Created by MACIO 猫爷 on 15/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTuesdayCommentModel.h"


NSString *const kMovieTuesdayCommentModelId = @"id";
NSString *const kMovieTuesdayCommentModelNikename = @"nikename";
NSString *const kMovieTuesdayCommentModelContentPraiseNum = @"content_praise_num";
NSString *const kMovieTuesdayCommentModelMobile = @"mobile";
NSString *const kMovieTuesdayCommentModelUserId = @"user_id";
NSString *const kMovieTuesdayCommentModelImg = @"img";
NSString *const kMovieTuesdayCommentModelDealId = @"deal_id";
NSString *const kMovieTuesdayCommentModelPing = @"ping";
NSString *const kMovieTuesdayCommentModelIsDelete = @"is_delete";
NSString *const kMovieTuesdayCommentModelContentNum = @"content_num";
NSString *const kMovieTuesdayCommentModelIconImg = @"icon_img";
NSString *const kMovieTuesdayCommentModelCreateTime = @"create_time";
NSString *const kMovieTuesdayCommentModelGrade = @"grade";
NSString *const kMovieTuesdayCommentModelContent = @"content";


@interface MovieTuesdayCommentModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTuesdayCommentModel

@synthesize commentId = _commentId;
@synthesize nikename = _nikename;
@synthesize contentPraiseNum = _contentPraiseNum;
@synthesize mobile = _mobile;
@synthesize userId = _userId;
@synthesize img = _img;
@synthesize dealId = _dealId;
@synthesize ping = _ping;
@synthesize isDelete = _isDelete;
@synthesize contentNum = _contentNum;
@synthesize iconImg = _iconImg;
@synthesize createTime = _createTime;
@synthesize grade = _grade;
@synthesize content = _content;


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
            self.commentId = [self objectOrNilForKey:kMovieTuesdayCommentModelId fromDictionary:dict];
            self.nikename = [self objectOrNilForKey:kMovieTuesdayCommentModelNikename fromDictionary:dict];
            self.contentPraiseNum = [self objectOrNilForKey:kMovieTuesdayCommentModelContentPraiseNum fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kMovieTuesdayCommentModelMobile fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kMovieTuesdayCommentModelUserId fromDictionary:dict];
            self.img = [self objectOrNilForKey:kMovieTuesdayCommentModelImg fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieTuesdayCommentModelDealId fromDictionary:dict];
            self.ping = [self objectOrNilForKey:kMovieTuesdayCommentModelPing fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kMovieTuesdayCommentModelIsDelete fromDictionary:dict];
            self.contentNum = [self objectOrNilForKey:kMovieTuesdayCommentModelContentNum fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kMovieTuesdayCommentModelIconImg fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kMovieTuesdayCommentModelCreateTime fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kMovieTuesdayCommentModelGrade fromDictionary:dict];
            self.content = [self objectOrNilForKey:kMovieTuesdayCommentModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.commentId forKey:kMovieTuesdayCommentModelId];
    [mutableDict setValue:self.nikename forKey:kMovieTuesdayCommentModelNikename];
    [mutableDict setValue:self.contentPraiseNum forKey:kMovieTuesdayCommentModelContentPraiseNum];
    [mutableDict setValue:self.mobile forKey:kMovieTuesdayCommentModelMobile];
    [mutableDict setValue:self.userId forKey:kMovieTuesdayCommentModelUserId];
    [mutableDict setValue:self.img forKey:kMovieTuesdayCommentModelImg];
    [mutableDict setValue:self.dealId forKey:kMovieTuesdayCommentModelDealId];
    [mutableDict setValue:self.ping forKey:kMovieTuesdayCommentModelPing];
    [mutableDict setValue:self.isDelete forKey:kMovieTuesdayCommentModelIsDelete];
    [mutableDict setValue:self.contentNum forKey:kMovieTuesdayCommentModelContentNum];
    [mutableDict setValue:self.iconImg forKey:kMovieTuesdayCommentModelIconImg];
    [mutableDict setValue:self.createTime forKey:kMovieTuesdayCommentModelCreateTime];
    [mutableDict setValue:self.grade forKey:kMovieTuesdayCommentModelGrade];
    [mutableDict setValue:self.content forKey:kMovieTuesdayCommentModelContent];

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

    self.commentId = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelId];
    self.nikename = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelNikename];
    self.contentPraiseNum = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelContentPraiseNum];
    self.mobile = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelMobile];
    self.userId = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelUserId];
    self.img = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelImg];
    self.dealId = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelDealId];
    self.ping = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelPing];
    self.isDelete = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelIsDelete];
    self.contentNum = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelContentNum];
    self.iconImg = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelIconImg];
    self.createTime = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelCreateTime];
    self.grade = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelGrade];
    self.content = [aDecoder decodeObjectForKey:kMovieTuesdayCommentModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commentId forKey:kMovieTuesdayCommentModelId];
    [aCoder encodeObject:_nikename forKey:kMovieTuesdayCommentModelNikename];
    [aCoder encodeObject:_contentPraiseNum forKey:kMovieTuesdayCommentModelContentPraiseNum];
    [aCoder encodeObject:_mobile forKey:kMovieTuesdayCommentModelMobile];
    [aCoder encodeObject:_userId forKey:kMovieTuesdayCommentModelUserId];
    [aCoder encodeObject:_img forKey:kMovieTuesdayCommentModelImg];
    [aCoder encodeObject:_dealId forKey:kMovieTuesdayCommentModelDealId];
    [aCoder encodeObject:_ping forKey:kMovieTuesdayCommentModelPing];
    [aCoder encodeObject:_isDelete forKey:kMovieTuesdayCommentModelIsDelete];
    [aCoder encodeObject:_contentNum forKey:kMovieTuesdayCommentModelContentNum];
    [aCoder encodeObject:_iconImg forKey:kMovieTuesdayCommentModelIconImg];
    [aCoder encodeObject:_createTime forKey:kMovieTuesdayCommentModelCreateTime];
    [aCoder encodeObject:_grade forKey:kMovieTuesdayCommentModelGrade];
    [aCoder encodeObject:_content forKey:kMovieTuesdayCommentModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTuesdayCommentModel *copy = [[MovieTuesdayCommentModel alloc] init];
    
    if (copy) {

        copy.commentId = [self.commentId copyWithZone:zone];
        copy.nikename = [self.nikename copyWithZone:zone];
        copy.contentPraiseNum = [self.contentPraiseNum copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.ping = [self.ping copyWithZone:zone];
        copy.isDelete = [self.isDelete copyWithZone:zone];
        copy.contentNum = [self.contentNum copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.grade = [self.grade copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
