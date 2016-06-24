//
//  ShareView.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate <NSObject>

@optional
///返回首页
- (void)backIndex;
///收藏
- (void)collectButtonAction;
///qq分享
- (void)qqButtonAction;

///新浪分享
- (void)xinaButtonAction;

///分享到微信好友
- (void)wechatButtonAction;
///微信分享
- (void)timelineButtonAction;


@end

@interface ShareView : UIView

@property (weak, nonatomic) IBOutlet UIButton *indexButton;


@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *qqButton;


@property (weak, nonatomic) IBOutlet UIButton *wechatButton;

@property (weak, nonatomic) IBOutlet UIButton *timelineButton;

@property (weak, nonatomic) IBOutlet UIButton *xinaButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;

@property (nonatomic,strong) UIView *blackAlertView;

@property (nonatomic,weak) id <ShareViewDelegate> delegate;

- (void)show;

- (void)myRemove;

@end
