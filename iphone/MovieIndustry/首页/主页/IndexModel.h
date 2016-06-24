//
//  IndexModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexModel : NSObject
//标题
@property (nonatomic,copy) NSString *title;
//图片
@property (nonatomic,copy) NSString *image;
//详情简介
@property (nonatomic,copy) NSString *brief;
//评论数
@property (nonatomic,copy) NSString *comment_number;
//文章ID
@property (nonatomic,copy) NSString *articleID;

@end
