//
//  ModelArticleCommentModel.m
//
//  Created by MACIO 猫爷 on 15/12/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ModelArticleCommentModel.h"


NSString *const kModelArticleCommentModelId = @"id";
NSString *const kModelArticleCommentModelAddTimeStr = @"add_time_str";
NSString *const kModelArticleCommentModelNikename = @"nikename";
NSString *const kModelArticleCommentModelContentPraiseNum = @"content_praise_num";
NSString *const kModelArticleCommentModelMobile = @"mobile";
NSString *const kModelArticleCommentModelArticleId = @"article_id";
NSString *const kModelArticleCommentModelContentId = @"content_id";
NSString *const kModelArticleCommentModelImg = @"img";
NSString *const kModelArticleCommentModelUserId = @"user_id";
NSString *const kModelArticleCommentModelContentNum = @"content_num";
NSString *const kModelArticleCommentModelIconImg = @"icon_img";
NSString *const kModelArticleCommentModelStatuses = @"statuses";
NSString *const kModelArticleCommentModelAddTime = @"add_time";
NSString *const kModelArticleCommentModelGrade = @"grade";
NSString *const kModelArticleCommentModelContent = @"content";


@interface ModelArticleCommentModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelArticleCommentModel

@synthesize commentModelId = _commentModelId;
@synthesize addTimeStr = _addTimeStr;
@synthesize nikename = _nikename;
@synthesize contentPraiseNum = _contentPraiseNum;
@synthesize mobile = _mobile;
@synthesize articleId = _articleId;
@synthesize contentId = _contentId;
@synthesize img = _img;
@synthesize userId = _userId;
@synthesize contentNum = _contentNum;
@synthesize iconImg = _iconImg;
@synthesize statuses = _statuses;
@synthesize addTime = _addTime;
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
            self.commentModelId = [self objectOrNilForKey:kModelArticleCommentModelId fromDictionary:dict];
            self.addTimeStr = [self objectOrNilForKey:kModelArticleCommentModelAddTimeStr fromDictionary:dict];
            self.nikename = [self objectOrNilForKey:kModelArticleCommentModelNikename fromDictionary:dict];
            self.contentPraiseNum = [self objectOrNilForKey:kModelArticleCommentModelContentPraiseNum fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kModelArticleCommentModelMobile fromDictionary:dict];
            self.articleId = [self objectOrNilForKey:kModelArticleCommentModelArticleId fromDictionary:dict];
            self.contentId = [self objectOrNilForKey:kModelArticleCommentModelContentId fromDictionary:dict];
            self.img = [self objectOrNilForKey:kModelArticleCommentModelImg fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kModelArticleCommentModelUserId fromDictionary:dict];
            self.contentNum = [self objectOrNilForKey:kModelArticleCommentModelContentNum fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kModelArticleCommentModelIconImg fromDictionary:dict];
            self.statuses = [self objectOrNilForKey:kModelArticleCommentModelStatuses fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kModelArticleCommentModelAddTime fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kModelArticleCommentModelGrade fromDictionary:dict];
            self.content = [self objectOrNilForKey:kModelArticleCommentModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.commentModelId forKey:kModelArticleCommentModelId];
    [mutableDict setValue:self.addTimeStr forKey:kModelArticleCommentModelAddTimeStr];
    [mutableDict setValue:self.nikename forKey:kModelArticleCommentModelNikename];
    [mutableDict setValue:self.contentPraiseNum forKey:kModelArticleCommentModelContentPraiseNum];
    [mutableDict setValue:self.mobile forKey:kModelArticleCommentModelMobile];
    [mutableDict setValue:self.articleId forKey:kModelArticleCommentModelArticleId];
    [mutableDict setValue:self.contentId forKey:kModelArticleCommentModelContentId];
    [mutableDict setValue:self.img forKey:kModelArticleCommentModelImg];
    [mutableDict setValue:self.userId forKey:kModelArticleCommentModelUserId];
    [mutableDict setValue:self.contentNum forKey:kModelArticleCommentModelContentNum];
    [mutableDict setValue:self.iconImg forKey:kModelArticleCommentModelIconImg];
    [mutableDict setValue:self.statuses forKey:kModelArticleCommentModelStatuses];
    [mutableDict setValue:self.addTime forKey:kModelArticleCommentModelAddTime];
    [mutableDict setValue:self.grade forKey:kModelArticleCommentModelGrade];
    [mutableDict setValue:self.content forKey:kModelArticleCommentModelContent];

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

    self.commentModelId = [aDecoder decodeObjectForKey:kModelArticleCommentModelId];
    self.addTimeStr = [aDecoder decodeObjectForKey:kModelArticleCommentModelAddTimeStr];
    self.nikename = [aDecoder decodeObjectForKey:kModelArticleCommentModelNikename];
    self.contentPraiseNum = [aDecoder decodeObjectForKey:kModelArticleCommentModelContentPraiseNum];
    self.mobile = [aDecoder decodeObjectForKey:kModelArticleCommentModelMobile];
    self.articleId = [aDecoder decodeObjectForKey:kModelArticleCommentModelArticleId];
    self.contentId = [aDecoder decodeObjectForKey:kModelArticleCommentModelContentId];
    self.img = [aDecoder decodeObjectForKey:kModelArticleCommentModelImg];
    self.userId = [aDecoder decodeObjectForKey:kModelArticleCommentModelUserId];
    self.contentNum = [aDecoder decodeObjectForKey:kModelArticleCommentModelContentNum];
    self.iconImg = [aDecoder decodeObjectForKey:kModelArticleCommentModelIconImg];
    self.statuses = [aDecoder decodeObjectForKey:kModelArticleCommentModelStatuses];
    self.addTime = [aDecoder decodeObjectForKey:kModelArticleCommentModelAddTime];
    self.grade = [aDecoder decodeObjectForKey:kModelArticleCommentModelGrade];
    self.content = [aDecoder decodeObjectForKey:kModelArticleCommentModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commentModelId forKey:kModelArticleCommentModelId];
    [aCoder encodeObject:_addTimeStr forKey:kModelArticleCommentModelAddTimeStr];
    [aCoder encodeObject:_nikename forKey:kModelArticleCommentModelNikename];
    [aCoder encodeObject:_contentPraiseNum forKey:kModelArticleCommentModelContentPraiseNum];
    [aCoder encodeObject:_mobile forKey:kModelArticleCommentModelMobile];
    [aCoder encodeObject:_articleId forKey:kModelArticleCommentModelArticleId];
    [aCoder encodeObject:_contentId forKey:kModelArticleCommentModelContentId];
    [aCoder encodeObject:_img forKey:kModelArticleCommentModelImg];
    [aCoder encodeObject:_userId forKey:kModelArticleCommentModelUserId];
    [aCoder encodeObject:_contentNum forKey:kModelArticleCommentModelContentNum];
    [aCoder encodeObject:_iconImg forKey:kModelArticleCommentModelIconImg];
    [aCoder encodeObject:_statuses forKey:kModelArticleCommentModelStatuses];
    [aCoder encodeObject:_addTime forKey:kModelArticleCommentModelAddTime];
    [aCoder encodeObject:_grade forKey:kModelArticleCommentModelGrade];
    [aCoder encodeObject:_content forKey:kModelArticleCommentModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    ModelArticleCommentModel *copy = [[ModelArticleCommentModel alloc] init];
    
    if (copy) {

        copy.commentModelId = [self.commentModelId copyWithZone:zone];
        copy.addTimeStr = [self.addTimeStr copyWithZone:zone];
        copy.nikename = [self.nikename copyWithZone:zone];
        copy.contentPraiseNum = [self.contentPraiseNum copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.articleId = [self.articleId copyWithZone:zone];
        copy.contentId = [self.contentId copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.contentNum = [self.contentNum copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.statuses = [self.statuses copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.grade = self.grade;
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
