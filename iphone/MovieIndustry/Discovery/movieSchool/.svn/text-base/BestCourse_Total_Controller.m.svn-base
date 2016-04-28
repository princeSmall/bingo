//
//  BestCourse_Total_Controller.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BestCourse_Total_Controller.h"
#import "MovieClasses_TotalCollectionCell.h"
#import "MovieClassesDetailController.h"
@interface BestCourse_Total_Controller () <UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout >

@end

@implementation BestCourse_Total_Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"精品课程"];
    [self creatCollection];
}

- (void) creatCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGRect colloctionFrame = CGRectMake(0, 0, kViewWidth, kViewHeight - 40);
    UICollectionView *colloctionV = [[UICollectionView alloc] initWithFrame:colloctionFrame collectionViewLayout:flowLayout];
    colloctionV.backgroundColor = kViewBackColor;
    [self.view addSubview:colloctionV];
    [colloctionV registerClass:[MovieClasses_TotalCollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    
    colloctionV.delegate = self;
    colloctionV.dataSource = self;
}
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}
// 定义每个cell 大小
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(167, 216);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MovieClasses_TotalCollectionCell *cell = (MovieClasses_TotalCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    return cell;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MovieClassesDetailController *detailVC = [[MovieClassesDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
