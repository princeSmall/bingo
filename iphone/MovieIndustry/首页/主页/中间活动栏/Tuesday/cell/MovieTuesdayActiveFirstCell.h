//
//  MovieTuesdayActiveFirstCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieTuesdayGoodModel;

@interface MovieTuesdayActiveFirstCell : UITableViewCell


@property (nonatomic,retain) MovieTuesdayGoodModel *goodsModel;

@property (strong, nonatomic) IBOutlet UIButton *startBtn;

@property (strong, nonatomic) IBOutlet UIButton *histoyBtn;

@property (strong, nonatomic) IBOutlet UILabel *time;//倒计时


@property (strong, nonatomic) IBOutlet UIButton *leftSegmentBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightSegmentBtn;
@property (strong, nonatomic) IBOutlet UIView *segmentLine;


@end
