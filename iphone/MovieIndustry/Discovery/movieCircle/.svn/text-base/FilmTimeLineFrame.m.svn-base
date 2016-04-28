//
//  FilmTimeLineFrame.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "FilmTimeLineFrame.h"
#import "FilmTimeLineUser.h"
#import "FilmTimeLineStatus.h"
// 各控件上下之间的间距
#define DUMargin 10
// 各控件左右之间的间距
#define LRMargin 16
// 各控件距cell的间距
#define pading 8
@implementation FilmTimeLineFrame
- (void)setStatus:(FilmTimeLineStatus *)status {
    _status = status;
    FilmTimeLineUser *user = status.user;
  
    /**头像*/
    CGFloat iconWH = 40;
    CGFloat iconX = pading;
    CGFloat iconY = 15;
    self.iconImageViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconImageViewFrame) + LRMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:FilmTimeLineNameFont];
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    /**分割线*/
    CGFloat splitX = CGRectGetMaxX(self.nameLabelFrame) + LRMargin / 2;
    CGFloat splitY = iconY - 2;
    self.splitViewFrame = CGRectMake(splitX , splitY, 1, nameSize.height - 2);
    
    /**摄影师级别*/
    CGFloat photographerX = CGRectGetMaxX(self.splitViewFrame) + LRMargin / 2;
    CGFloat photographerY = iconY;
    CGSize photographerSize = [user.photographer_level sizeWithFont:FilmTimeLinePhotographerLevelFont];
    self.photographerLabelFrame = CGRectMake(photographerX, photographerY, photographerSize.width, photographerSize.height);
    
    /**内容*/
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.nameLabelFrame) + DUMargin;
    CGSize contentSize = [status.text sizeWithFont:FilmTimeLineContentFont];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    /**配图*/
    
    
}
@end
