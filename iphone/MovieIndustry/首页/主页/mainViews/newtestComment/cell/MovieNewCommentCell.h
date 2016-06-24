//
//  MovieNewCommentCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelArticleCommentModel;
@class MovieTuesdayCommentModel;

@interface MovieNewCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *blessBtn;//点赞按钮

@property (nonatomic,retain) ModelArticleCommentModel *commentModel;


@property (nonatomic,retain) MovieTuesdayCommentModel *activeModel;

@property (strong, nonatomic) IBOutlet UIImageView *commentImage;//评论图片

@end
