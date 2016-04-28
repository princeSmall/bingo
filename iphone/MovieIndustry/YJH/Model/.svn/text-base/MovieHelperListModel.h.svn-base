//
//  MovieHelperListModel.h
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieHelperListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *helperId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updateTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
