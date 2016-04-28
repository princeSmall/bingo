//
//  CommitFrame.m
//  MovieIndustry
//
//  Created by aaa on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CommitFrame.h"

@implementation CommitFrame

- (void)setContent:(NSString *)content{
    _content = content;
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGFloat weigth = [UIScreen mainScreen].bounds.size.width - 90;
    CGSize contentSize = [_content boundingRectWithSize:CGSizeMake(weigth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.contentF = CGRectMake(83, 70, weigth, contentSize.height);
    self.cellHigth = 100 + contentSize.height;
}


@end
