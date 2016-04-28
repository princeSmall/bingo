//
//  MovieTalkToPersonViewController.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MWPhotoBrowser.h"

@protocol MovieArticleDetailDelegate <NSObject>

- (void)commentArticleSuccess:(BOOL)isSuccess;

@end

@interface MovieTalkToPersonViewController : BaseViewController<MWPhotoBrowserDelegate>


@property (nonatomic,assign) id<MovieArticleDetailDelegate> delegate;

@property (nonatomic,copy) NSString *articleId;


@end
