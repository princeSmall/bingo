//
//  DiscoverBBSController.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
typedef enum {
    BBSMsgTypeFromFriend, // 朋友消息
    BBSMsgTypeFromSystem // 系统消息
} BBSMsgType;
@interface DiscoverBBSController : BaseViewController
@property (nonatomic, assign) BBSMsgType msgType;

@end
