//
//  GoodCommitFrame.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsCommentModel.h"


@interface GoodCommitFrame : NSObject

@property (nonatomic,assign)CGRect iconF;
@property (nonatomic,assign)CGRect nameF;
@property (nonatomic,assign)CGRect desPersonF;
@property (nonatomic,assign)CGRect timeF;
@property (nonatomic,assign)CGRect imageF;
@property (nonatomic,assign)CGRect contentF;

@property (nonatomic,assign)CGFloat cellHeigth;

@property (nonatomic,strong)GoodsCommentModel * model;

@end
