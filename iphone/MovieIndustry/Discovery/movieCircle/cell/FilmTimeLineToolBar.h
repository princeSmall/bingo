//
//  FilmTimeLineToolBar.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilmTimeLineStatus;
@interface FilmTimeLineToolBar : UIView
@property (nonatomic, strong) FilmTimeLineStatus *status;

+ (instancetype) filmTimeLineToolBar;
@end
