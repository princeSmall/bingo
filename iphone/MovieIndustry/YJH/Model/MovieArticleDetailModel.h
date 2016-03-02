//
//  MovieArticleDetailModel.h
//
//  Created by MACIO 猫爷 on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieArticleDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *movieArticleDetailModelIdentifier;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *commentNumber;
@property (nonatomic, assign) double clickCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
