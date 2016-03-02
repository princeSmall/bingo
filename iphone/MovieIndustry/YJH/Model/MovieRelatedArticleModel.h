//
//  MovieRelatedArticleModel.h
//
//  Created by MACIO 猫爷 on 15/12/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieRelatedArticleModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *relatedArticleId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
