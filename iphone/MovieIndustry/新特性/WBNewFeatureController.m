//
//  WBNewFeatureController.m
//  07-WeiBo新特性页面显示
//
//  Created by lin on 15/9/28.
//  Copyright © 2015年 lin. All rights reserved.
//

#import "WBNewFeatureController.h"

#import "MainTabBarController.h"

#define WBNewfeatureCount 5

@interface WBNewFeatureController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@interface WBNewFeatureController ()<UIScrollViewDelegate>

@end

@implementation WBNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1 创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = self.view.bounds;
    
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    //2 添加图片信息
    CGFloat scrollW = scrollView.frame.size.width;
    
    CGFloat scrollH = scrollView.frame.size.height;
    
    for (int i=0; i<WBNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageViewX = i * scrollW;
        CGFloat imageViewY = 0;
        CGFloat imageViewW = scrollW;
        CGFloat imageViewH = scrollH;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        NSString *name = [NSString stringWithFormat:@"引导页%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == WBNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(WBNewfeatureCount*scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // PageControl 进行数据分页
    
    UIPageControl *pageController = [[UIPageControl alloc] init];
    pageController.numberOfPages = WBNewfeatureCount;
    pageController.backgroundColor = [UIColor redColor];
    pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageController.pageIndicatorTintColor = [UIColor grayColor];
    CGPoint center = CGPointZero;
    center.x = scrollW * 0.5;
    center.y = scrollH - 50;
//    pageController.userInteractionEnabled = NO;
    pageController.bounds = CGRectZero;
    pageController.backgroundColor = [UIColor redColor];
    pageController.center = center;
    [self.view addSubview:pageController];
    self.pageControl = pageController;
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 1.5 + 0.5  => 2
    // 1.1 + 0.5  => 1
    // 1.6 + 0.5  => 2
    self.pageControl.currentPage = (int)(page + 0.5);
    //self.pageControl.currentPage = page;
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 1.分享给大家（checkbox）
//    UIButton *shareBtn = [[UIButton alloc] init];
//    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
//    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
//    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //shareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    
//    CGRect shareRect = CGRectZero;
//    shareRect.size = CGSizeMake(250, 30);
//    shareBtn.frame = shareRect;
//    
//    CGPoint shareBtnCenter = CGPointZero;
//    shareBtnCenter.x = imageView.frame.size.width * 0.5;
//    shareBtnCenter.y = imageView.frame.size.height * 0.65;
//    shareBtn.center = shareBtnCenter;
//    
//    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:shareBtn];
    //    shareBtn.backgroundColor = [UIColor redColor];
    //    shareBtn.imageView.backgroundColor = [UIColor blueColor];
    //    shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
    
    // top left bottom right
    
    // EdgeInsets: 自切
    // contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
    //    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
    
    // titleEdgeInsets:只影响按钮内部的titleLabel
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // imageEdgeInsets:只影响按钮内部的imageView
    //    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 50);
    
    
    
    //    shareBtn.titleEdgeInsets
    //    shareBtn.imageEdgeInsets
    //    shareBtn.contentEdgeInsets
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    CGRect startRect = CGRectZero;
    startRect.size = CGSizeMake(200, 100);
    startBtn.frame = startRect;
    
    CGPoint startCenter = startBtn.center;
    startCenter = self.view.center;
    startCenter.y = kViewHeight - 100;
    startBtn.center = startCenter;
//    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    /*
}
     切换控制器的手段
     1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    
//    [self presentViewController:[[WBTabBarViewController alloc] init] animated:YES completion:nil];
//    
//    [self.navigationController pushViewController:[[WBTabBarViewController alloc] init] animated:YES];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[MainTabBarController alloc] init];
    
}

- (void)dealloc
{
    
    NSLog(@"%s",__func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 1.程序启动会自动加载叫做Default的图片
 1> 3.5inch 非retain屏幕：Default.png
 2> 3.5inch retina屏幕：Default@2x.png
 3> 4.0inch retain屏幕: Default-568h@2x.png
 
 2.只有程序启动时自动去加载的图片, 才会自动在4inch retina时查找-568h@2x.png
 */

/*
 一个控件用肉眼看不见，有哪些可能
 1.根本没有创建实例化这个控件
 2.没有设置尺寸
 3.控件的颜色跟父控件的背景色一样（实际上已经显示了，只不过用肉眼看不见）
 4.透明度alpha <= 0.01
 5.hidden = YES
 6.没有添加到父控件中
 7.被其他控件挡住了
 8.位置不对
 9.父控件发生了以上情况
 10.特殊情况
 * UIImageView没有设置image属性，或者设置的图片名不对
 * UILabel没有设置文字，或者文字颜色和跟父控件的背景色一样
 * UITextField没有设置文字，或者没有设置边框样式borderStyle
 * UIPageControl没有设置总页数，不会显示小圆点
 * UIButton内部imageView和titleLabel的frame被篡改了，或者imageView和titleLabel没有内容
 * .....
 
 添加一个控件的建议（调试技巧）：
 1.最好设置背景色和尺寸
 2.控件的颜色尽量不要跟父控件的背景色一样
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
