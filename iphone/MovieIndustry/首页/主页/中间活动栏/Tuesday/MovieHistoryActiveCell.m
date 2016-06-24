//
//  MovieHistoryActiveCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieHistoryActiveCell.h"
#import "MovieRushRequestCollectionCell.h"
#import "MovieMineNeedsRushedModel.h"
#import "MovieNeedsRushedGoodsInfoModel.h"


@interface MovieHistoryActiveCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *shopNameLab;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic,strong) NSArray *goodsArray;


@end

@implementation MovieHistoryActiveCell

- (NSArray *)goodsArray
{
    if (nil == _goodsArray) {
        _goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (void)setRushInfoModel:(MovieMineNeedsRushedModel *)rushInfoModel
{
    _rushInfoModel = rushInfoModel;
    
    //抢单时间
    self.timeLab.text = [NSString stringWithFormat:@"抢单时间 : %@",rushInfoModel.addTime];
    
    //店铺名称
    self.shopNameLab.text = rushInfoModel.locationName;
    
    //地址
    self.addressLab.text = rushInfoModel.city;
    
    //商品详情
    self.goodsArray = rushInfoModel.dealInfo;
    if (self.goodsArray.count) {
        [self.collectionView reloadData];
    }
}


- (void)awakeFromNib {
    
    //    self.headerImg.clipsToBounds = YES;
    //    self.headerImg.layer.cornerRadius = 25.0f;
    
    //注册UICollectionViewCell
    CGFloat itemW = (screenWidth-30)/3;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize=CGSizeMake(itemW,170);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    UINib *nib = [UINib nibWithNibName:@"MovieRushRequestCollectionCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"pictureCellID"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.goodsArray.count;
    return (count>=3)?3:count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieRushRequestCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCellID" forIndexPath:indexPath];
    
    MovieNeedsRushedGoodsInfoModel *infoModel = _goodsArray[indexPath.item];
    [cell setGoodModel:infoModel];
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieNeedsRushedGoodsInfoModel *infoModel = _goodsArray[indexPath.item];
    
    if ([self.delegate respondsToSelector:@selector(checkToSkimGoodInfoWithStoreId:andGoodId:)]) {
        
        [self.delegate checkToSkimGoodInfoWithStoreId:self.rushInfoModel.locationId andGoodId:infoModel.goodId];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
