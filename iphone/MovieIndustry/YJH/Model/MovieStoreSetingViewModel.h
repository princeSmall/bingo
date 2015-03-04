//
//  MovieStoreSetingViewModel.h
//
//  Created by MACIO 猫爷 on 15/12/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieStoreSetingViewModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *movieStoreSetingViewModelIdentifier;
@property (nonatomic, strong) NSString *preview;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nnewDpCountTime;
@property (nonatomic, strong) NSString *eventCount;
@property (nonatomic, strong) NSString *locateMatchRow;
@property (nonatomic, strong) NSString *bizOtherLicense;
@property (nonatomic, strong) NSString *avgPoint;
@property (nonatomic, strong) NSString *totalSales;
@property (nonatomic, strong) NSString *shopCount;
@property (nonatomic, strong) NSString *badDpCount;
@property (nonatomic, strong) NSString *isSpace;
@property (nonatomic, strong) NSString *nnewDpCount;
@property (nonatomic, strong) NSString *openTime;
@property (nonatomic, strong) NSString *smsContent;
@property (nonatomic, strong) NSString *ypoint;
@property (nonatomic, strong) NSString *tuanCount;
@property (nonatomic, strong) NSString *supplierId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *goodRate;
@property (nonatomic, strong) NSString *goodDpCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *totalPoint;
@property (nonatomic, strong) NSString *youhuiCount;
@property (nonatomic, strong) NSString *daijinCount;
@property (nonatomic, strong) NSString *indexImg;
@property (nonatomic, strong) NSString *tagsMatch;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *isRecommend;
@property (nonatomic, strong) NSString *refAvgPrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isType;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *commonRate;
@property (nonatomic, strong) NSString *dpCount;
@property (nonatomic, strong) NSString *tagsMatchRow;
@property (nonatomic, strong) NSString *seoDescription;
@property (nonatomic, strong) NSString *nameMatch;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *apiAddress;
@property (nonatomic, strong) NSString *isEffect;
@property (nonatomic, strong) NSString *dealCateId;
@property (nonatomic, strong) NSString *isPoint;
@property (nonatomic, strong) NSString *bizLicense;
@property (nonatomic, strong) NSString *isVerify;
@property (nonatomic, strong) NSString *route;
@property (nonatomic, strong) NSString *imageCount;
@property (nonatomic, strong) NSString *commonDpCount;
@property (nonatomic, strong) NSString *mobileBrief;
@property (nonatomic, strong) NSString *isShop;
@property (nonatomic, strong) NSString *xpoint;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *beiPreview;
@property (nonatomic, strong) NSString *dealCateMatch;
@property (nonatomic, strong) NSString *dealCateMatchRow;
@property (nonatomic, strong) NSString *nameMatchRow;
@property (nonatomic, strong) NSString *tuanYouhuiCache;
@property (nonatomic, strong) NSString *dpGroupPoint;
@property (nonatomic, strong) NSString *isStaff;
@property (nonatomic, strong) NSString *isMain;
@property (nonatomic, strong) NSString *locateMatch;
@property (nonatomic, strong) NSString *seoKeyword;
@property (nonatomic, strong) NSString *seoTitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
