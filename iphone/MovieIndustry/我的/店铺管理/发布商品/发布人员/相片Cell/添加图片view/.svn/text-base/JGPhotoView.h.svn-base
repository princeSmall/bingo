//
//  JGPhotoView.h
//  图片View的封装（scrollerView）
//
//  Created by aaa on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGStatesImageView.h"

typedef void (^PhotoClickBlock)(UIImage * img);

@interface JGPhotoView : UIImageView
//传入图片数组，内容为image格式
@property (nonatomic,strong)NSArray * photoArrays;

+ (CGSize)sizeWithCount:(NSInteger)count;

- (instancetype)initWithFrame:(CGRect)frame AndImagesArray:(NSArray *)imagesArray AndPhotoClickBlock:(PhotoClickBlock)block;

@end
