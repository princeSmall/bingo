//
//  MovieTuesdayCommentModel.h
//
//  Created by MACIO 猫爷 on 15/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieTuesdayCommentModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *nikename;
@property (nonatomic, strong) NSString *contentPraiseNum;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSString *ping;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *contentNum;
@property (nonatomic, strong) NSString *iconImg;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
