//
//  ReciveMesCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieMineReceiveNeedsModel;

@interface ReciveMesCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *knockBtn;//立即抢单按钮


@property (nonatomic,retain) MovieMineReceiveNeedsModel *receiveModel;


@end
