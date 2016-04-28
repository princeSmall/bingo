//
//  FilmTimeLineToolBar.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "FilmTimeLineToolBar.h"
#import "FilmTimeLineStatus.h"
@interface FilmTimeLineToolBar ()
/**所有的按钮*/
@property (strong,nonatomic) NSMutableArray *btnArray;
/**转发*/
@property (nonatomic, weak) UIButton *repostBtn;
/**评论*/
@property (nonatomic, weak) UIButton *commentBtn;
/**点赞*/
@property (nonatomic, weak) UIButton *attitudeBtn;
@end
@implementation FilmTimeLineToolBar
- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
+ (instancetype) filmTimeLineToolBar {
    return [[self alloc] init ];
}
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加按钮
        self.repostBtn = [self setupBtn:@"转发" icon:@"zhuanfa.jpg"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"pinglun.jpg"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"dianzan.jpg"];
        

    }
    return self;
}
/**
 *  初始化按钮
 *
 *  @param title
 *  @param icon
 */
- (UIButton *) setupBtn:(NSString *) title icon:(NSString *) icon {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    return btn;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    int btnCount = (int) self.btnArray.count;
    CGFloat margin = 15;
    CGFloat btnW = self.width - 2 * margin;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i ++ ) {
        UIButton *btn = self.btnArray[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * (btnW + margin);
    }
}
- (void)setStatus:(FilmTimeLineStatus *)status {
    _status = status;
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}
- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
