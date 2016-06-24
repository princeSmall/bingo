//
//  FilmTimeLineCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "FilmTimeLineCell.h"
#import "FilmTimeIconView.h"
#import "FilmTimeLineToolBar.h"
@interface FilmTimeLineCell ()
/**原创电影圈整体*/
@property (nonatomic,weak) UIView *originalView;
/**头像*/
@property (nonatomic, weak) FilmTimeIconView *iconView;
/**名称*/
@property (nonatomic, weak) UILabel *nameLbl;
/**分割线*/
@property (nonatomic, weak) UIView *splitView;
/**摄影师级别*/
@property (nonatomic, weak) UILabel *photographerlevelLbl;
/**内容*/
@property (nonatomic, weak) UILabel  *contentLabel;
/**配图*/
@property (nonatomic, weak) UIImageView *photoImageView;
/**时间*/
@property (nonatomic, weak) UILabel *timeLbl;


/**转发电影圈整体*/
@property (nonatomic, weak) UIView *reweetView;
/**转发内容*/
@property (nonatomic, weak) UILabel  *retweetcontentLabel;
/**转发配图*/
@property (nonatomic, weak) UIImageView *retweetphotoImageView;

@property (nonatomic, strong) FilmTimeLineToolBar *toolBar;
@end
@implementation FilmTimeLineCell
+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *ID = @"filmTimeLimeCell";
    FilmTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FilmTimeLineCell alloc] init];
    }
    return cell;
}
/**
 *  cell的初始化方法
 *  添加所有可能现实的控件，以及控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //去除cell高亮
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创电影圈
        [self setupOriginal];
        
        //初始化转发电影圈
        [self setupRetweet];
        
        //
        [self setupTooLBar];
    }
    return self;
}
/**
 *  初始化原创电影圈
 */
- (void) setupOriginal {
    /**原创电影圈整体*/
    UIView *originalView = [[UIView alloc] init];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    
    /**头像*/
    FilmTimeIconView *iconView = [[FilmTimeIconView alloc] init];
    self.iconView = iconView;
    [self.originalView addSubview:iconView];
    
    /**昵称*/
    UILabel  *nameLabel = [[UILabel alloc] init];
    self.nameLbl = nameLabel;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [self.originalView addSubview:nameLabel];

    /**时间*/
    UILabel  *timeLabel = [[UILabel alloc] init];
    self.timeLbl = timeLabel;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.originalView addSubview:timeLabel];
    
    /**内容*/
    UILabel  *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor blackColor];
    self.contentLabel = contentLabel;
    [self.originalView addSubview:contentLabel];
    
    /**摄影师级别*/
    UILabel *photographerlevelLbl = [[UILabel alloc] init];
    photographerlevelLbl.font = [UIFont systemFontOfSize:12];
    photographerlevelLbl.textColor = [UIColor blackColor];
    self.photographerlevelLbl = photographerlevelLbl;
    [self.originalView addSubview:photographerlevelLbl];
    
    /**分割线*/
    UIView *splitView = [[UIView alloc] init];
    self.splitView = splitView;
    splitView.backgroundColor = [UIColor lightGrayColor];
    [self.originalView addSubview:splitView];
    
    /**配图*/
    UIImageView *photoImageView = [[UIImageView alloc] init];
    self.photoImageView = photoImageView;
    [self.originalView addSubview:photoImageView];
}
/**
 *  初始化转发电影圈
 */
- (void) setupRetweet {
    /**转发电影圈整体*/
    UIView *retweetView = [[UIView alloc] init];
    self.reweetView = retweetView;
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = kViewBackColor;
    
    /**转发配图*/
    UIImageView *retweetphotoImageView = [[UIImageView alloc] init];
    self.retweetphotoImageView = retweetphotoImageView;
    [self.reweetView addSubview:retweetphotoImageView];
    
    /**内容*/
    UILabel  *retweetcontentLabel = [[UILabel alloc] init];
    retweetcontentLabel.font = [UIFont systemFontOfSize:12];
    retweetcontentLabel.numberOfLines = 0;
    self.retweetcontentLabel = retweetcontentLabel;
    [self.reweetView addSubview:retweetcontentLabel];
}
- (void) setupTooLBar {
    FilmTimeLineToolBar *toolBar = [FilmTimeLineToolBar filmTimeLineToolBar];
    self.toolBar = toolBar;
    [self.contentView addSubview:toolBar];
}
@end
