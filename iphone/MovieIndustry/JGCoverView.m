//
//  JGCoverView.m
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import "JGCoverView.h"
#import "JGAreaModel.h"

@interface JGCoverView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)SelectBlock block;
@property (nonatomic,strong)NSArray * sourceArray;
@property (nonatomic,strong)UITableView * myTableView;

@end
@implementation JGCoverView

- (instancetype)initWithFrame:(CGRect)frame And:(NSArray *)sourceArray And:(SelectBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.sourceArray = sourceArray;
        self.block = block;
        self.backgroundColor = [[UIColor alloc]initWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        CGFloat tableVX = self.frame.size.width/3;
        CGFloat tableVY = self.frame.size.height/6;
        CGFloat tableVW = self.frame.size.width/3;
        CGFloat tableVH = self.frame.size.height/3*2;
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableVX, tableVY, tableVW, tableVH)];
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.myTableView = tableView;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArray.count;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    if (touch.tapCount == 2) {
        [self removeFromSuperview];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    JGAreaModel * model = self.sourceArray[indexPath.row];
    cell.textLabel.text = model.local_name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JGAreaModel * model = self.sourceArray[indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@,%@",model.local_name,model.ID];
    self.block(string);
}


@end
