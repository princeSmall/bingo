//
//  JGAddPictureView.h
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>
#define countNumber 5
#define Magrin 6
//#define PictureWH 55
#define PictureWH  (([UIScreen mainScreen].bounds.size.width - (countNumber-1)*Magrin - 50)/countNumber)


@interface JGAddPictureView : UIView

@property (nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic,strong)NSMutableArray * imgArray;

//获取View的尺寸。如果是cell的话也是可以用这个尺寸的
+ (CGSize)sizeWithCount:(int)count;

- (instancetype)initWithFrame:(CGRect)frame AndViewController:(UIViewController *)controller;

- (void)ViewWithPictures:(NSArray *)imageArray;
@end
