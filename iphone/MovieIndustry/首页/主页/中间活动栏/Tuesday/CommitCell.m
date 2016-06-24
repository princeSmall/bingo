//
//  CommitCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CommitCell.h"
#import "CommitHeadView.h"

@interface CommitCell()

@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)CommitHeadView * headView;
//评论按钮
@property (nonatomic,strong)UIButton * pingBtn;
//点赞按钮
@property (nonatomic,strong)UIButton * zanBtn;

@end


@implementation CommitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
       self.headView = [[[NSBundle mainBundle]loadNibNamed:@"CommitHeadView" owner:self options:nil]lastObject];
        [self addSubview:self.headView];
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_contentLabel];
        _pingBtn = [[UIButton alloc]init];
        [self addSubview:_pingBtn];
        _zanBtn = [[UIButton alloc]init];
        [self addSubview:_zanBtn];
//        UIColor * color = [[UIColor alloc]initWithRed:255/255.0 green:255.0/255 blue:210/255.0 alpha:1.0];
//        self.backgroundColor = color;
        
    }
    return self;
}
- (void)setCommitFrame:(CommitFrame *)commitFrame{

    _commitFrame = commitFrame;
    NSString * content = _commitFrame.content;
    _contentLabel.text = content;
    _contentLabel.frame = commitFrame.contentF;
    self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 66);
    CGFloat pingX = [UIScreen mainScreen].bounds.size.width - 88;
    CGFloat pingW = 40;
    CGFloat pingY = CGRectGetMaxY(self.contentLabel.frame);
    CGFloat pingH = 30;
    _pingBtn.frame = CGRectMake(pingX, pingY, pingW, pingH);
    [_pingBtn setTitle:@"3 评" forState:UIControlStateNormal];
    [_pingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _zanBtn.frame = CGRectMake(pingX + 40, pingY, 40, 30);
    [_zanBtn setTitle:@"5 赞" forState:UIControlStateNormal];
    [_zanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _pingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _zanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
}



@end
