//
//  MoviePersonInfoTableViewCell.m
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "MoviePersonInfoTableViewCell.h"

@interface  MoviePersonInfoTableViewCell()<UITextFieldDelegate>

@end


@implementation MoviePersonInfoTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"cell";
    MoviePersonInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MoviePersonInfoTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}
- (void)settextFiledType:(NSString *)type{
    
    if ([type isEqualToString:@"1"]) {
        self.boyBtn.hidden = NO;
        self.girlBtn.hidden = NO;
        self.notRegist.hidden = YES;
        self.iconRight.hidden = YES;
        self.myTextfiled.hidden = YES;
    }
    if ([type isEqualToString:@"2"]) {
        self.boyBtn.hidden = YES;
        self.girlBtn.hidden = YES;
        self.notRegist.hidden = NO;
        self.iconRight.hidden = NO;
        self.myTextfiled.hidden = YES;
    }else{
    self.myTextfiled.keyboardType = UIKeyboardTypeNumberPad;
    }//手机号码
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.block(textField.text);
}
//@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
//@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *notRegist;
//@property (weak, nonatomic) IBOutlet UIImageView *iconRight;

- (void)setTitle:(NSString *)title AndTextFiled:(NSString *)text{
    self.nameLabel.text = title;
    self.myTextfiled.text = text;
    self.myTextfiled.delegate = self;
    [self.boyBtn addTarget:self action:@selector(BoyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.girlBtn addTarget:self action:@selector(grilClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.boyBtn.hidden = YES;
    self.girlBtn.hidden = YES;
    self.notRegist.hidden = YES;
    self.iconRight.hidden = YES;
    self.myTextfiled.hidden = NO;
    self.myTextfiled.keyboardType = UIKeyboardTypeDefault;
}

- (void)BoyClick{
    self.boyBtn.selected = !self.boyBtn.selected;
    if (self.boyBtn.selected) {
        self.girlBtn.selected = NO;
        self.block(@"1");
    }else{
        self.girlBtn.selected = YES;
        self.block(@"0");
    }
    
}
- (void)grilClick{
    self.girlBtn.selected = !self.girlBtn.selected;
    if (self.girlBtn.selected) {
         self.boyBtn.selected = NO;
        self.block(@"0");
    }else{
         self.boyBtn.selected = YES;
        self.block(@"1");
    }
}

@end
