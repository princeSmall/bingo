//
//  MovieClassesDetailCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/10.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesDetailCell.h"
@interface MovieClassesDetailCell ()
@property (weak ,nonatomic) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *contentLbl;


@end
@implementation MovieClassesDetailCell

- (instancetype) initWithTableView:(UITableView *)tableView  {
    static NSString *ID = @"cell";
    MovieClassesDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MovieClassesDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super
                 initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLbl = [[UILabel alloc] init];
        self.titleLbl = titleLbl;
        [self.contentView addSubview:titleLbl];
        titleLbl.textColor = [UIColor blueColor];
        titleLbl.font = [UIFont systemFontOfSize:15];
        
        UILabel *contentLbl = [[UILabel alloc] init];
        contentLbl.numberOfLines = 0;
        contentLbl.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLbl = contentLbl;
        [self.contentView addSubview:contentLbl];
        contentLbl.textColor = [UIColor darkGrayColor];
        contentLbl.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    self.titleLbl.text = [dic objectForKey:@"title"];
    self.contentLbl.text = [dic objectForKey:@"content"];
    CGFloat contentH = [NSString heightForString:_contentLbl.text fontSize:15 andWidth:(kViewWidth - CGRectGetMaxX(_titleLbl.frame) - 10)];
    self.cellH = contentH + 20;
    _titleLbl.frame = CGRectMake(10, 5, 60, 20);
    self.contentLbl.frame = CGRectMake(CGRectGetMaxX(_titleLbl.frame) + 5, 5, kViewWidth - CGRectGetMaxX(_titleLbl.frame) - 10, contentH);
}

@end
