//
//  JGPhotoView.m
//  图片View的封装（scrollerView）
//
//  Created by aaa on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGPhotoView.h"



#define StatesPhotoWH 90
#define margin 10
#define WBStatusPhotoMaxCol(count) ((count==4)?2:3)

@interface  JGPhotoView()

@property (nonatomic,strong)PhotoClickBlock block;

@end


@implementation JGPhotoView

- (instancetype)initWithFrame:(CGRect)frame AndImagesArray:(NSArray *)imagesArray AndPhotoClickBlock:(PhotoClickBlock)block{

    if (self = [super initWithFrame:frame]) {
        self.block = block;
        self.userInteractionEnabled = YES;
        self.photoArrays = imagesArray;
    }
    return self;
}

+ (CGSize)sizeWithCount:(NSInteger)count {
    // 最大列数（一行最多有多少列）
    NSInteger maxCols = WBStatusPhotoMaxCol(count);
    // 列数 1  2 （1张或2张图片）(1列或2列)
    NSInteger cols = (count >= maxCols)? maxCols : count;  // 3 列 // 3 列
    CGFloat photosW = cols * StatesPhotoWH + (cols - 1) * margin;
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;  // 3 行  // 2 行
    CGFloat photosH = rows * StatesPhotoWH + (rows - 1) * margin;
    return CGSizeMake(photosW, photosH);
}

- (void)setPhotoArrays:(NSArray *)photoArrays{
    _photoArrays = photoArrays;
    NSInteger photosCount = photoArrays.count;
    while (self.subviews.count < photosCount) {
        JGStatesImageView * photoView = [[JGStatesImageView alloc]init];
        photoView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        [photoView addGestureRecognizer:tapGesture];
        [self addSubview:photoView];
    }
    for (int i = 0; i < self.subviews.count; i ++) {
        JGStatesImageView * photoView = self.subviews[i];
        if (i < photosCount) {
            [photoView createWithLocalImage:photoArrays[i]];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}
- (void)tapImage:(UITapGestureRecognizer *)tapGesture{
    JGStatesImageView * photoView = (JGStatesImageView *)tapGesture.view;
    self.block(photoView.image);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    int imagesCount = (int)self.subviews.count;
    int maxCol = WBStatusPhotoMaxCol(self.photoArrays.count);
    for (int i=0; i<imagesCount; i++) {
        UIImageView *photoView = self.subviews[i];
        int cols = i / maxCol;
        int rows = i % maxCol;
        CGFloat photoViewX = rows * (StatesPhotoWH + margin);
        CGFloat photoViewY = cols * (StatesPhotoWH + margin);
        photoView.frame = CGRectMake(photoViewX, photoViewY, StatesPhotoWH, StatesPhotoWH);
    }
}


@end
