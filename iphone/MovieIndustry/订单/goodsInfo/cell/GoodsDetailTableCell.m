//
//  GoodsDetailTableCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "GoodsDetailTableCell.h"

@interface GoodsDetailTableCell()

@property (nonatomic ,strong)UIImageView * icon;
@property (nonatomic, strong)UILabel * nameLabel;
@property (nonatomic, strong)UILabel * desPerson;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic, strong)UILabel * content;
@property (nonatomic, strong)UIImageView * desImage;

@end


@implementation GoodsDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon = [[UIImageView alloc]init];
        [self addSubview:self.icon];
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textColor = [UIColor colorWithRed:0.337 green:0.392 blue:0.420 alpha:1.000];
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.nameLabel];
        
        self.desPerson = [[UILabel alloc]init];
        self.desPerson.textColor =[UIColor colorWithRed:0.337 green:0.392 blue:0.420 alpha:1.000];
        self.desPerson.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.desPerson];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = [UIColor colorWithRed:0.576 green:0.576 blue:0.580 alpha:1.000];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.timeLabel];
        
        self.content = [[UILabel alloc]init];
        self.content.textColor =[UIColor colorWithRed:0.576 green:0.576 blue:0.580 alpha:1.000];
        self.content.font = [UIFont systemFontOfSize:15];
        self.content.numberOfLines = 0;
        [self addSubview:self.content];
        
        self.desImage = [[UIImageView alloc]init];
        [self addSubview:self.desImage];
        
    }
    return self;
}

- (void)setGframe:(GoodCommitFrame *)Gframe{
    _Gframe = Gframe;
    GoodsCommentModel * model = Gframe.model;
    self.icon.frame = Gframe.iconF;
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    
    if (!model.img) {
       self.icon.image = [UIImage imageNamed:@"defualt_headerImg"];
    }else{
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img]]];
    }
    self.nameLabel.text = model.name;
    self.nameLabel.frame = Gframe.nameF;
    
    self.desPerson.text = model.job;
    self.desPerson.frame = Gframe.desPersonF;
    
    self.timeLabel.text = model.create_at;
    self.timeLabel.frame = Gframe.timeF;
    
    self.content.text = model.content;
    self.content.frame = Gframe.contentF;
    
    self.desImage.frame = Gframe.imageF;
    
    if (![model.pics isEqualToString:@"0000.jpg"]) {
               [self.desImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.pics]]];
            self.desImage.layer.cornerRadius = 5;
            self.desImage.layer.masksToBounds = YES;
        }
}




@end
