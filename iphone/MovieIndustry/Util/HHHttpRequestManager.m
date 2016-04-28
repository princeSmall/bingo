//
//  HHHttpRequestManager.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/30.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHHttpRequestManager.h"

@implementation HHHttpRequestManager

/*
 评价订单
 */
+ (void)requestShopMessageAdd:(NSMutableDictionary *)parameter scallBack:(HHCallback)scallBack
{
    [HttpRequestServers requestBaseUrl:Shop_message_add withParams:parameter withRequestFinishBlock:^(id result) {
        
        
        
        
        
    } withFieldBlock:^{
        
        
    }];
    
}

@end
