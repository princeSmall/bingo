//
//  CollectionHeadView.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/22/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeadView : UICollectionReusableView
@property (nonatomic ,strong)UIImage *image ;

@property (nonatomic ,strong)UIButton *button;

-(instancetype)initWithFrame:(CGRect)frame;
@end
