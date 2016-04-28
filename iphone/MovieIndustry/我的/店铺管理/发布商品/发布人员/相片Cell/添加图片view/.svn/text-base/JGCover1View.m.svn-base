//
//  JGCoverView.m
//  图片View的封装（scrollerView）
//
//  Created by aaa on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGCover1View.h"
#import "SysTool.h"

@interface JGCover1View (){
    CGFloat lastScale;
}
@property (nonatomic,strong)CancelBlock block;
@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)UIButton * backBtn;
@property (nonatomic,strong)UIButton * changeBtn;

@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIImage * imageNew;
@property (nonatomic,strong)UIScrollView * scroller;
@property (nonatomic,assign)CGFloat currentSizeScale;

@end

@implementation JGCover1View

- (instancetype)initWithFrame:(CGRect)frame WithImage:(UIImage *)image AndController:(UIViewController*)viewController AndCancelBlock:(CancelBlock)block{
    if (self = [super initWithFrame:frame]) {
        _currentSizeScale = 1;
        self.backgroundColor = [UIColor blackColor];
        self.block = block;
        self.viewController = viewController;
        self.imageView = [[UIImageView alloc]init];
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIPinchGestureRecognizer* gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImage:)];
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        UIScrollView * scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - self.frame.size.width)/2, self.frame.size.width, self.frame.size.width)];
        self.scroller = scroller;
        self.scroller.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.width);
        [self.imageView addGestureRecognizer:gesture];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:scroller];
        [scroller addSubview:self.imageView];
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        CGFloat btnY = screenH - (self.frame.size.height - self.frame.size.width)/2 + 10;
        
        self.scroller.scrollEnabled = YES;
        
        /**
         *  下面是创建按钮的地方
         *
         *  @param 0
         *  @param btnY
         *  @param screenW/3
         *  @param 50
         *
         *  @return
         */
        //删除按钮
        self.cancelBtn = [self createBtnWithTitle:@"删除" AndFrame:CGRectMake(0, btnY, screenW/3, 50)];
        [self.cancelBtn addTarget:self action:@selector(DelectImage) forControlEvents:UIControlEventTouchUpInside];
        self.changeBtn = [self createBtnWithTitle:@"替换" AndFrame:CGRectMake(screenW/3, btnY, screenW/3, 50)];
        [self.changeBtn addTarget:self action:@selector(ReplaceImage) forControlEvents:UIControlEventTouchUpInside];
        self.backBtn = [self createBtnWithTitle:@"返回" AndFrame:CGRectMake(screenW/3*2, btnY, screenW/3, 50)];
        [self.backBtn addTarget:self action:@selector(BackImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
/**
 *  捏合手势
 *
 *  @param gesture 图片的缩放，这边需要计算原始的倍数
 */
- (void)scaleImage:(UIPinchGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        lastScale = 1;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - [gesture scale]);
    CGAffineTransform currentTransform = [gesture view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[gesture view]setTransform:newTransform];
    lastScale = [gesture scale];
}
/**
 *  修改滚动视图的contentFrame
 *
 *  @param scale
 */
- (void)ScrollerViewChangeContentSzieWithScale:(CGFloat)scale{
    CGSize currentSize = self.scroller.contentSize;
    currentSize.width *= scale;
    currentSize.height *= scale;
    self.scroller.contentSize = currentSize;
}



- (void)DelectImage{
    self.block(@"1",nil);
}

- (void)ReplaceImage{
    [[SysTool ShareTool]ShowActionSheetInViewController:self.viewController AndChoseBlock:^(UIImage *img, NSData *data) {
        self.imageView.image = img;
        self.imageNew = img;
    }];
}
- (void)BackImage{
    
    if (self.imageNew) {
        self.block(@"2",self.imageNew);
    }else{
    self.block(@"0",nil);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UIButton *)createBtnWithTitle:(NSString *)title AndFrame:(CGRect)rect{
    UIButton * button = [[UIButton alloc]initWithFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}


@end
