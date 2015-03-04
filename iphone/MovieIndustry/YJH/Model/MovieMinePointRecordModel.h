//
//  MovieMinePointRecordModel.h
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieMinePointRecordModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *jfTime;
@property (nonatomic, strong) NSString *jfUserId;
@property (nonatomic, strong) NSString *jfPoints;
@property (nonatomic, strong) NSString *jfId;
@property (nonatomic, strong) NSString *jfTitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
