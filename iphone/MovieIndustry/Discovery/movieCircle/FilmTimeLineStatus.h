//
//  FilmTimeLineStatus.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//  电影圈消息的内容


#import <Foundation/Foundation.h>
@class FilmTimeLineUser;
@interface FilmTimeLineStatus : NSObject
#warning 字段名后面会根据服务器内容做更改

/**电影圈作者的用户信息*/
@property (nonatomic, strong) FilmTimeLineUser *user;
/**电影圈信息内容*/
@property (nonatomic, copy) NSString *text;
/**电影圈创建时间*/
@property (nonatomic, copy) NSString *created_at;
/**配图数组*/
@property (nonatomic, strong) NSArray *pic_urls;
/**转发数*/
@property (nonatomic, assign) int reposts_count;
/**评论数*/
@property (nonatomic, assign) int comments_count;
/**点赞数*/
@property (nonatomic, assign) int attitudes_count;
/**转发的链接*/

@end
