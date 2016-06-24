//
//  IndexAdCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexAdModel.h"

@interface IndexAdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftImageView;

@property (weak, nonatomic) IBOutlet UIButton *topImageView;

@property (weak, nonatomic) IBOutlet UIButton *leftBottomView;

@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightBottomView;

@property (weak, nonatomic) IBOutlet UILabel *rightBottomLabel;

@end
