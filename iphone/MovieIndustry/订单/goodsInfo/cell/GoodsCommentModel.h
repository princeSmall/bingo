//
//  GoodsCommentModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface GoodsCommentModel : NSObject
//评论内容
@property (nonatomic,copy) NSString *content;
//创建时间
@property (nonatomic,copy) NSString *create_at;
//icon_img
@property (nonatomic,copy) NSString *img;
//用户名
@property (nonatomic,copy) NSString *name;
//工作
@property (nonatomic,strong)NSString * job;

@property (nonatomic,strong)NSString * pics;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
