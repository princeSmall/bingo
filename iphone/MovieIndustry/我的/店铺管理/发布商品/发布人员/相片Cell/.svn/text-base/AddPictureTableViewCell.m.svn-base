//
//  AddPictureTableViewCell.m
//  添加图片cell
//
//  Created by aaa on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "AddPictureTableViewCell.h"

#import "AppDelegate.h"

@interface AddPictureTableViewCell()

@property (nonatomic,strong)UILabel * labelGoods;

@property (nonatomic,strong)UILabel * line;




@end


@implementation AddPictureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.addView = [[JGAddPictureView alloc]initWithFrame:CGRectMake(10, 35, app.window.frame.size.width, PictureWH) AndViewController:app.ShowViewController];
//        self.addView.backgroundColor = [UIColor greenColor];
        self.labelGoods = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, self.frame.size.width, 30)];
        self.labelGoods.textColor = [UIColor colorWithWhite:0.110 alpha:1.000];
        self.labelGoods.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.labelGoods];
        [self addSubview:self.addView];
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(0, PictureWH+58, app.window.frame.size.width, 1)];
        self.line.backgroundColor = [UIColor colorWithWhite:0.827 alpha:0.5];
        [self addSubview:self.line];
        
    }
    return self;
}

- (NSArray *)getPictureArray{

         return self.addView.imageArray;
}

- (void)setTitle:(NSString *)string{
    self.labelGoods.textColor = [UIColor colorWithWhite:0.345 alpha:1.000];
    self.labelGoods.font = [UIFont systemFontOfSize:16];
    self.labelGoods.text = string;
}


@end
