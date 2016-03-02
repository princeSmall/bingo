//
//  MovieSpecialShowModel.h
//
//  Created by MACIO 猫爷 on 15/12/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieSpecialShowModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *carrousel;
@property (nonatomic, strong) NSArray *sessionList;
@property (nonatomic, strong) NSString *lefttimes;
@property (nonatomic, strong) NSString *countdown;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
