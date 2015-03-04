//
//  PictureCarouselView.h
//  TuPianLunBoQi
//
//  Created by     -MINI on 15/7/29.
//  Copyright (c) 2015年     -MINI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureCarouselView;
@protocol PictureCarouselViewDelegate <NSObject>
/**
 *  点击控件中的图片后所执行的方法
 *
 *  @param pictureCarouslView 控件本身
 *  @param index              点击的图片序号
 */
- (void)didClickedPictureCarouselView:(PictureCarouselView *)pictureCarouslView pictureIndex:(NSInteger)index;

@end

@interface PictureCarouselView : UIView
/**
 *  控件所容纳的图片数组
 */
@property (strong, nonatomic)NSArray *pictures;
/**
 *  控件中的图片是否有高亮
 */
@property (assign, nonatomic)BOOL picturesAdjustsHighlighted;
/**
 *  控件代理
 */
@property (strong, nonatomic)id<PictureCarouselViewDelegate> delegate;

//UIPageControl的对齐方式
typedef NS_OPTIONS(NSUInteger, AlignmentMethods) {
    AlignmentMethodCenter  =  0,//居中
    AlignmentMethodLeft    =  1,//左对齐
    AlignmentMethodRight   =  2,//右对齐
};

/**
 *  创建及初始化方法
 *
 *  @param frame 控件大小
 *
 *  @return 控件本身
 */
+ (instancetype)pictureCarouselViewWithFrame:(CGRect)frame;
/**
 *  设置控件是否自动滚动
 *
 *  @param isAutomatic  是否自动滚动
 *  @param isAnimation  是否有滚动动画
 *  @param timeInterval 动画间隔时间
 */
- (void)isAutomaticDragging:(BOOL)isAutomatic withAnimation:(BOOL)isAnimation withTimeInterval:(float)timeInterval;
/**
 *  对控件中小点的设置
 *
 *  @param frame           大小
 *  @param alignmentMethod 对齐方式
 *  @param currentColor    当前点的颜色
 *  @param indicatorColor  其他点的颜色
 */
- (void)setPageControlWithFrame:(CGRect)frame AlignmentMethod:(AlignmentMethods)alignmentMethod withCurrentColor:(UIColor *)currentColor withIndicatorColor:(UIColor *)indicatorColor;


@property (nonatomic,strong)NSString * topScroll;

@end
