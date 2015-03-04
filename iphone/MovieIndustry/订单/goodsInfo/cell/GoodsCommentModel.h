//
//  GoodsCommentModel.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCommentModel : NSObject
//评论内容
@property (nonatomic,copy) NSString *content;
//创建时间
@property (nonatomic,copy) NSString *create_time;
//icon_img
@property (nonatomic,copy) NSString *icon_img;
//用户名
@property (nonatomic,copy) NSString *user_name;
@end
