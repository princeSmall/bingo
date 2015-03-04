//
//  MovieMineInfoModel.m
//
//  Created by MACIO 猫爷 on 15/11/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineInfoModel.h"


NSString *const kMovieMineInfoModelCode = @"code";
NSString *const kMovieMineInfoModelScore = @"score";
NSString *const kMovieMineInfoModelTOpenid = @"t_openid";
NSString *const kMovieMineInfoModelId = @"id";
NSString *const kMovieMineInfoModelSex = @"sex";
NSString *const kMovieMineInfoModelSinaId = @"sina_id";
NSString *const kMovieMineInfoModelFocusCount = @"focus_count";
NSString *const kMovieMineInfoModelIntegrateId = @"integrate_id";
NSString *const kMovieMineInfoModelDarenTitle = @"daren_title";
NSString *const kMovieMineInfoModelTencentId = @"tencent_id";
NSString *const kMovieMineInfoModelVerifyCreateTime = @"verify_create_time";
NSString *const kMovieMineInfoModelLoginTime = @"login_time";
NSString *const kMovieMineInfoModelReferralCount = @"referral_count";
NSString *const kMovieMineInfoModelRank = @"rank";
NSString *const kMovieMineInfoModelFavCount = @"fav_count";
NSString *const kMovieMineInfoModelGroupId = @"group_id";
NSString *const kMovieMineInfoModelYpoint = @"ypoint";
NSString *const kMovieMineInfoModelLotteryVerify = @"lottery_verify";
NSString *const kMovieMineInfoModelAddressId = @"address_id";
NSString *const kMovieMineInfoModelCityId = @"city_id";
NSString *const kMovieMineInfoModelLocateTime = @"locate_time";
NSString *const kMovieMineInfoModelComeFrom = @"come_from";
NSString *const kMovieMineInfoModelSinaAppKey = @"sina_app_key";
NSString *const kMovieMineInfoModelByear = @"byear";
NSString *const kMovieMineInfoModelRenrenId = @"renren_id";
NSString *const kMovieMineInfoModelTOpenkey = @"t_openkey";
NSString *const kMovieMineInfoModelInsiteCount = @"insite_count";
NSString *const kMovieMineInfoModelOutsiteCount = @"outsite_count";
NSString *const kMovieMineInfoModelIsSynSina = @"is_syn_sina";
NSString *const kMovieMineInfoModelLocationId = @"location_id";
NSString *const kMovieMineInfoModelTencentAppSecret = @"tencent_app_secret";
NSString *const kMovieMineInfoModelUpdateTime = @"update_time";
NSString *const kMovieMineInfoModelTencentAppKey = @"tencent_app_key";
NSString *const kMovieMineInfoModelSinaAppSecret = @"sina_app_secret";
NSString *const kMovieMineInfoModelBmonth = @"bmonth";
NSString *const kMovieMineInfoModelNikename = @"nikename";
NSString *const kMovieMineInfoModelUserPwd = @"user_pwd";
NSString *const kMovieMineInfoModelRongyunToken = @"rongyun_token";
NSString *const kMovieMineInfoModelCreateTime = @"create_time";
NSString *const kMovieMineInfoModelReferer = @"referer";
NSString *const kMovieMineInfoModelKaixinId = @"kaixin_id";
NSString *const kMovieMineInfoModelIsDaren = @"is_daren";
NSString *const kMovieMineInfoModelIsSynTencent = @"is_syn_tencent";
NSString *const kMovieMineInfoModelMyAddress = @"my_address";
NSString *const kMovieMineInfoModelEmail = @"email";
NSString *const kMovieMineInfoModelSinaToken = @"sina_token";
NSString *const kMovieMineInfoModelMyIntro = @"my_intro";
NSString *const kMovieMineInfoModelBday = @"bday";
NSString *const kMovieMineInfoModelDpCount = @"dp_count";
NSString *const kMovieMineInfoModelIsDelete = @"is_delete";
NSString *const kMovieMineInfoModelPid = @"pid";
NSString *const kMovieMineInfoModelFavedCount = @"faved_count";
NSString *const kMovieMineInfoModelMoney = @"money";
NSString *const kMovieMineInfoModelTAccessToken = @"t_access_token";
NSString *const kMovieMineInfoModelIconImg = @"icon_img";
NSString *const kMovieMineInfoModelIsEffect = @"is_effect";
NSString *const kMovieMineInfoModelLotteryMobile = @"lottery_mobile";
NSString *const kMovieMineInfoModelProfession = @"profession";
NSString *const kMovieMineInfoModelLoginIp = @"login_ip";
NSString *const kMovieMineInfoModelStep = @"step";
NSString *const kMovieMineInfoModelFocusedCount = @"focused_count";
NSString *const kMovieMineInfoModelPasswordVerify = @"password_verify";
NSString *const kMovieMineInfoModelMerchantName = @"merchant_name";
NSString *const kMovieMineInfoModelVerify = @"verify";
NSString *const kMovieMineInfoModelIsMerchant = @"is_merchant";
NSString *const kMovieMineInfoModelPoint = @"point";
NSString *const kMovieMineInfoModelXpoint = @"xpoint";
NSString *const kMovieMineInfoModelIsPhoto = @"is_photo";
NSString *const kMovieMineInfoModelSohuId = @"sohu_id";
NSString *const kMovieMineInfoModelUserName = @"user_name";
NSString *const kMovieMineInfoModelMobile = @"mobile";
NSString *const kMovieMineInfoModelLoginPayTime = @"login_pay_time";
NSString *const kMovieMineInfoModelLevelId = @"level_id";
NSString *const kMovieMineInfoModelTopicCount = @"topic_count";
NSString *const kMovieMineInfoModelProvinceId = @"province_id";


@interface MovieMineInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineInfoModel

@synthesize code = _code;
@synthesize score = _score;
@synthesize tOpenid = _tOpenid;
@synthesize movieMineInfoModelIdentifier = _movieMineInfoModelIdentifier;
@synthesize sex = _sex;
@synthesize sinaId = _sinaId;
@synthesize focusCount = _focusCount;
@synthesize integrateId = _integrateId;
@synthesize darenTitle = _darenTitle;
@synthesize tencentId = _tencentId;
@synthesize verifyCreateTime = _verifyCreateTime;
@synthesize loginTime = _loginTime;
@synthesize referralCount = _referralCount;
@synthesize rank = _rank;
@synthesize favCount = _favCount;
@synthesize groupId = _groupId;
@synthesize ypoint = _ypoint;
@synthesize lotteryVerify = _lotteryVerify;
@synthesize addressId = _addressId;
@synthesize cityId = _cityId;
@synthesize locateTime = _locateTime;
@synthesize comeFrom = _comeFrom;
@synthesize sinaAppKey = _sinaAppKey;
@synthesize byear = _byear;
@synthesize renrenId = _renrenId;
@synthesize tOpenkey = _tOpenkey;
@synthesize insiteCount = _insiteCount;
@synthesize outsiteCount = _outsiteCount;
@synthesize isSynSina = _isSynSina;
@synthesize locationId = _locationId;
@synthesize tencentAppSecret = _tencentAppSecret;
@synthesize updateTime = _updateTime;
@synthesize tencentAppKey = _tencentAppKey;
@synthesize sinaAppSecret = _sinaAppSecret;
@synthesize bmonth = _bmonth;
@synthesize nikename = _nikename;
@synthesize userPwd = _userPwd;
@synthesize rongyunToken = _rongyunToken;
@synthesize createTime = _createTime;
@synthesize referer = _referer;
@synthesize kaixinId = _kaixinId;
@synthesize isDaren = _isDaren;
@synthesize isSynTencent = _isSynTencent;
@synthesize myAddress = _myAddress;
@synthesize email = _email;
@synthesize sinaToken = _sinaToken;
@synthesize myIntro = _myIntro;
@synthesize bday = _bday;
@synthesize dpCount = _dpCount;
@synthesize isDelete = _isDelete;
@synthesize pid = _pid;
@synthesize favedCount = _favedCount;
@synthesize money = _money;
@synthesize tAccessToken = _tAccessToken;
@synthesize iconImg = _iconImg;
@synthesize isEffect = _isEffect;
@synthesize lotteryMobile = _lotteryMobile;
@synthesize profession = _profession;
@synthesize loginIp = _loginIp;
@synthesize step = _step;
@synthesize focusedCount = _focusedCount;
@synthesize passwordVerify = _passwordVerify;
@synthesize merchantName = _merchantName;
@synthesize verify = _verify;
@synthesize isMerchant = _isMerchant;
@synthesize point = _point;
@synthesize xpoint = _xpoint;
@synthesize isPhoto = _isPhoto;
@synthesize sohuId = _sohuId;
@synthesize userName = _userName;
@synthesize mobile = _mobile;
@synthesize loginPayTime = _loginPayTime;
@synthesize levelId = _levelId;
@synthesize topicCount = _topicCount;
@synthesize provinceId = _provinceId;


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
            self.code = [self objectOrNilForKey:kMovieMineInfoModelCode fromDictionary:dict];
            self.score = [self objectOrNilForKey:kMovieMineInfoModelScore fromDictionary:dict];
            self.tOpenid = [self objectOrNilForKey:kMovieMineInfoModelTOpenid fromDictionary:dict];
            self.movieMineInfoModelIdentifier = [self objectOrNilForKey:kMovieMineInfoModelId fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kMovieMineInfoModelSex fromDictionary:dict];
            self.sinaId = [self objectOrNilForKey:kMovieMineInfoModelSinaId fromDictionary:dict];
            self.focusCount = [self objectOrNilForKey:kMovieMineInfoModelFocusCount fromDictionary:dict];
            self.integrateId = [self objectOrNilForKey:kMovieMineInfoModelIntegrateId fromDictionary:dict];
            self.darenTitle = [self objectOrNilForKey:kMovieMineInfoModelDarenTitle fromDictionary:dict];
            self.tencentId = [self objectOrNilForKey:kMovieMineInfoModelTencentId fromDictionary:dict];
            self.verifyCreateTime = [self objectOrNilForKey:kMovieMineInfoModelVerifyCreateTime fromDictionary:dict];
            self.loginTime = [self objectOrNilForKey:kMovieMineInfoModelLoginTime fromDictionary:dict];
            self.referralCount = [self objectOrNilForKey:kMovieMineInfoModelReferralCount fromDictionary:dict];
            self.rank = [self objectOrNilForKey:kMovieMineInfoModelRank fromDictionary:dict];
            self.favCount = [self objectOrNilForKey:kMovieMineInfoModelFavCount fromDictionary:dict];
            self.groupId = [self objectOrNilForKey:kMovieMineInfoModelGroupId fromDictionary:dict];
            self.ypoint = [self objectOrNilForKey:kMovieMineInfoModelYpoint fromDictionary:dict];
            self.lotteryVerify = [self objectOrNilForKey:kMovieMineInfoModelLotteryVerify fromDictionary:dict];
            self.addressId = [self objectOrNilForKey:kMovieMineInfoModelAddressId fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:kMovieMineInfoModelCityId fromDictionary:dict];
            self.locateTime = [self objectOrNilForKey:kMovieMineInfoModelLocateTime fromDictionary:dict];
            self.comeFrom = [self objectOrNilForKey:kMovieMineInfoModelComeFrom fromDictionary:dict];
            self.sinaAppKey = [self objectOrNilForKey:kMovieMineInfoModelSinaAppKey fromDictionary:dict];
            self.byear = [self objectOrNilForKey:kMovieMineInfoModelByear fromDictionary:dict];
            self.renrenId = [self objectOrNilForKey:kMovieMineInfoModelRenrenId fromDictionary:dict];
            self.tOpenkey = [self objectOrNilForKey:kMovieMineInfoModelTOpenkey fromDictionary:dict];
            self.insiteCount = [self objectOrNilForKey:kMovieMineInfoModelInsiteCount fromDictionary:dict];
            self.outsiteCount = [self objectOrNilForKey:kMovieMineInfoModelOutsiteCount fromDictionary:dict];
            self.isSynSina = [self objectOrNilForKey:kMovieMineInfoModelIsSynSina fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kMovieMineInfoModelLocationId fromDictionary:dict];
            self.tencentAppSecret = [self objectOrNilForKey:kMovieMineInfoModelTencentAppSecret fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieMineInfoModelUpdateTime fromDictionary:dict];
            self.tencentAppKey = [self objectOrNilForKey:kMovieMineInfoModelTencentAppKey fromDictionary:dict];
            self.sinaAppSecret = [self objectOrNilForKey:kMovieMineInfoModelSinaAppSecret fromDictionary:dict];
            self.bmonth = [self objectOrNilForKey:kMovieMineInfoModelBmonth fromDictionary:dict];
            self.nikename = [self objectOrNilForKey:kMovieMineInfoModelNikename fromDictionary:dict];
            self.userPwd = [self objectOrNilForKey:kMovieMineInfoModelUserPwd fromDictionary:dict];
            self.rongyunToken = [self objectOrNilForKey:kMovieMineInfoModelRongyunToken fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kMovieMineInfoModelCreateTime fromDictionary:dict];
            self.referer = [self objectOrNilForKey:kMovieMineInfoModelReferer fromDictionary:dict];
            self.kaixinId = [self objectOrNilForKey:kMovieMineInfoModelKaixinId fromDictionary:dict];
            self.isDaren = [self objectOrNilForKey:kMovieMineInfoModelIsDaren fromDictionary:dict];
            self.isSynTencent = [self objectOrNilForKey:kMovieMineInfoModelIsSynTencent fromDictionary:dict];
            self.myAddress = [self objectOrNilForKey:kMovieMineInfoModelMyAddress fromDictionary:dict];
            self.email = [self objectOrNilForKey:kMovieMineInfoModelEmail fromDictionary:dict];
            self.sinaToken = [self objectOrNilForKey:kMovieMineInfoModelSinaToken fromDictionary:dict];
            self.myIntro = [self objectOrNilForKey:kMovieMineInfoModelMyIntro fromDictionary:dict];
            self.bday = [self objectOrNilForKey:kMovieMineInfoModelBday fromDictionary:dict];
            self.dpCount = [self objectOrNilForKey:kMovieMineInfoModelDpCount fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kMovieMineInfoModelIsDelete fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kMovieMineInfoModelPid fromDictionary:dict];
            self.favedCount = [self objectOrNilForKey:kMovieMineInfoModelFavedCount fromDictionary:dict];
            self.money = [self objectOrNilForKey:kMovieMineInfoModelMoney fromDictionary:dict];
            self.tAccessToken = [self objectOrNilForKey:kMovieMineInfoModelTAccessToken fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kMovieMineInfoModelIconImg fromDictionary:dict];
            self.isEffect = [self objectOrNilForKey:kMovieMineInfoModelIsEffect fromDictionary:dict];
            self.lotteryMobile = [self objectOrNilForKey:kMovieMineInfoModelLotteryMobile fromDictionary:dict];
            self.profession = [self objectOrNilForKey:kMovieMineInfoModelProfession fromDictionary:dict];
            self.loginIp = [self objectOrNilForKey:kMovieMineInfoModelLoginIp fromDictionary:dict];
            self.step = [self objectOrNilForKey:kMovieMineInfoModelStep fromDictionary:dict];
            self.focusedCount = [self objectOrNilForKey:kMovieMineInfoModelFocusedCount fromDictionary:dict];
            self.passwordVerify = [self objectOrNilForKey:kMovieMineInfoModelPasswordVerify fromDictionary:dict];
            self.merchantName = [self objectOrNilForKey:kMovieMineInfoModelMerchantName fromDictionary:dict];
            self.verify = [self objectOrNilForKey:kMovieMineInfoModelVerify fromDictionary:dict];
            self.isMerchant = [self objectOrNilForKey:kMovieMineInfoModelIsMerchant fromDictionary:dict];
            self.point = [self objectOrNilForKey:kMovieMineInfoModelPoint fromDictionary:dict];
            self.xpoint = [self objectOrNilForKey:kMovieMineInfoModelXpoint fromDictionary:dict];
            self.isPhoto = [self objectOrNilForKey:kMovieMineInfoModelIsPhoto fromDictionary:dict];
            self.sohuId = [self objectOrNilForKey:kMovieMineInfoModelSohuId fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kMovieMineInfoModelUserName fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kMovieMineInfoModelMobile fromDictionary:dict];
            self.loginPayTime = [self objectOrNilForKey:kMovieMineInfoModelLoginPayTime fromDictionary:dict];
            self.levelId = [self objectOrNilForKey:kMovieMineInfoModelLevelId fromDictionary:dict];
            self.topicCount = [self objectOrNilForKey:kMovieMineInfoModelTopicCount fromDictionary:dict];
            self.provinceId = [self objectOrNilForKey:kMovieMineInfoModelProvinceId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.code forKey:kMovieMineInfoModelCode];
    [mutableDict setValue:self.score forKey:kMovieMineInfoModelScore];
    [mutableDict setValue:self.tOpenid forKey:kMovieMineInfoModelTOpenid];
    [mutableDict setValue:self.movieMineInfoModelIdentifier forKey:kMovieMineInfoModelId];
    [mutableDict setValue:self.sex forKey:kMovieMineInfoModelSex];
    [mutableDict setValue:self.sinaId forKey:kMovieMineInfoModelSinaId];
    [mutableDict setValue:self.focusCount forKey:kMovieMineInfoModelFocusCount];
    [mutableDict setValue:self.integrateId forKey:kMovieMineInfoModelIntegrateId];
    [mutableDict setValue:self.darenTitle forKey:kMovieMineInfoModelDarenTitle];
    [mutableDict setValue:self.tencentId forKey:kMovieMineInfoModelTencentId];
    [mutableDict setValue:self.verifyCreateTime forKey:kMovieMineInfoModelVerifyCreateTime];
    [mutableDict setValue:self.loginTime forKey:kMovieMineInfoModelLoginTime];
    [mutableDict setValue:self.referralCount forKey:kMovieMineInfoModelReferralCount];
    [mutableDict setValue:self.rank forKey:kMovieMineInfoModelRank];
    [mutableDict setValue:self.favCount forKey:kMovieMineInfoModelFavCount];
    [mutableDict setValue:self.groupId forKey:kMovieMineInfoModelGroupId];
    [mutableDict setValue:self.ypoint forKey:kMovieMineInfoModelYpoint];
    [mutableDict setValue:self.lotteryVerify forKey:kMovieMineInfoModelLotteryVerify];
    [mutableDict setValue:self.addressId forKey:kMovieMineInfoModelAddressId];
    [mutableDict setValue:self.cityId forKey:kMovieMineInfoModelCityId];
    [mutableDict setValue:self.locateTime forKey:kMovieMineInfoModelLocateTime];
    [mutableDict setValue:self.comeFrom forKey:kMovieMineInfoModelComeFrom];
    [mutableDict setValue:self.sinaAppKey forKey:kMovieMineInfoModelSinaAppKey];
    [mutableDict setValue:self.byear forKey:kMovieMineInfoModelByear];
    [mutableDict setValue:self.renrenId forKey:kMovieMineInfoModelRenrenId];
    [mutableDict setValue:self.tOpenkey forKey:kMovieMineInfoModelTOpenkey];
    [mutableDict setValue:self.insiteCount forKey:kMovieMineInfoModelInsiteCount];
    [mutableDict setValue:self.outsiteCount forKey:kMovieMineInfoModelOutsiteCount];
    [mutableDict setValue:self.isSynSina forKey:kMovieMineInfoModelIsSynSina];
    [mutableDict setValue:self.locationId forKey:kMovieMineInfoModelLocationId];
    [mutableDict setValue:self.tencentAppSecret forKey:kMovieMineInfoModelTencentAppSecret];
    [mutableDict setValue:self.updateTime forKey:kMovieMineInfoModelUpdateTime];
    [mutableDict setValue:self.tencentAppKey forKey:kMovieMineInfoModelTencentAppKey];
    [mutableDict setValue:self.sinaAppSecret forKey:kMovieMineInfoModelSinaAppSecret];
    [mutableDict setValue:self.bmonth forKey:kMovieMineInfoModelBmonth];
    [mutableDict setValue:self.nikename forKey:kMovieMineInfoModelNikename];
    [mutableDict setValue:self.userPwd forKey:kMovieMineInfoModelUserPwd];
    [mutableDict setValue:self.rongyunToken forKey:kMovieMineInfoModelRongyunToken];
    [mutableDict setValue:self.createTime forKey:kMovieMineInfoModelCreateTime];
    [mutableDict setValue:self.referer forKey:kMovieMineInfoModelReferer];
    [mutableDict setValue:self.kaixinId forKey:kMovieMineInfoModelKaixinId];
    [mutableDict setValue:self.isDaren forKey:kMovieMineInfoModelIsDaren];
    [mutableDict setValue:self.isSynTencent forKey:kMovieMineInfoModelIsSynTencent];
    [mutableDict setValue:self.myAddress forKey:kMovieMineInfoModelMyAddress];
    [mutableDict setValue:self.email forKey:kMovieMineInfoModelEmail];
    [mutableDict setValue:self.sinaToken forKey:kMovieMineInfoModelSinaToken];
    [mutableDict setValue:self.myIntro forKey:kMovieMineInfoModelMyIntro];
    [mutableDict setValue:self.bday forKey:kMovieMineInfoModelBday];
    [mutableDict setValue:self.dpCount forKey:kMovieMineInfoModelDpCount];
    [mutableDict setValue:self.isDelete forKey:kMovieMineInfoModelIsDelete];
    [mutableDict setValue:self.pid forKey:kMovieMineInfoModelPid];
    [mutableDict setValue:self.favedCount forKey:kMovieMineInfoModelFavedCount];
    [mutableDict setValue:self.money forKey:kMovieMineInfoModelMoney];
    [mutableDict setValue:self.tAccessToken forKey:kMovieMineInfoModelTAccessToken];
    [mutableDict setValue:self.iconImg forKey:kMovieMineInfoModelIconImg];
    [mutableDict setValue:self.isEffect forKey:kMovieMineInfoModelIsEffect];
    [mutableDict setValue:self.lotteryMobile forKey:kMovieMineInfoModelLotteryMobile];
    [mutableDict setValue:self.profession forKey:kMovieMineInfoModelProfession];
    [mutableDict setValue:self.loginIp forKey:kMovieMineInfoModelLoginIp];
    [mutableDict setValue:self.step forKey:kMovieMineInfoModelStep];
    [mutableDict setValue:self.focusedCount forKey:kMovieMineInfoModelFocusedCount];
    [mutableDict setValue:self.passwordVerify forKey:kMovieMineInfoModelPasswordVerify];
    [mutableDict setValue:self.merchantName forKey:kMovieMineInfoModelMerchantName];
    [mutableDict setValue:self.verify forKey:kMovieMineInfoModelVerify];
    [mutableDict setValue:self.isMerchant forKey:kMovieMineInfoModelIsMerchant];
    [mutableDict setValue:self.point forKey:kMovieMineInfoModelPoint];
    [mutableDict setValue:self.xpoint forKey:kMovieMineInfoModelXpoint];
    [mutableDict setValue:self.isPhoto forKey:kMovieMineInfoModelIsPhoto];
    [mutableDict setValue:self.sohuId forKey:kMovieMineInfoModelSohuId];
    [mutableDict setValue:self.userName forKey:kMovieMineInfoModelUserName];
    [mutableDict setValue:self.mobile forKey:kMovieMineInfoModelMobile];
    [mutableDict setValue:self.loginPayTime forKey:kMovieMineInfoModelLoginPayTime];
    [mutableDict setValue:self.levelId forKey:kMovieMineInfoModelLevelId];
    [mutableDict setValue:self.topicCount forKey:kMovieMineInfoModelTopicCount];
    [mutableDict setValue:self.provinceId forKey:kMovieMineInfoModelProvinceId];

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

    self.code = [aDecoder decodeObjectForKey:kMovieMineInfoModelCode];
    self.score = [aDecoder decodeObjectForKey:kMovieMineInfoModelScore];
    self.tOpenid = [aDecoder decodeObjectForKey:kMovieMineInfoModelTOpenid];
    self.movieMineInfoModelIdentifier = [aDecoder decodeObjectForKey:kMovieMineInfoModelId];
    self.sex = [aDecoder decodeObjectForKey:kMovieMineInfoModelSex];
    self.sinaId = [aDecoder decodeObjectForKey:kMovieMineInfoModelSinaId];
    self.focusCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelFocusCount];
    self.integrateId = [aDecoder decodeObjectForKey:kMovieMineInfoModelIntegrateId];
    self.darenTitle = [aDecoder decodeObjectForKey:kMovieMineInfoModelDarenTitle];
    self.tencentId = [aDecoder decodeObjectForKey:kMovieMineInfoModelTencentId];
    self.verifyCreateTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelVerifyCreateTime];
    self.loginTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelLoginTime];
    self.referralCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelReferralCount];
    self.rank = [aDecoder decodeObjectForKey:kMovieMineInfoModelRank];
    self.favCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelFavCount];
    self.groupId = [aDecoder decodeObjectForKey:kMovieMineInfoModelGroupId];
    self.ypoint = [aDecoder decodeObjectForKey:kMovieMineInfoModelYpoint];
    self.lotteryVerify = [aDecoder decodeObjectForKey:kMovieMineInfoModelLotteryVerify];
    self.addressId = [aDecoder decodeObjectForKey:kMovieMineInfoModelAddressId];
    self.cityId = [aDecoder decodeObjectForKey:kMovieMineInfoModelCityId];
    self.locateTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelLocateTime];
    self.comeFrom = [aDecoder decodeObjectForKey:kMovieMineInfoModelComeFrom];
    self.sinaAppKey = [aDecoder decodeObjectForKey:kMovieMineInfoModelSinaAppKey];
    self.byear = [aDecoder decodeObjectForKey:kMovieMineInfoModelByear];
    self.renrenId = [aDecoder decodeObjectForKey:kMovieMineInfoModelRenrenId];
    self.tOpenkey = [aDecoder decodeObjectForKey:kMovieMineInfoModelTOpenkey];
    self.insiteCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelInsiteCount];
    self.outsiteCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelOutsiteCount];
    self.isSynSina = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsSynSina];
    self.locationId = [aDecoder decodeObjectForKey:kMovieMineInfoModelLocationId];
    self.tencentAppSecret = [aDecoder decodeObjectForKey:kMovieMineInfoModelTencentAppSecret];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelUpdateTime];
    self.tencentAppKey = [aDecoder decodeObjectForKey:kMovieMineInfoModelTencentAppKey];
    self.sinaAppSecret = [aDecoder decodeObjectForKey:kMovieMineInfoModelSinaAppSecret];
    self.bmonth = [aDecoder decodeObjectForKey:kMovieMineInfoModelBmonth];
    self.nikename = [aDecoder decodeObjectForKey:kMovieMineInfoModelNikename];
    self.userPwd = [aDecoder decodeObjectForKey:kMovieMineInfoModelUserPwd];
    self.rongyunToken = [aDecoder decodeObjectForKey:kMovieMineInfoModelRongyunToken];
    self.createTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelCreateTime];
    self.referer = [aDecoder decodeObjectForKey:kMovieMineInfoModelReferer];
    self.kaixinId = [aDecoder decodeObjectForKey:kMovieMineInfoModelKaixinId];
    self.isDaren = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsDaren];
    self.isSynTencent = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsSynTencent];
    self.myAddress = [aDecoder decodeObjectForKey:kMovieMineInfoModelMyAddress];
    self.email = [aDecoder decodeObjectForKey:kMovieMineInfoModelEmail];
    self.sinaToken = [aDecoder decodeObjectForKey:kMovieMineInfoModelSinaToken];
    self.myIntro = [aDecoder decodeObjectForKey:kMovieMineInfoModelMyIntro];
    self.bday = [aDecoder decodeObjectForKey:kMovieMineInfoModelBday];
    self.dpCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelDpCount];
    self.isDelete = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsDelete];
    self.pid = [aDecoder decodeObjectForKey:kMovieMineInfoModelPid];
    self.favedCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelFavedCount];
    self.money = [aDecoder decodeObjectForKey:kMovieMineInfoModelMoney];
    self.tAccessToken = [aDecoder decodeObjectForKey:kMovieMineInfoModelTAccessToken];
    self.iconImg = [aDecoder decodeObjectForKey:kMovieMineInfoModelIconImg];
    self.isEffect = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsEffect];
    self.lotteryMobile = [aDecoder decodeObjectForKey:kMovieMineInfoModelLotteryMobile];
    self.profession = [aDecoder decodeObjectForKey:kMovieMineInfoModelProfession];
    self.loginIp = [aDecoder decodeObjectForKey:kMovieMineInfoModelLoginIp];
    self.step = [aDecoder decodeObjectForKey:kMovieMineInfoModelStep];
    self.focusedCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelFocusedCount];
    self.passwordVerify = [aDecoder decodeObjectForKey:kMovieMineInfoModelPasswordVerify];
    self.merchantName = [aDecoder decodeObjectForKey:kMovieMineInfoModelMerchantName];
    self.verify = [aDecoder decodeObjectForKey:kMovieMineInfoModelVerify];
    self.isMerchant = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsMerchant];
    self.point = [aDecoder decodeObjectForKey:kMovieMineInfoModelPoint];
    self.xpoint = [aDecoder decodeObjectForKey:kMovieMineInfoModelXpoint];
    self.isPhoto = [aDecoder decodeObjectForKey:kMovieMineInfoModelIsPhoto];
    self.sohuId = [aDecoder decodeObjectForKey:kMovieMineInfoModelSohuId];
    self.userName = [aDecoder decodeObjectForKey:kMovieMineInfoModelUserName];
    self.mobile = [aDecoder decodeObjectForKey:kMovieMineInfoModelMobile];
    self.loginPayTime = [aDecoder decodeObjectForKey:kMovieMineInfoModelLoginPayTime];
    self.levelId = [aDecoder decodeObjectForKey:kMovieMineInfoModelLevelId];
    self.topicCount = [aDecoder decodeObjectForKey:kMovieMineInfoModelTopicCount];
    self.provinceId = [aDecoder decodeObjectForKey:kMovieMineInfoModelProvinceId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_code forKey:kMovieMineInfoModelCode];
    [aCoder encodeObject:_score forKey:kMovieMineInfoModelScore];
    [aCoder encodeObject:_tOpenid forKey:kMovieMineInfoModelTOpenid];
    [aCoder encodeObject:_movieMineInfoModelIdentifier forKey:kMovieMineInfoModelId];
    [aCoder encodeObject:_sex forKey:kMovieMineInfoModelSex];
    [aCoder encodeObject:_sinaId forKey:kMovieMineInfoModelSinaId];
    [aCoder encodeObject:_focusCount forKey:kMovieMineInfoModelFocusCount];
    [aCoder encodeObject:_integrateId forKey:kMovieMineInfoModelIntegrateId];
    [aCoder encodeObject:_darenTitle forKey:kMovieMineInfoModelDarenTitle];
    [aCoder encodeObject:_tencentId forKey:kMovieMineInfoModelTencentId];
    [aCoder encodeObject:_verifyCreateTime forKey:kMovieMineInfoModelVerifyCreateTime];
    [aCoder encodeObject:_loginTime forKey:kMovieMineInfoModelLoginTime];
    [aCoder encodeObject:_referralCount forKey:kMovieMineInfoModelReferralCount];
    [aCoder encodeObject:_rank forKey:kMovieMineInfoModelRank];
    [aCoder encodeObject:_favCount forKey:kMovieMineInfoModelFavCount];
    [aCoder encodeObject:_groupId forKey:kMovieMineInfoModelGroupId];
    [aCoder encodeObject:_ypoint forKey:kMovieMineInfoModelYpoint];
    [aCoder encodeObject:_lotteryVerify forKey:kMovieMineInfoModelLotteryVerify];
    [aCoder encodeObject:_addressId forKey:kMovieMineInfoModelAddressId];
    [aCoder encodeObject:_cityId forKey:kMovieMineInfoModelCityId];
    [aCoder encodeObject:_locateTime forKey:kMovieMineInfoModelLocateTime];
    [aCoder encodeObject:_comeFrom forKey:kMovieMineInfoModelComeFrom];
    [aCoder encodeObject:_sinaAppKey forKey:kMovieMineInfoModelSinaAppKey];
    [aCoder encodeObject:_byear forKey:kMovieMineInfoModelByear];
    [aCoder encodeObject:_renrenId forKey:kMovieMineInfoModelRenrenId];
    [aCoder encodeObject:_tOpenkey forKey:kMovieMineInfoModelTOpenkey];
    [aCoder encodeObject:_insiteCount forKey:kMovieMineInfoModelInsiteCount];
    [aCoder encodeObject:_outsiteCount forKey:kMovieMineInfoModelOutsiteCount];
    [aCoder encodeObject:_isSynSina forKey:kMovieMineInfoModelIsSynSina];
    [aCoder encodeObject:_locationId forKey:kMovieMineInfoModelLocationId];
    [aCoder encodeObject:_tencentAppSecret forKey:kMovieMineInfoModelTencentAppSecret];
    [aCoder encodeObject:_updateTime forKey:kMovieMineInfoModelUpdateTime];
    [aCoder encodeObject:_tencentAppKey forKey:kMovieMineInfoModelTencentAppKey];
    [aCoder encodeObject:_sinaAppSecret forKey:kMovieMineInfoModelSinaAppSecret];
    [aCoder encodeObject:_bmonth forKey:kMovieMineInfoModelBmonth];
    [aCoder encodeObject:_nikename forKey:kMovieMineInfoModelNikename];
    [aCoder encodeObject:_userPwd forKey:kMovieMineInfoModelUserPwd];
    [aCoder encodeObject:_rongyunToken forKey:kMovieMineInfoModelRongyunToken];
    [aCoder encodeObject:_createTime forKey:kMovieMineInfoModelCreateTime];
    [aCoder encodeObject:_referer forKey:kMovieMineInfoModelReferer];
    [aCoder encodeObject:_kaixinId forKey:kMovieMineInfoModelKaixinId];
    [aCoder encodeObject:_isDaren forKey:kMovieMineInfoModelIsDaren];
    [aCoder encodeObject:_isSynTencent forKey:kMovieMineInfoModelIsSynTencent];
    [aCoder encodeObject:_myAddress forKey:kMovieMineInfoModelMyAddress];
    [aCoder encodeObject:_email forKey:kMovieMineInfoModelEmail];
    [aCoder encodeObject:_sinaToken forKey:kMovieMineInfoModelSinaToken];
    [aCoder encodeObject:_myIntro forKey:kMovieMineInfoModelMyIntro];
    [aCoder encodeObject:_bday forKey:kMovieMineInfoModelBday];
    [aCoder encodeObject:_dpCount forKey:kMovieMineInfoModelDpCount];
    [aCoder encodeObject:_isDelete forKey:kMovieMineInfoModelIsDelete];
    [aCoder encodeObject:_pid forKey:kMovieMineInfoModelPid];
    [aCoder encodeObject:_favedCount forKey:kMovieMineInfoModelFavedCount];
    [aCoder encodeObject:_money forKey:kMovieMineInfoModelMoney];
    [aCoder encodeObject:_tAccessToken forKey:kMovieMineInfoModelTAccessToken];
    [aCoder encodeObject:_iconImg forKey:kMovieMineInfoModelIconImg];
    [aCoder encodeObject:_isEffect forKey:kMovieMineInfoModelIsEffect];
    [aCoder encodeObject:_lotteryMobile forKey:kMovieMineInfoModelLotteryMobile];
    [aCoder encodeObject:_profession forKey:kMovieMineInfoModelProfession];
    [aCoder encodeObject:_loginIp forKey:kMovieMineInfoModelLoginIp];
    [aCoder encodeObject:_step forKey:kMovieMineInfoModelStep];
    [aCoder encodeObject:_focusedCount forKey:kMovieMineInfoModelFocusedCount];
    [aCoder encodeObject:_passwordVerify forKey:kMovieMineInfoModelPasswordVerify];
    [aCoder encodeObject:_merchantName forKey:kMovieMineInfoModelMerchantName];
    [aCoder encodeObject:_verify forKey:kMovieMineInfoModelVerify];
    [aCoder encodeObject:_isMerchant forKey:kMovieMineInfoModelIsMerchant];
    [aCoder encodeObject:_point forKey:kMovieMineInfoModelPoint];
    [aCoder encodeObject:_xpoint forKey:kMovieMineInfoModelXpoint];
    [aCoder encodeObject:_isPhoto forKey:kMovieMineInfoModelIsPhoto];
    [aCoder encodeObject:_sohuId forKey:kMovieMineInfoModelSohuId];
    [aCoder encodeObject:_userName forKey:kMovieMineInfoModelUserName];
    [aCoder encodeObject:_mobile forKey:kMovieMineInfoModelMobile];
    [aCoder encodeObject:_loginPayTime forKey:kMovieMineInfoModelLoginPayTime];
    [aCoder encodeObject:_levelId forKey:kMovieMineInfoModelLevelId];
    [aCoder encodeObject:_topicCount forKey:kMovieMineInfoModelTopicCount];
    [aCoder encodeObject:_provinceId forKey:kMovieMineInfoModelProvinceId];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineInfoModel *copy = [[MovieMineInfoModel alloc] init];
    
    if (copy) {

        copy.code = [self.code copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.tOpenid = [self.tOpenid copyWithZone:zone];
        copy.movieMineInfoModelIdentifier = [self.movieMineInfoModelIdentifier copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.sinaId = [self.sinaId copyWithZone:zone];
        copy.focusCount = [self.focusCount copyWithZone:zone];
        copy.integrateId = [self.integrateId copyWithZone:zone];
        copy.darenTitle = [self.darenTitle copyWithZone:zone];
        copy.tencentId = [self.tencentId copyWithZone:zone];
        copy.verifyCreateTime = [self.verifyCreateTime copyWithZone:zone];
        copy.loginTime = [self.loginTime copyWithZone:zone];
        copy.referralCount = [self.referralCount copyWithZone:zone];
        copy.rank = [self.rank copyWithZone:zone];
        copy.favCount = [self.favCount copyWithZone:zone];
        copy.groupId = [self.groupId copyWithZone:zone];
        copy.ypoint = [self.ypoint copyWithZone:zone];
        copy.lotteryVerify = [self.lotteryVerify copyWithZone:zone];
        copy.addressId = [self.addressId copyWithZone:zone];
        copy.cityId = [self.cityId copyWithZone:zone];
        copy.locateTime = [self.locateTime copyWithZone:zone];
        copy.comeFrom = [self.comeFrom copyWithZone:zone];
        copy.sinaAppKey = [self.sinaAppKey copyWithZone:zone];
        copy.byear = [self.byear copyWithZone:zone];
        copy.renrenId = [self.renrenId copyWithZone:zone];
        copy.tOpenkey = [self.tOpenkey copyWithZone:zone];
        copy.insiteCount = [self.insiteCount copyWithZone:zone];
        copy.outsiteCount = [self.outsiteCount copyWithZone:zone];
        copy.isSynSina = [self.isSynSina copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.tencentAppSecret = [self.tencentAppSecret copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.tencentAppKey = [self.tencentAppKey copyWithZone:zone];
        copy.sinaAppSecret = [self.sinaAppSecret copyWithZone:zone];
        copy.bmonth = [self.bmonth copyWithZone:zone];
        copy.nikename = [self.nikename copyWithZone:zone];
        copy.userPwd = [self.userPwd copyWithZone:zone];
        copy.rongyunToken = [self.rongyunToken copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.referer = [self.referer copyWithZone:zone];
        copy.kaixinId = [self.kaixinId copyWithZone:zone];
        copy.isDaren = [self.isDaren copyWithZone:zone];
        copy.isSynTencent = [self.isSynTencent copyWithZone:zone];
        copy.myAddress = [self.myAddress copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.sinaToken = [self.sinaToken copyWithZone:zone];
        copy.myIntro = [self.myIntro copyWithZone:zone];
        copy.bday = [self.bday copyWithZone:zone];
        copy.dpCount = [self.dpCount copyWithZone:zone];
        copy.isDelete = [self.isDelete copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
        copy.favedCount = [self.favedCount copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
        copy.tAccessToken = [self.tAccessToken copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.isEffect = [self.isEffect copyWithZone:zone];
        copy.lotteryMobile = [self.lotteryMobile copyWithZone:zone];
        copy.profession = [self.profession copyWithZone:zone];
        copy.loginIp = [self.loginIp copyWithZone:zone];
        copy.step = [self.step copyWithZone:zone];
        copy.focusedCount = [self.focusedCount copyWithZone:zone];
        copy.passwordVerify = [self.passwordVerify copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
        copy.verify = [self.verify copyWithZone:zone];
        copy.isMerchant = [self.isMerchant copyWithZone:zone];
        copy.point = [self.point copyWithZone:zone];
        copy.xpoint = [self.xpoint copyWithZone:zone];
        copy.isPhoto = [self.isPhoto copyWithZone:zone];
        copy.sohuId = [self.sohuId copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.loginPayTime = [self.loginPayTime copyWithZone:zone];
        copy.levelId = [self.levelId copyWithZone:zone];
        copy.topicCount = [self.topicCount copyWithZone:zone];
        copy.provinceId = [self.provinceId copyWithZone:zone];
    }
    
    return copy;
}


@end
