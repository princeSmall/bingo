//
//  MoviePersonInfoTableViewCell.h
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SendBlock)(NSString * str);

@interface MoviePersonInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *myTextfiled;

@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;

@property (nonatomic,strong)SendBlock block;

@property (weak, nonatomic) IBOutlet UILabel *notRegist;
@property (weak, nonatomic) IBOutlet UIImageView *iconRight;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)setTitle:(NSString *)title AndTextFiled:(NSString *)text;

- (void)settextFiledType:(NSString *)type;

@end
