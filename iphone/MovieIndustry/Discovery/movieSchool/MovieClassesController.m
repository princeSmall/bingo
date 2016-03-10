//
//  MovieClassesController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesController.h"
#import "MovieClasses_TotalCollectionCell.h"
@interface MovieClassesController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout >

@end

@implementation MovieClassesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"精品课程"];
    [self creatCollection];
}
- (void) creatCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *colloctionV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
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

@end
