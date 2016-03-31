//
//  GoodCommitFrame.m
//  MovieIndustry
//
//  Created by aaa on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "GoodCommitFrame.h"

@implementation GoodCommitFrame

- (void)setModel:(GoodsCommentModel *)model{
    _model = model;
    //头像
    CGFloat iconX = 5;
    CGFloat iconY = 5;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconF = CGRectMake(iconX, iconY, iconW, iconH);
    //姓名
    CGFloat nameX = CGRectGetMaxX(self.iconF) + 20;
    CGFloat nameY = iconY;
    CGSize nameSize = [DeliveryUtility caculateContentSizeWithContent:model.name andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:17]];
    self.nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //职称
    CGFloat typeX = CGRectGetMaxX(self.nameF) + 20;
    CGFloat typeY = iconY;
    CGSize typeSize = [DeliveryUtility caculateContentSizeWithContent:model.job andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:14]];
    self.desPersonF = CGRectMake(typeX, typeY, typeSize.width, typeSize.height);
    //时间
    CGSize timeSize = [DeliveryUtility caculateContentSizeWithContent:model.create_at andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:14]];
    CGFloat timeX = [UIScreen mainScreen].bounds.size.width - timeSize.width - 20;
    CGFloat timeY = iconY;
    self.timeF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    //内容
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.nameF) + 10;
    CGSize contentSize = [DeliveryUtility caculateContentSizeWithContent:model.content andHight:MAXFLOAT andWidth:([UIScreen mainScreen].bounds.size.width - 20 - nameX) andFont:[UIFont systemFontOfSize:15]];
    self.contentF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    //图片  （一张）
    CGFloat imageX = nameX;
    CGFloat imageY = CGRectGetMaxY(self.contentF) + 10;
    CGFloat imageWH = 100;
    self.imageF = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    self.cellHeigth = CGRectGetMaxY(self.imageF) + 30;
    
}


@end
