//
//  MovieCommentSecondCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommentSecondCell.h"
#import "PlaceholderTextView.h"


@interface MovieCommentSecondCell ()

@end



@implementation MovieCommentSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}



- (void)awakeFromNib {
    self.textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-20, 100)];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.masksToBounds = YES;
    self.textView.Placeholder = @"写点什么吧";
    self.textView.layer.borderColor = [UIColor colorWithRed:193.0f/255.0f green:193.0f/255.0f blue:193.0f/255.0f alpha:1].CGColor;
    self.textView.layer.borderWidth = 1;
    [self addSubview:self.textView];
    
    self.cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, 100, 100)];
    self.cameraBtn.clipsToBounds = YES;
    self.cameraBtn.layer.cornerRadius = 10;
    self.cameraBtn.backgroundColor = [UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000];
    [self.cameraBtn setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
    [self addSubview:self.cameraBtn];
}


@end
