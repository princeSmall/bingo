//
//  PictureCarouselView.m
//  TuPianLunBoQi
//
//  Created by     -MINI on 15/7/29.
//  Copyright (c) 2015年     -MINI. All rights reserved.
//
#define SELF_WIDTH             self.scrollView.frame.size.width
#define SELF_HEIGHT            self.scrollView.frame.size.height

#import "PictureCarouselView.h"
#import "CustomPageControl.h"
@interface PictureCarouselView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CustomPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *pictureButtons;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isAutomatic;
@property (assign, nonatomic) BOOL isAnimation;
@property (assign, nonatomic) float timeInterval;

//标识首页的轮播字段

@end

@implementation PictureCarouselView
#pragma mark - 属性方法
- (void)setPictures:(NSArray *)pictures
{
    if (pictures) {
        _pictures = pictures;
        [self setImageViewsWithPictures:pictures];
        self.pageControl.numberOfPages = pictures.count;
        self.pageControl.userInteractionEnabled =NO;
    }
}
- (NSMutableArray *)pictureButtons
{
    if (!_pictureButtons) {
        _pictureButtons = [NSMutableArray array];
    }
    
    return _pictureButtons;
}
- (void)setPicturesAdjustsHighlighted:(BOOL)picturesAdjustsHighlighted
{
    _picturesAdjustsHighlighted = picturesAdjustsHighlighted;
    if (self.pictureButtons) {
        UIButton *button = (UIButton *)self.pictureButtons[1];
        button.adjustsImageWhenHighlighted = picturesAdjustsHighlighted;
    }
}

#pragma mark - 自定义方法
/**
 *  创建及初始化方法
 *
 *  @param frame 控件大小
 *
 *  @return 控件本身
 */
+ (instancetype)pictureCarouselViewWithFrame:(CGRect)frame
{
    PictureCarouselView *pictureCarouselView = [self getXib];
    pictureCarouselView.frame = frame;
    return pictureCarouselView;
}
/**
 *  获取主包中的xib文件
 *
 *  @return 此xib文件对应的实例对象
 */
+ (PictureCarouselView *)getXib
{
    PictureCarouselView *pictureCarouselView = [[[NSBundle mainBundle] loadNibNamed:@"PictureCarouselView" owner:nil options:nil] firstObject];
    return pictureCarouselView;
}
/**
 *  设置图片
 *
 *  @param pictures 图片数组
 */
- (void)setImageViewsWithPictures:(NSArray *)pictures
{
    //为了达到循环的效果，扩展两张图片
    int count = (int)pictures.count + 2;
    for (int index = 0; index < count; index++) {
        //用NSNull占位，让button在用到时再创建
        [self.pictureButtons addObject:[NSNull null]];
    }
    self.scrollView.contentSize = CGSizeMake(SELF_WIDTH*count, SELF_HEIGHT);
    self.scrollView.contentOffset = CGPointMake(SELF_WIDTH, 0);
}
/**
 *  创建对应页码下的button，及做出相应的设置
 *
 *  @param page 页码号
 */
- (void)loadScrollViewWithPage:(int)page
{
    if (self.pictureButtons.count>0) {
        UIButton *button = self.pictureButtons[page];
        if ([button isKindOfClass:[NSNull class]]) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(SELF_WIDTH*page, 0, SELF_WIDTH, SELF_HEIGHT);
            [self.pictureButtons replaceObjectAtIndex:page withObject:button];//将数组中序号为page的对象用UIButton替换
            if (page == 0) {
                page = (int)self.pictures.count - 1;
            }
            else if (page == self.pictureButtons.count - 1)
            {
                page = 0;
            }
            else
            {
                page = page - 1;
            }
            
            if (page >= self.pictures.count) {
                page = (int)self.pictures.count -1;
            }
            
            NSString *path =self.pictures[page];
            if(path.length<8)
            {
//                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,self.pictures[page]]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:self.pictures[page]] forState:UIControlStateNormal];

            }
            else
            {
//                  [button setBackgroundImage:[UIImage imageNamed:self.pictures[page]] forState:UIControlStateNormal];
#warning 
#warning 

                ///设置按钮的背景图片
                [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.pictures[page]]]]] forState:UIControlStateNormal] ;
            }

            [button setContentMode:UIViewContentModeScaleAspectFill];
        
            button.clipsToBounds = YES;
            button.adjustsImageWhenHighlighted = self.picturesAdjustsHighlighted;
            [button addTarget:self action:@selector(didButtonClicked:) forControlEvents:UIControlEventTouchUpInside];  
            [self.scrollView addSubview:button];
        }

    }
}
/**
 *  设置控件是否自动滚动
 *
 *  @param isAutomatic  是否自动滚动
 *  @param isAnimation  是否有滚动动画
 *  @param timeInterval 动画间隔时间
 */
- (void)isAutomaticDragging:(BOOL)isAutomatic withAnimation:(BOOL)isAnimation withTimeInterval:(float)timeInterval
{
    if (isAutomatic) {
        if (!self.isAutomatic) {
            self.isAutomatic = isAutomatic;
            self.isAnimation = isAnimation;
            self.timeInterval = timeInterval;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(nextPage:) userInfo:[NSNumber numberWithBool:isAnimation] repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
/**
 *  自动滚动时，滚到下一页所需操作
 *
 *  @param timer 控制自动滚动的定时器
 */
- (void)nextPage:(NSTimer *)timer
{
    [self.scrollView setContentOffset:CGPointMake(SELF_WIDTH*(self.pageControl.currentPage + 2), 0) animated:YES];
}
/**
 *  停止滚动所执行的操作
 */
- (void)scrollViewFromMoveToStatic
{
    int page = self.scrollView.contentOffset.x/SELF_WIDTH;
    if (page == 0) {
        [self loadScrollViewWithPage:(int)self.pictureButtons.count - 2];
        self.scrollView.contentOffset = CGPointMake(SELF_WIDTH*(self.pictureButtons.count - 2), 0);
    }
    else if (page == self.pictureButtons.count - 1)
    {
        self.scrollView.contentOffset = CGPointMake(SELF_WIDTH, 0);
    }
}
/**
 *  对控件中小点的设置
 *
 *  @param frame           大小
 *  @param alignmentMethod 对齐方式
 *  @param currentColor    当前点的颜色
 *  @param indicatorColor  其他点的颜色
 */
- (void)setPageControlWithFrame:(CGRect)frame AlignmentMethod:(AlignmentMethods)alignmentMethod withCurrentColor:(UIColor *)currentColor withIndicatorColor:(UIColor *)indicatorColor
{
    self.pageControl.frame = frame;
    //修改UIPageCantrol的颜色与右对齐方式
    self.pageControl.pageIndicatorTintColor = indicatorColor;
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    if (alignmentMethod == AlignmentMethodCenter) {
        return;
    }
    else
    {
        NSInteger count = self.pageControl.numberOfPages;
        CGSize pointSize = [self.pageControl sizeForNumberOfPages:count];
        CGFloat page_x = -(self.pageControl.bounds.size.width - pointSize.width) / 2;
        if (alignmentMethod == AlignmentMethodLeft) {
            [self.pageControl setBounds:CGRectMake(page_x, self.pageControl.bounds.origin.y, self.pageControl.bounds.size.width, self.pageControl.bounds.size.height)];
        }
        else if(alignmentMethod == AlignmentMethodRight)
        {
            [self.pageControl setBounds:CGRectMake(-page_x, self.pageControl.bounds.origin.y, self.pageControl.bounds.size.width, self.pageControl.bounds.size.height)];
        }
    }
}

#pragma mark - 点击触摸事件
- (void)didButtonClicked:(UIButton *)sender
{
    if (self.delegate) {
        NSInteger page =self.pageControl.currentPage;
        [self.delegate didClickedPictureCarouselView:self pictureIndex:page];
    }
}

#pragma mark - UIScrollViewDelegate代理方法
// 用户开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /**
     *  用户拖动时，制空定时器
     */
    [self.timer invalidate];
    self.timer = nil;
}
// 滚动到某个位置时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = floor((self.scrollView.contentOffset.x + SELF_WIDTH/2)/SELF_WIDTH);
    if (page < 0||page>self.pictureButtons.count-1) {
        return;
    }
    if (page > 0 && page < self.pictureButtons.count - 1) {
        //往左拖动时，加载下一页
        if (self.scrollView.contentOffset.x > page*SELF_WIDTH) {
            [self loadScrollViewWithPage:page + 1];
        }
        //加载当前页
        else if (self.scrollView.contentOffset.x == page*SELF_WIDTH)
        {
            [self loadScrollViewWithPage:page];
        }
        //往右拖动，加载上一页
        else
        {
            [self loadScrollViewWithPage:page - 1];
        }
    }
    if (page == 0) {
        page = (int)self.pictureButtons.count - 1;
    }
    else if (page == self.pictureButtons.count - 1)
    {
        page = 1;
    }
    self.pageControl.currentPage = page -1;
}
// 用户结束拖拽时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewFromMoveToStatic];
}
//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewFromMoveToStatic];
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isAutomatic) {
        [self isAutomaticDragging:self.isAutomatic withAnimation:self.isAnimation withTimeInterval:self.timeInterval];
    }
}


@end
