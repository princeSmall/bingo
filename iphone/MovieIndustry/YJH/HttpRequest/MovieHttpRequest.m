//
//  MovieHttpRequest.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/24.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieHttpRequest.h"
#import "MovieMineInfoModel.h"
#import "MovieLightRentSimpleModel.h"
#import "MovieStoreSetingViewModel.h"
#import "MovieMineStoreInfoModel.h"
#import "MovieMineIssueNeedsModel.h"
#import "MovieMineReceiveNeedsModel.h"
#import "MovieMineCollectGoodsModel.h"
#import "MovieCollectStoreModel.h"
#import "MovieManagerGoodsModel.h"
#import "MovieReportReasonModel.h"
#import "MovieDiscoveryArticleModel.h"
#import "MovieArticleDetailModel.h"
#import "ModelArticleCommentModel.h"
#import "MovieDeliveryMethodModel.h"
#import "MovieOccupationModel.h"
#import "MovieTuesdayGoodModel.h"
#import "MovieTuesdayRushHistoryModel.h"
#import "MovieMineNeedsRushedModel.h"
#import "MovieRelatedArticleModel.h"
#import "MovieSpecialShowModel.h"
#import "MovieHelperListModel.h"
#import "MovieOrderDeliveyMainModel.h"
#import "MovieTuesdayCommentModel.h"
#import "MovieMinePointRecordModel.h"
#import "MovieIncomeDetailModel.h"
#import "MovieTradeRecordModel.h"
#import "CollectGoodsModel.h"
#import "ConllectShopModel.h"
#import "ShopMainModel.h"


static NSString *RIGHT_STATUE = @"f99";
static const NSString *STATUE = @"status";
static const NSString *MESSAGE = @"msg";

@implementation MovieHttpRequest

+ (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - 我的用户信息
+ (void)createMineInfoRequestCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSLog(@"我的用户Id --> %@",[UserInfo uid]);
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
    }
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我的用户信息错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Gain_user_info withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我的用户信息 --> %@\n%@,%@",Gain_user_info,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSDictionary *subDict = dict[@"info"];
                MovieMineInfoModel *model = [MovieMineInfoModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            scallback(Network_Error);
            NSLog(@"我的用户信息错误2 --> %@",exception);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        scallback(Network_Error);
        NSLog(@"我的用户信息错误3");
    }];
}



#pragma mark - 修改我的用户信息
/**
 *      user_id      用户id
 *      icon_img     头像地址
 *      nikename     昵称
 *      sex          性别(-1未知;0女;1,男)
 *      my_address   我的地址
 *      profession   职业身份
 *      come_from    来自
 */
+ (void)createModifyMineInfoWithInfoDict:(NSDictionary *)infoDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:infoDict[@"icon_img"] forKey:@"icon_img"];
        [parameters setValue:infoDict[@"nikename"] forKey:@"nikename"];
        [parameters setValue:infoDict[@"sex"] forKey:@"sex"];
        [parameters setValue:infoDict[@"my_address"] forKey:@"my_address"];
        [parameters setValue:infoDict[@"profession"] forKey:@"profession"];
        [parameters setValue:infoDict[@"come_from"] forKey:@"come_from"];
    }
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"修改用户信息错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Edit_user_info withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"修改用户信息 --> %@\n%@,%@",Edit_user_info,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"修改用户信息错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        NSLog(@"修改用户信息错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 开通我的店铺
/**
 *      name店铺名
 *      user_id       用户id
 *      brief店铺介绍
 *      address店铺详细地址
 *      city_id城市地址
 *      tel电话
 *      contact联系人
 *      店铺分类(is_shop发布商品:1是0否 is_space发布场地1是0否 is_staff发布人员1是0否)
 */
+ (void)createOpenMineStoreWithInfo:(NSDictionary *)storeDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:storeDict];
    [HttpRequestServers requestBaseUrl:TIShop_ApplyShop withParams:params withRequestFinishBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        @try {
           
            if ([dict[@"code"] intValue] == 0) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"发布产品错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        NSLog(@"发布产品错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 我的店铺(收入/余额)
+ (void)createMineStoreInfomationCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
//        [parameters setValue:@"1" forKey:@"shop_id"];
      
    }
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我的店铺(收入/余额)错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIShop_ShopDetail withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我的店铺(收入/余额) --> %@\n%@,%@",TIShop_ShopDetail,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
         
            if ([dict[@"code"] intValue] == 0) {
                
                NSArray * array = dict[@"data"];
                
                NSDictionary *subDict = [array lastObject];
                ShopMainModel *model = [[ShopMainModel alloc]initWithDict:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"我的店铺(收入/余额)错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        NSLog(@"我的店铺(收入/余额)错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 闪电租(价格列表,分类列表)
+ (void)createLightingRentViewDatasCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    [HttpRequestServers requestBaseUrl:Rent_before withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"获取闪电租数据(价格,类型) --> %@\n%@",Rent_before,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSMutableDictionary *backDict = [NSMutableDictionary new];
                NSMutableArray *priceArray = [NSMutableArray new];
                NSMutableArray *typeArray = [NSMutableArray new];
                
                NSArray *priceArr = dict[@"price_list"];
                NSArray *typeArr = dict[@"cate_list"];
                
                for (NSDictionary *subDict in priceArr)
                {
                    MovieLightRentSimpleModel *model = [MovieLightRentSimpleModel modelObjectWithDictionary:subDict];
                    [priceArray addObject:model];
                }
                
                for (NSDictionary *subDict in typeArr) {
                    MovieLightRentSimpleModel *model = [MovieLightRentSimpleModel modelObjectWithDictionary:subDict];
                    [typeArray addObject:model];
                }
                
                [backDict setObject:priceArray forKey:@"price"];
                [backDict setObject:typeArray forKey:@"catalogue"];
                callback(backDict);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"获取闪电租数据(价格,类型)错误1 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"获取闪电租数据(价格,类型)错误2");
        scallback(Network_Error);
    }];
}



#pragma mark - 发布闪电租需求
/**
 *  发布闪电租需求
 *  user_id         用户id
 *  keyword         关键词
 *  city_id         城市id
 *  cate_id         类型id
 *  price_id        价格id
 *  time_str        时间字符串
 *  remark          备注
 */
+ (void)createMakeMineLightingRentWithRequestInfo:(NSDictionary *)requestDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
 
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:requestDict[@"keyword"] forKey:@"keyword"];
        [parameters setValue:requestDict[@"city_id"] forKey:@"city_name"];
        [parameters setValue:requestDict[@"cate_id"] forKey:@"cate_id"];
        [parameters setValue:requestDict[@"price_id"] forKey:@"price_id"];
        [parameters setValue:requestDict[@"time_str"] forKey:@"time_str"];
        [parameters setValue:requestDict[@"remark"] forKey:@"remark"];
    }
   
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"发布闪电租需求错误1%@ --> %@",Add_rent	,exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TILightingRent_Send withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发布闪电租需求 --> %@\n%@,%@",parameters,Add_rent,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发布闪电租需求错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布闪电租需求错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 店铺设置显示
+ (void)createSetingStoreViewDataCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    [HttpRequestServers requestBaseUrl:TIShop_ShopDetail withParams:dict withRequestFinishBlock:^(id result) {

        NSDictionary *dict = (NSDictionary *)result;
        @try {
     
            if ([dict[@"code"]intValue]== 0) {
                
                NSArray * array = dict[@"data"];
                ShopMainModel *model = [[ShopMainModel alloc]initWithDict:[array lastObject]];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"店铺设置显示错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"店铺设置显示错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 提交店铺设置
/*
 *  确认并提交店铺设置
 *   user_id用户id brief店铺介绍 address店铺地址 tel电话 contact联系人 is_type是否认证:1是0否 图像修改见 开通店铺_店铺logo接口  xpoint经度 ypoint纬度
 */
+ (void)createSettingMineStoreInfomation:(NSDictionary *)storeDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
   
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:storeDict];
    
    
    [HttpRequestServers requestBaseUrl:TIShop_SetShop withParams:parameters withRequestFinishBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            
            if ([dict[@"code"] intValue] == 0) {
                
                NSDictionary *subDict = dict[@"info"];
                MovieStoreSetingViewModel *model = [MovieStoreSetingViewModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"提交店铺设置错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"提交店铺设置错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 发布人员,职称列表
+ (void)createOccupationListCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    [HttpRequestServers requestBaseUrl:Shop_post_list withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发布人员,职称列表 --> %@,%@",Shop_post_list,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSMutableArray *backArray = [NSMutableArray new];
                NSArray *array = dict[@"list"];
                for (NSDictionary *subDict in array) {
                    
                    MovieOccupationModel *model = [MovieOccupationModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发布人员,职称列表错误1 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布人员,职称列表错误2");
        scallback(Network_Error);
    }];
}


#pragma mark - 发布人员接口
+ (void)createPublishMinePersonnelWith:(NSDictionary *)personDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:personDict];
    [HttpRequestServers requestBaseUrl:TIPublish_People withParams:parameters withRequestFinishBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        
        if ([dict[@"code"] intValue] == 0) {
             scallback(@"success");
        }
    } withFieldBlock:^{
        scallback(Network_Error);
    }];
}


#pragma mark - 发布场地接口
+ (void)createPublishMineSiteWith:(NSDictionary *)siteDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:siteDict];
    
    [HttpRequestServers requestBaseUrl:TIPublish_Place withParams:parameters withRequestFinishBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        @try {

            if ([dict[@"code"] intValue] == 0) {
                NSDictionary *subDict = dict[@"info"];
                MovieStoreSetingViewModel *model = [MovieStoreSetingViewModel modelObjectWithDictionary:subDict];
                callback(model);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发布场地接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布场地接口错误3");
        scallback(Network_Error);
    }];
}

#pragma mark -  发布产品
/**
 *      user_id       用户id
 *      deal_id       添加图片返回的id(没有为空)
 *      name          商品名称
 *      origin_price  价格
 *      current_price 咔么价
 *      city_id       城市id
 *      delivery_id   送货id(1商家2顺丰3申通)
 *      is_deposit    是否押金
 *      description描述
 */
+ (void)createPublishMineProductWithGoodsInfo:(NSDictionary *)goodsDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:goodsDict[@"deal_id"] forKey:@"deal_id"];
        [parameters setValue:goodsDict[@"name"] forKey:@"name"];
        [parameters setValue:goodsDict[@"origin_price"] forKey:@"origin_price"];
        [parameters setValue:goodsDict[@"current_price"] forKey:@"current_price"];
        [parameters setValue:goodsDict[@"city_id"] forKey:@"city_id"];
        [parameters setValue:goodsDict[@"delivery_id"] forKey:@"delivery_id"];
        [parameters setValue:goodsDict[@"is_deposit"] forKey:@"is_deposit"];
        [parameters setValue:goodsDict[@"description"] forKey:@"description"];
        [parameters setValue:goodsDict[@"img"] forKey:@"img"];
        [parameters setValue:@"10" forKey:@"num"];
    }
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"发布产品错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Shop_deal_add withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发布产品 --> %@\n%@,%@",Shop_deal_add,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"发布产品错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        NSLog(@"发布产品错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 发布的需求列表数据
+ (void)createMineRequestListWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"发布的需求列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Issue_list withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发布的需求列表 --> %@\n%@,%@",Issue_list,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    MovieMineIssueNeedsModel *model = [MovieMineIssueNeedsModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                if (backArray.count) {
                    callback(backArray);
                }
                else
                {
                    if (page == 1) {
                        scallback(@"您还未发布任何需求");
                    }
                    else
                        scallback(@"没有更多发布的需求啦~");
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发布的需求列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布的需求列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 发布的需求,抢单列表
+ (void)createMineNeedsRushedListWithPage:(int)page andRentId:(NSString *)rentId CallBack:(Callback)callback andSCallBack:(Callback)scallback;
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:rentId forKey:@"rent_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"发布的需求,抢单列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Issue_list_in withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发布的需求,抢单列表 --> %@\n%@,%@",Issue_list_in,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    MovieMineNeedsRushedModel *model = [MovieMineNeedsRushedModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                if (backArray.count) {
                    callback(backArray);
                }
                else
                {
                    if (page == 1) {
                        scallback(@"暂无抢单信息");
                    }
                    else
                        scallback(@"没有更多抢单信息啦~");
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发布的需求,抢单列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布的需求,抢单列表错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 收到的需求立即抢单
+ (void)createRushMineRecivedNeedsWith:(NSString *)requestId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:requestId forKey:@"rent_msg_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"收到的需求立即抢单错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Edit_rent withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"收到的需求立即抢单 --> %@\n%@,%@",Edit_rent,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"收到的需求立即抢单错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"收到的需求立即抢单错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 收到的需求列表数据
+ (void)createMineReceivedNeedsWithLocationId:(NSString *)locationId andPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:locationId forKey:@"location_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"收到的需求列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Receive_list withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"收到的需求列表 --> %@\n%@,%@",Receive_list,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    MovieMineReceiveNeedsModel *model = [MovieMineReceiveNeedsModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                if (backArray.count) {
                    callback(backArray);
                }
                else
                {
                    if (page == 1) {
                        scallback(@"您还未收到的需求信息");
                    }
                    else
                        scallback(@"没有更多收到的需求信息啦~");
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"收到的需求错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布的需求列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 点击收藏商品
+ (void)createCollectMyFavourableGoodWithGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [parameters setValue:goodId forKey:@"thing_id"];
         //收藏的类型 0 商品 1店铺
        [parameters setValue:@"0" forKey:@"collect_type"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"点击收藏商品错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIAdd_Collection withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"点击收藏商品 --> %@\n%@,%@",TIAdd_Collection,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            
            if ([dict[@"code"] intValue] ==0) {
            
                id data = dict[@"data"];
                if([[data superclass]isSubclassOfClass:[NSString class]])
                {
                    if([dict[@"data"] isEqualToString:@"此商品已收藏"])
                    {
                        scallback([self objectOrNilForKey:@"data" fromDictionary:dict]);
                    }
                }
                else
                {
                    if([dict[@"data"] intValue]==1)
                    {
                        callback(RequestSuccess);
                        
                    }

                    
                }
            }
            else
            {
                scallback([self objectOrNilForKey:@"message" fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"点击收藏商品错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"点击收藏商品错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 我收藏的商品列表数据
+ (void)createMineCollectGoodsWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [parameters setValue:pageStr forKey:@"page"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我收藏的商品列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIAdd_CollectionGoodsList withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我收藏的商品列表 --> %@\n%@,%@",TIAdd_CollectionGoodsList,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            
           
            if ([dict[@"code"] intValue]==0) {
                
                id array = dict[@"data"];
                if(![array isKindOfClass:[NSArray class]])
                {
                    callback(nil);
                }
                else
                {
                
                    NSMutableArray *backArray = [NSMutableArray new];
                    for (NSDictionary *subDict in array) {
                        CollectGoodsModel *model = [[CollectGoodsModel alloc]initWithDict:subDict];
                        [backArray addObject:model];
                    }
                    callback(backArray);
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            HHNSLog(@"我收藏的商品列表 --> %@\n",TIAdd_CollectionGoodsList);
            HHNSLog(@"我收藏的商品列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发布的需求列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 点击收藏的店铺
+ (void)createCollectMyFavourableStoreWithStoreId:(NSString *)StoreId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [parameters setValue:StoreId forKey:@"thing_id"];
        //收藏的类型 0 商品 1店铺
        [parameters setValue:@"1" forKey:@"collect_type"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"点击收藏店铺错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIAdd_Collection withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"点击收藏店铺 --> %@\n%@,%@",TIAdd_Collection,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            
            if ([dict[@"code"] intValue] ==0) {
                
                id data = dict[@"data"];
                if([[data superclass]isSubclassOfClass:[NSString class]])
                {
                    if([dict[@"data"] isEqualToString:@"此商品已收藏"])
                    {
                        scallback([self objectOrNilForKey:@"data" fromDictionary:dict]);
                    }
                }
                else
                {
                    if([dict[@"data"] intValue]==1)
                    {
                        callback(RequestSuccess);
                        
                    }
                    
                    
                }
            }
            else
            {
                scallback([self objectOrNilForKey:@"message" fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"点击收藏店铺错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"点击收藏店铺错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 我收藏的店铺列表数据
+ (void)createMineCollectStoreWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [parameters setValue:pageStr forKey:@"page"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我收藏的店铺列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIAdd_CollectionShopList withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我收藏的店铺列表 --> %@\n%@,%@",TIAdd_CollectionShopList,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
           
            if ([dict[@"code"]intValue]==0)
            {
                
                
                NSArray *array = dict[@"data"];
                if(![array isKindOfClass:[NSArray class]])
                {
                    callback(nil);
                }
                else
                {

                    NSMutableArray *backArray = [NSMutableArray new];
                    for (NSDictionary *subDict in array) {
                    
                        ConllectShopModel *model = [[ConllectShopModel alloc]initWithDict:subDict];
                        [backArray addObject:model];
                    }
                    callback(backArray);
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"我收藏的店铺列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"我收藏的店铺列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 商品管理列表数据
/*
 *  page        加载第几页数据
 *  type        is_rent  0:全部 1:已出租
 *  keyword     key      关键字
 */
+ (void)createManagerMyGoodsListWithPage:(int)page andType:(NSString *)type andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    //NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        //[parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:@"6" forKey:@"user_id"];
        
    }
    //测试商品测试商品测试商品测试商品测试商品测试商品测试商品
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"商品管理列表数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    if([type isEqualToString:@"0"])
    {
        [HttpRequestServers requestBaseUrl:TIShopGoods_GoodsList withParams:parameters withRequestFinishBlock:^(id result) {
        
            HHNSLog(@"商品管理列表数据 --> %@\n%@,%@",TIShopGoods_GoodsList,parameters,result);
            NSDictionary *dict = result;
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            NSLog(@"%@",code);
            if([code isEqualToString:@"0"])
            {
                NSArray *arr = dict[@"data"];
                 callback(arr);
            }
            else
            {
                scallback([self objectOrNilForKey:@"message" fromDictionary:dict]);
            }
        
        } withFieldBlock:^{
        
            HHNSLog(@"商品管理列表数据错误3");
            scallback(Network_Error);
        }];
    }
    if([type isEqualToString:@"1"])
    {
        

        [HttpRequestServers requestBaseUrl:TIShopGoods_BorrowGoods withParams: parameters withRequestFinishBlock:^(id result) {
            HHNSLog(@"商品管理列表数据 --> %@\n%@,%@",TIShopGoods_GoodsList,parameters,result);
            NSDictionary *dict = result;
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            NSLog(@"%@",code);
            if([code isEqualToString:@"0"])
            {
                NSArray *arr = dict[@"data"];
                callback(arr);
            }
            else
            {
                scallback([self objectOrNilForKey:@"message" fromDictionary:dict]);
            }

        } withFieldBlock:^{
            
        }];
    }
}

#pragma mark - 举报内容列表接口
+ (void)createGetReportReasonsCallBack:(Callback)callback andSCallBack:(Callback)scallback;
{
    [HttpRequestServers requestBaseUrl:Report_list withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"举报内容列表数据 --> %@\n,%@",Report_list,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    MovieReportReasonModel *model = [MovieReportReasonModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"举报内容列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"举报内容列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 确认举报接口
+ (void)createComfirmSendReportWithReportedId:(NSString *)reportedId andContent:(NSString *)content CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:reportedId forKey:@"user_to_id"];
        [parameters setValue:content forKey:@"content"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"确认举报接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Report_add withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"确认举报接口 --> %@\n%@,%@",Report_add,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"确认举报接口2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"确认举报接口错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 交易记录接口
+ (void)createTradeRecordListWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"交易记录接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Trade_Record withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"交易记录接口数据 --> %@\n%@,%@",Trade_Record,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    MovieTradeRecordModel *model = [MovieTradeRecordModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"交易记录接口数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"商品管理列表数据错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 发现页面展览文章数据
+ (void)createDiscoverViewDisplayArticleCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];

    [HttpRequestServers requestBaseUrl:Exhibition_article_list withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发现页面展览文章数据 --> %@\n%@,%@",Exhibition_article_list,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    
                    MovieDiscoveryArticleModel *model = [MovieDiscoveryArticleModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发现页面展览文章数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发现页面展览文章数据错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 发现页面文章列表数据
+ (void)createDiscoverArticleListWithPage:(int)page andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:keyword forKey:@"key"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"发现页面文章列表数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Discover_article_list withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"发现页面文章列表数据 --> %@\n%@,%@",Discover_article_list,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    
                    MovieDiscoveryArticleModel *model = [MovieDiscoveryArticleModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
               
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"发现页面文章列表数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"发现页面文章列表数据错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 相关文章
+ (void)createRelatedArticlesWithArtile:(NSString *)articleId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:articleId forKey:@"article_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"相关文章数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:ArtileDetail_relateA withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"相关文章数据 --> %@\n%@,%@",ArtileDetail_relateA,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSMutableArray *backArray = [NSMutableArray new];
                NSArray *array = dict[@"list"];
                for (NSDictionary *subDict in array) {
                    MovieRelatedArticleModel *model = [MovieRelatedArticleModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"相关文章数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"相关文章数据错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 文章详情
+ (void)createArticleDetailWithArticleId:(NSString *)articleId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];

    
    @try {
        [parameters setValue:articleId forKey:@"article_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"文章详情数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Article_info withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"文章详情数据 --> %@\n%@,%@",Article_info,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSDictionary *subDict = dict[@"info"];
                MovieArticleDetailModel *model = [MovieArticleDetailModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"文章详情数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"文章详情数据错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 文章评论列表
+ (void)createArticleCommentListWithArticleId:(NSString *)articleId andPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:articleId forKey:@"article_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"文章评论列表数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Comment_list withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"文章评论列表列表数据 --> %@\n%@,%@",Comment_list,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    
                    ModelArticleCommentModel *model = [ModelArticleCommentModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
//                if (backArray.count) {
                    callback(backArray);
//                }
//                else
//                {
//                    if (1 == page) {
//                        scallback(@"暂无评论噢~");
//                    }
//                    else
//                        scallback(@"没有更多的评论了噢~");
//                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"文章评论列表数据错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"文章评论列表数据错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 添加对文章的评论接口
/**
 * 添加文章评论接口
 * 需要post(article_id文章id,user_id用户id,content评论内容);
 * 返回 (返回f1失败,f99成功,msg是提示信息;)
 */
+ (void)createAddArticleCommentWithInfoDict:(NSDictionary *)commentDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];//用户id
        [parameters setValue:[commentDict objectForKey:@"articleId"] forKey:@"article_id"];//文章id
        [parameters setValue:[commentDict objectForKey:@"content"] forKey:@"content"];//评论内容
        [parameters setValue:[commentDict objectForKey:@"img"] forKey:@"img"];//评论图片
        [parameters setValue:[commentDict objectForKey:@"contentId"] forKey:@"content_id"];//文章评论的id
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"添加文章评论接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Add_article_comment withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"添加文章评论接口数据 --> %@\n%@,%@",Add_article_comment,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"添加文章评论接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"添加文章评论接口错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 对文章评论进行点赞接口
+ (void)createAddMineBlessWithCommentId:(NSString *)commentId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:commentId forKey:@"id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"对文章评论进行点赞错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:ArticleComment_Praise withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"对文章评论进行点赞数据 --> %@\n%@,%@",ArticleComment_Praise,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                NSDictionary *subDict = dict[@"list"];
                callback(subDict);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"对文章评论进行点赞错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"对文章评论进行点赞错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 送货方式
+ (void)createRequestDeliveyWayCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    [HttpRequestServers requestBaseUrl:Shipping_Method_Url withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"送货方式数据 --> %@,%@",Shipping_Method_Url,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try { 
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                NSMutableArray *backArray = [NSMutableArray new];
                NSArray *array = dict[@"list"];
                for (NSDictionary *subDict in array) {
                    
                    MovieDeliveryMethodModel *model = [MovieDeliveryMethodModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"送货方式数据错误1 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"送货方式数据错误2");
        scallback(Network_Error);
    }];
}


#pragma mark - 周二抢页面接口
+ (void)createTuesdayGoodSellActivityCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"周二抢页面接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Shop_panic_deal withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"周二抢页面接口 --> %@\n%@,%@",parameters,Shop_panic_deal,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                NSDictionary *subDict = dict[@"list"];
                MovieTuesdayGoodModel *model = [MovieTuesdayGoodModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"周二抢页面接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"周二抢页面接口错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 周二抢历史抢购记录
+ (void)createTuesdayActivityHistoryListWithGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        
        [parameters setValue:@"39" forKey:@"tebie"];
        [parameters setValue:goodId forKey:@"deal_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"周二抢历史抢购记录错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TuesdayAc_HistoryList withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"周二抢历史抢购记录 --> %@\n%@,%@",TuesdayAc_HistoryList,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                NSMutableArray *backArray = [NSMutableArray new];
                id dictlist = dict[@"list"];
                if (![dictlist isEqual:[NSNull null]]) {
                    NSArray *array = dict[@"list"];
                    for (NSDictionary *subDict in array) {
                        MovieTuesdayRushHistoryModel *model = [MovieTuesdayRushHistoryModel modelObjectWithDictionary:subDict];
                        [backArray addObject:model];
                    }
                    callback(backArray);
                }
                
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"周二抢历史抢购记录错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"周二抢历史抢购记录错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 专场商品数据
+ (void)createSpecialGoodsShowCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    [HttpRequestServers requestBaseUrl:Shop_special_deal withParams:nil withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"专场商品数据 --> %@\n%@",Shop_special_deal,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                NSDictionary *subDict = dict[@"list"];
                MovieSpecialShowModel *model = [MovieSpecialShowModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"专场商品数据错误1 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"专场商品数据错误2");
        scallback(Network_Error);
    }];
}


#pragma mark - 帮助页面列表
+ (void)createHelpNormalQuestionlistWithPage:(int)page andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        [parameters setValue:keyword forKey:@"keyword"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"帮助页面列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Search_help withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"帮助页面列表数据 --> %@\n%@,%@",Search_help,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    
                    MovieHelperListModel *model = [MovieHelperListModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                
                if (backArray.count)
                {
                    callback(backArray);
                }
                else
                {
                    if (1 == page)
                    {
                        scallback(@"暂无相关帮助问题");
                    }
                    else
                        scallback(@"没有更多相关帮助问题了噢~");
                }
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"帮助页面列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"帮助页面列表错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 查看物流数据
+ (void)createCheckDeliveyDetailWithOrderId:(NSString *)orderId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:orderId forKey:@"order_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"查看物流数据错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:checkDelivey_Detail withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"查看物流信息数据 --> %@\n%@,%@",checkDelivey_Detail,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSDictionary *subDict = dict[@"list"];
                MovieOrderDeliveyMainModel *model = [MovieOrderDeliveyMainModel modelObjectWithDictionary:subDict];
                callback(model);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"查看物流信息错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"查看物流信息错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 确认收货
+ (void)createComfirmReceiveMineOrderWithOrderNum:(NSString *)ordernum CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:ordernum forKey:@"order_sn"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"确认收货错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Shop_order_confirm withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"确认收货数据 --> %@\n%@,%@",Shop_order_confirm,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"确认收货错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"确认收货错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 取消订单
+ (void)createConfirmCancelMineOrderWithOrdernum:(NSString *)ordernum CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:ordernum forKey:@"order_id"];
        [parameters setValue:@"0" forKey:@"status"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"取消订单错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"取消订单数据 --> %@\n%@,%@",TIOrder_ConfirmOrder,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"取消订单错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"取消订单错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 删除订单
+ (void)createDelecteMineOrderWithOrderId:(NSString *)orderId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:orderId forKey:@"order_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"删除订单错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:Delete_Order_Url withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"删除订单数据 --> %@\n%@,%@",Delete_Order_Url,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"删除订单错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"删除订单错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 周二抢评论接口
+ (void)createTuesdaySendCommentWithCommentDict:(NSDictionary *)commentDict CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];//用户id
        [parameters setValue:[commentDict objectForKey:@"deal_id"] forKey:@"deal_id"];//商品id
        [parameters setValue:[commentDict objectForKey:@"content"] forKey:@"content"];//评论内容
        [parameters setValue:[commentDict objectForKey:@"img"] forKey:@"img"];//评论图片
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"周二抢评论接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    HHNSLog(@"周二抢评论接口数据 --> %@\n%@",TuesdayActive_comment,parameters);
    
    [HttpRequestServers requestBaseUrl:TuesdayActive_comment withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"周二抢评论接口数据 --> %@\n%@,%@",TuesdayActive_comment,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                callback(RequestSuccess);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"周二抢评论接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"周二抢评论接口错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 周二抢评论列表接口
+ (void)createTuesdayCommentListDatasWithPage:(int)page andGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    
    @try {
        
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:goodId forKey:@"deal_id"];
        [parameters setValue:pageStr forKey:@"p"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"周二抢评论列表接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TuesdayCommentList withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"周二抢评论列表接口 --> %@\n%@,%@",TuesdayCommentList,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSArray *array = dict[@"list"];
                NSMutableArray *backArray = [NSMutableArray new];
                for (NSDictionary *subDict in array) {
                    
                    MovieTuesdayCommentModel *model = [MovieTuesdayCommentModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"周二抢评论列表接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"周二抢评论列表接口错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 周二抢评论点赞接口
+ (void)createActiveBlessWithCommentId:(NSString *)commentId CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:commentId forKey:@"content_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"周二抢评论点赞接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:ActiveComment_Praise withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"周二抢评论点赞接口数据 --> %@\n%@,%@",ActiveComment_Praise,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE])
            {
                callback(dict);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"周二抢评论点赞接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"周二抢评论点赞接口错误3");
        scallback(Network_Error);
    }];
}



#pragma mark - 商品管理确认归还接口 TIShopGoods_ConfirmBack
+ (void)createGoodManagerConfirmReturenWithTradeId:(NSString *)tradeId AndOrderID:(NSString *)order_id CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [parameters setObject:tradeId forKey:@"goods_id"];
        [parameters setObject:order_id forKey:@"order_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"商品管理确认归还接口错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:TIShopGoods_ConfirmBack withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"商品管理确认归还接口 --> %@\n%@,%@",TIShopGoods_ConfirmBack,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {

            NSString *code = [NSString stringWithFormat:@"%@",dict[@"code"]];
           

            if([code isEqualToString:@"0"])
            {
                callback(RequestSuccess);

            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"商品管理确认归还接口错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"商品管理确认归还接口错误3");
        scallback(Network_Error);
    }];
}

#pragma mark - 我的积分记录
+ (void)createMinePointRecordCallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我的积分记录错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:MinePoint_Record withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我的积分记录接口 --> %@\n%@,%@",MinePoint_Record,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSMutableArray *backArray = [NSMutableArray new];
                NSArray *array = dict[@"list"];
                for (NSDictionary *subDict in array) {
                    MovieMinePointRecordModel *model = [MovieMinePointRecordModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"我的积分记录错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
        HHNSLog(@"我的积分记录错误3");
        scallback(Network_Error);
    }];
}


#pragma mark - 我的收入明细列表
/**
 *  我的收入明细列表  MineIncome_Details
 *  timeStatue    tai  时间状态 1:昨天  2:本周  3:上月  4:全部
 *  incomeStatue  pan 1:收入  2:提现
 */
+ (void)createMineIncomeDetailWithTime:(NSString *)timeStatue andSegmentStatue:(NSString *)incomeStatue CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    @try {
        [parameters setValue:[UserInfo uid] forKey:@"user_id"];
        [parameters setValue:timeStatue forKey:@"tai"];
        [parameters setValue:incomeStatue forKey:@"pan"];
    }
    
    @catch (NSException *exception) {
        scallback(Network_Error);
        NSLog(@"我的收入明细列表错误1 --> %@",exception);
    }
    @finally {
        
    }
    
    [HttpRequestServers requestBaseUrl:MineIncome_Details withParams:parameters withRequestFinishBlock:^(id result) {
        
        HHNSLog(@"我的收入明细列表 --> %@\n%@,%@",MineIncome_Details,parameters,result);
        NSDictionary *dict = (NSDictionary *)result;
        @try {
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:RIGHT_STATUE]) {
                
                NSMutableArray *backArray = [NSMutableArray new];
                NSArray *array = dict[@"list"];
                for (NSDictionary *subDict in array)
                {
                    MovieIncomeDetailModel *model = [MovieIncomeDetailModel modelObjectWithDictionary:subDict];
                    [backArray addObject:model];
                }
                callback(backArray);
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        @catch (NSException *exception) {
            
            HHNSLog(@"我的收入明细列表错误2 --> %@",exception);
            scallback(Network_Error);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HHNSLog(@"我的收入明细列表错误3");
        scallback(Network_Error);
    }];
}













#pragma mark - 设置店铺logo
+ (void)httpUpdateImageWithImage:(UIImage *) image CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[UserInfo uid] forKey:@"user_id"];
    NSArray *photos = [[NSArray alloc] initWithObjects:image, nil];
    NSArray *files = [[NSArray alloc] initWithObjects:@"preview", nil];
    
    [MovieHttpRequest postImageRequest:Shop_preview UIImagePhotos:photos withfileInputs:files parameters:params CallBack:^(id obj) {
        
        NSError *error;
        NSDictionary *dict = (NSDictionary *)obj;
    
        if (error) {
            scallback(Network_Error);
        }
        else
        {
            NSLog(@"设置店铺图片 --> %@,%@,\n%@",photos,files,dict);
            
            NSString *statue = [self objectOrNilForKey:STATUE fromDictionary:dict];
            if ([statue isEqualToString:@"0000"]) {
                
                NSArray *array = dict[@"datas"];
                NSDictionary *subDict = [array firstObject];
                NSString *backName = subDict[@"image"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    callback(backName);
                });
            }
            else
            {
                scallback([self objectOrNilForKey:MESSAGE fromDictionary:dict]);
            }
        }
        
    } andSCallBack:^(id obj) {
        
        NSLog(@"SHANGCHUA 失败");
        
        if (scallback) {
            scallback(Network_Error);
        }
    }];
}


#pragma mark - 图片上传
+ (AFHTTPRequestOperationManager *)postImageRequest:(NSString *)URLString UIImagePhotos:(NSArray*)photos withfileInputs:(NSArray *) fileInputs
                                         parameters:(NSMutableDictionary *)parameters CallBack:(Callback)callback andSCallBack:(Callback)scallback
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *currentRequest = [AFHTTPRequestOperationManager manager];
        currentRequest.requestSerializer.timeoutInterval = 10.0f;
    
//    NSLog(@"图片上传全路径 --> %@,%@",URLString,parameters);
    
    [currentRequest POST:URLString
              parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    int i = 0;
    
    if (photos && photos.count > 0) {
        for (UIImage *image in photos) {
            UIImage *newimage = [MovieHttpRequest imageWithImageSimple:image scaledToSize:CGSizeMake(400, image.size.height*(400.0f/image.size.width))];
            NSDate *date = [[NSDate alloc] init];
            NSTimeInterval timeinterval = [date timeIntervalSince1970];
            NSString *imgname = [NSString stringWithFormat:@"%@%.0f%i.png",[fileInputs objectAtIndex:i],timeinterval,i];
            
            
            [formData appendPartWithFileData:UIImagePNGRepresentation(newimage)
                                        name:[fileInputs objectAtIndex:i]
                                    fileName:imgname
                                    mimeType:@"image/*"];
//            HHNSLog(@"fileFormData --> %@",imgname);
            i ++;
        }
    }
    
    
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在状态栏关闭有网络请求的提示器
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        callback(responseObject);
        
    });
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在状态栏关闭有网络请求的提示器
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"%@",error);
        
        scallback(Network_Error);
        
    });
}];
    
    return currentRequest;
}

/** 修改图片大小 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
