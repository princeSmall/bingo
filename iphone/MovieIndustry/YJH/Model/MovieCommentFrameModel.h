//
//  MovieCommentFrameModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/3.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ModelArticleCommentModel;

@interface MovieCommentFrameModel : NSObject

/**
 *  保存计算出来的正文的frame
 */
@property (nonatomic, assign) CGRect contentFrame;

/**
 *  保存当前cellModel的cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  保存一个cell的显示数据
 */
@property (nonatomic,retain) ModelArticleCommentModel *cellModel;


@end
