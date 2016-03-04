//
//  FilmTimeLineFrame.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  FilmTimeLineStatus;
@interface FilmTimeLineFrame : NSObject

/**昵称字体*/
#define FilmTimeLineNameFont [UIFont systemFontOfSize:14]
/**时间字体*/
#define FilmTimeLineTimeFont [UIFont systemFontOfSize:12]
/**微博正文字体*/
#define FilmTimeLineContentFont [UIFont systemFontOfSize:15]
/**转发的正文字体*/
#define FilmTimeLineRetWeetContentFont [UIFont systemFontOfSize:12]
/**摄影师级别字体*/
#define FilmTimeLinePhotographerLevelFont [UIFont systemFontOfSize:10]

@property (nonatomic, strong) FilmTimeLineStatus *status;
/**原创电影圈整体*/
@property (nonatomic,assign) CGRect  originalViewFrame;
/**头像*/
@property (nonatomic, assign) CGRect iconImageViewFrame;
/**昵称*/
@property (nonatomic, assign) CGRect nameLabelFrame;
/**时间*/
@property (nonatomic, assign) CGRect timeLabelFrame;
/**内容*/
@property (nonatomic, assign) CGRect contentLabelFrame;
/**摄影师级别*/
@property (nonatomic, assign) CGRect photographerLabelFrame;
/**分割线*/
@property (nonatomic, assign) CGRect splitViewFrame;

/**cell的高度*/
@property (nonatomic, assign) CGFloat cellH;


/**转发电影圈整体*/
@property (nonatomic,assign) CGRect retweetViewFrame;
/**转发内容*/
@property (nonatomic, assign) CGRect retweetcontentLabelFrame;
/**转发配图*/
@property (nonatomic, assign) CGRect retweetphotoImageViewFrame;

/**toolBar*/
@property (nonatomic,assign) CGRect toolBarFrame;
@end
