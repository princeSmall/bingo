//
//  HttpRequestServers.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpRequestServersFinishBlock) (id result);
typedef void (^HttpRequestServersFieldBlock) (void);

@interface HttpRequestServers : NSObject

////get请求接口
+ (void)requestGETBaseUrl:(NSString *) url withParams:(NSMutableDictionary *) params withRequestFinishBlock:(HttpRequestServersFinishBlock) finishBlock withFieldBlock:(HttpRequestServersFieldBlock)fieldBlock;

///post请求接口
+ (void)requestBaseUrl:(NSString *) url withParams:(NSMutableDictionary *) params withRequestFinishBlock:(HttpRequestServersFinishBlock) finishBlock withFieldBlock:(HttpRequestServersFieldBlock) fieldBlock;

///上传图片接口
+ (AFHTTPRequestOperationManager *)postImageRequest:(NSString *)URLString
                                            UIImage:(UIImage*)image
                                         parameters:(NSDictionary *)parameters
                                      requestFinish:(HttpRequestServersFinishBlock) finishBlock
                                       requestField:(HttpRequestServersFieldBlock) fieldBlock;

#pragma mark - 支付宝支付
/**
 *支付宝支付 所有参数必填 Callback是返回的参数
 **/
+ (void)sendAlipayWithOrderSn:(NSString *)orderSn orderName:(NSString *)orderName orderDescription:(NSString *)orderDescription orderPrice:(NSString *)OrderPrice andScallback:(Callback)scallback;

@end
