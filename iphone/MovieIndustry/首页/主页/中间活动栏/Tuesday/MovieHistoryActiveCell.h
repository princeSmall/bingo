//
//  MovieHistoryActiveCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieMineNeedsRushedModel;

@protocol MovieRequestGoodsInfoDelegate <NSObject>

- (void)checkToSkimGoodInfoWithStoreId:(NSString *)storeId andGoodId:(NSString *)goodId;

@end

@interface MovieHistoryActiveCell : UITableViewCell

@property (nonatomic,assign) id<MovieRequestGoodsInfoDelegate> delegate;


@property (nonatomic,strong) MovieMineNeedsRushedModel *rushInfoModel;

@end
