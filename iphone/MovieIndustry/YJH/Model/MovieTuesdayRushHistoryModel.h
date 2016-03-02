//
//  MovieTuesdayRushHistoryModel.h
//
//  Created by MACIO 猫爷 on 15/12/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieTuesdayRushHistoryModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *shijain;
@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shu;
@property (nonatomic, strong) NSArray *goods;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
