//
//  TTIInputCell.m
//  kamefengzhuang
//
//  Created by 童乐 Patrick on 3/29/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import "TTIInputCell.h"

@interface TTIInputCell ()

@property (nonatomic,strong)UIView *lineView;

@end
@implementation TTIInputCell

- (void)awakeFromNib {
    // Initialization code
    [self.inputTxfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithTableView:(UITableView *)tableView{

    static NSString *cellIdentifier = @"cellIdentifier";
    self.lineView = [[UIView alloc]init];
        UINib *nib = [UINib nibWithNibName:@"TTIInputCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
       return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

}

-(void)inputWithSring:(NSString *)string
{
    self.itemsLbl.text = string;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
    }
}
@end
