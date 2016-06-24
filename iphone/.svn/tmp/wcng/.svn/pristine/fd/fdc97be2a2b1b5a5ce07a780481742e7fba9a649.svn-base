//
//  JGSecondCoverView.m
//  MovieIndustry
//
//  Created by aaa on 16/2/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "JGSecondCoverView.h"
#import "JGAreaModel.h"

@interface JGSecondCoverView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray * sourceArray;

//@property (nonatomic,strong)UITableView *secondTable;
@property (nonatomic,strong)SelectBlock block;
@end

@implementation JGSecondCoverView

- (instancetype)initWithFrame:(CGRect)frame And:(NSArray *)sourceArray WithBlock:(SelectBlock)block{
    if (self = [super initWithFrame:frame]) {
       self.backgroundColor = [UIColor redColor];
        self.sourceArray = sourceArray;
        self.block = block;
        
        self.myTableView = [[UITableView alloc]initWithFrame:self.frame style: UITableViewStylePlain];
       self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.myTableView];
        [self.myTableView reloadData];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * IDS = @"cell1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IDS];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDS];
    }
    JGAreaModel * model = self.sourceArray[indexPath.row];
    cell.textLabel.text = model.local_name;

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JGAreaModel * model = self.sourceArray[indexPath.row];
//    NSString * string = [NSString stringWithFormat:@"%@,%@",model.local_name,model.ID];
    self.block(model.local_name);
    [self removeFromSuperview];
 
}




@end
