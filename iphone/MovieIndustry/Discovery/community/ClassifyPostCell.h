//
//  ClassifyPostCell.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imageContentV;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end
