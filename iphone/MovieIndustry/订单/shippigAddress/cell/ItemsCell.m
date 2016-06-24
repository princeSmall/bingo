//
//  ItemsCell.m
//  TTIChooseAddress
//
//  Created by 童乐 Patrick on 3/31/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import "ItemsCell.h"

@implementation ItemsCell

- (void)awakeFromNib {
    // Initialization code
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width+100, 1)];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithTableView:(UITableView *)tableView
                       indexpath:(NSIndexPath *)indexpath
{
    static NSString *cellIdentifier = @"cellIdentifier0";
    UINib *nib = [UINib nibWithNibName:@"ItemsCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    self = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexpath];
 
    return self;
    
}

@end
