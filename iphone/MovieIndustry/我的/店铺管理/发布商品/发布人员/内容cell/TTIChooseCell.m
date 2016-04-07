//
//  TTIChooseCell.m
//  kamefengzhuang
//
//  Created by Hopkins Patrick on 3/29/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import "TTIChooseCell.h"

@implementation TTIChooseCell

- (void)awakeFromNib {
    // Initialization code
    self.cellSwitch.onTintColor = [UIColor colorWithRed:0.404 green:0.796 blue:0.643 alpha:1.000];
    [self.cellSwitch addTarget:self action:@selector(changeOn:) forControlEvents:UIControlEventValueChanged];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"cellIdentifier";
    if(self = [super init])
    {
        UINib *nib = [UINib nibWithNibName:@"TTIChooseCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        self = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return self;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)inputWithString:(NSString *)string
{
    self.itemLbl.text = string;
}

-(void)changeOn:(UISwitch *)sender
{
    self.changeOn(sender);
}
@end
