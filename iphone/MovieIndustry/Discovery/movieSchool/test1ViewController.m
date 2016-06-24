//
//  test1ViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "test1ViewController.h"
#import "MovieClassesDetailController.h"
@interface test1ViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
//    self.view.backgroundColor = [UIColor redColor];
}

- (void) creatTableView {
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.frame  = CGRectMake(0, 0, kViewWidth, kViewHeight - 40);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"asdfhadsfkj";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
@end
