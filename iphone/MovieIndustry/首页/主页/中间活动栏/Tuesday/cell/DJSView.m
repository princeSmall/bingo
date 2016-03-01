//
//  DJSView.m
//  倒计时View
//
//  Created by aaa on 16/2/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "DJSView.h"
#import "JGTimeView.h"


@interface DJSView ()

@property (nonatomic,strong)NSString * endTime;
//时分秒的展示
@property (nonatomic,strong)JGTimeView * timeView1;
@property (nonatomic,strong)JGTimeView * timeView2;
@property (nonatomic,strong)JGTimeView * timeView3;
//定时器和计数
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)endBlock block;
//冒号
@property (nonatomic,strong)UILabel * maohao1;
@property (nonatomic,strong)UILabel * maohao2;


@end

@implementation DJSView
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame AndEndTime:(NSString *)endTime AndEndBlock:(endBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.endTime = endTime;
        self.block = block;
        //倒计时label
        CGSize size1 = [self caculateContentSizeWithContent:@"倒计时 :" AndWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:16]];
        CGSize size2 = [self caculateContentSizeWithContent:@":" AndWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:18]];
        UILabel * labelDJS = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size1.width, size1.height)];
        labelDJS.font = [UIFont systemFontOfSize:16];
        UIColor * color = [[UIColor alloc]initWithRed:200/255.0 green:0 blue:0 alpha:1.0];
        labelDJS.textColor = color;
        labelDJS.text = @"倒计时 :";
        [self addSubview:labelDJS];
        NSArray * timeArray = [self getTimeStringArray];
        if([timeArray[0] isEqualToString:@"00"]&&[timeArray[1] isEqualToString:@"00"]&&[timeArray[2] isEqualToString:@"00"]){
            color = [UIColor lightGrayColor];
        }
        //小时View
        CGFloat hourX = CGRectGetMaxX(labelDJS.frame)+2;
        CGFloat hourY = 0;
        CGFloat hourW = 26;
        CGFloat hourH = 30;
        JGTimeView * timeView1 = [[JGTimeView alloc]initWithFrame:CGRectMake(hourX, hourY, hourW, hourH) AndTimeString:timeArray[0]];
        self.timeView1 = timeView1;
        [self addSubview:timeView1];
        //冒号 第一个 View
        CGFloat mao1X = CGRectGetMaxX(self.timeView1.frame);
        CGFloat mao1Y = -2;
        CGFloat mao1W = size2.width;
        CGFloat mao1H = size2.height;
        UILabel * labelMao1 = [[UILabel alloc]initWithFrame:CGRectMake(mao1X, mao1Y, mao1W, mao1H)];
        labelMao1.text = @":";
        labelMao1.textColor = color;
        labelMao1.font = [UIFont systemFontOfSize:16];
        [self addSubview:labelMao1];
        self.maohao1 = labelMao1;
        //分钟View
        CGFloat minX = CGRectGetMaxX(labelMao1.frame);
        CGFloat minY = 0;
        CGFloat minW = 26;
        CGFloat minH = 30;
        JGTimeView * timeView2 = [[JGTimeView alloc]initWithFrame:CGRectMake(minX, minY, minW, minH) AndTimeString:timeArray[1]];
        self.timeView2 = timeView2;
        [self addSubview:timeView2];
        //冒号 第二个 View
        CGFloat mao2X = CGRectGetMaxX(self.timeView2.frame)+1;
        CGFloat mao2Y = -2;
        CGFloat mao2W = size2.width;
        CGFloat mao2H = size2.height;
        UILabel * labelMao2 = [[UILabel alloc]initWithFrame:CGRectMake(mao2X, mao2Y, mao2W, mao2H)];
        labelMao2.text = @":";
        labelMao2.textColor = color;
        labelMao2.font = [UIFont systemFontOfSize:16];
        [self addSubview:labelMao2];
        self.maohao2 = labelMao2;
        //秒View
        CGFloat secondX = CGRectGetMaxX(labelMao2.frame);
        CGFloat secondY = 0;
        CGFloat secondW = 26;
        CGFloat secondH = 30;
        JGTimeView * timeView3 = [[JGTimeView alloc]initWithFrame:CGRectMake(secondX, secondY, secondW, secondH) AndTimeString:timeArray[2]];
        self.timeView3 = timeView3;
        [self addSubview:timeView3];
        self.timeView1.changeColor = color;
        self.timeView2.changeColor = color;
        self.timeView3.changeColor = color;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(UpDataTimeLabel) userInfo:nil repeats:YES];
    }
    return self;
}
//获取文本size
- (CGSize)caculateContentSizeWithContent:(NSString *)content AndWidth:(CGFloat)width andFont:(UIFont *)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}
//获取当前时间
- (NSString *)GetCurrentTime{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:DateFormatType];
    NSString * localTime = [dateFormatter stringFromDate:date];
    return localTime;
}
//判断结束时间与当前时间中间的秒数
- (int)countTimeInterval:(NSString *)checkDateString withShould:(NSString *)shouldDateString{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:DateFormatType];
    NSDate * checkDate = [dateFormatter dateFromString:checkDateString];
    NSDate *shouldDate = [dateFormatter dateFromString:shouldDateString];
    NSTimeInterval interval1 = [checkDate timeIntervalSince1970];
    NSTimeInterval interval2 = [shouldDate timeIntervalSince1970];
    double interval = interval2-interval1;
    
    if (interval < 0) {
        [self.timer invalidate];
        self.timer = nil;
        interval = 0;
    }
    
    return interval;
}
//拿到时间差之后转化为HH:mm:ss 由于方法需要一直调用，所以这边需要用到定时器
- (NSArray *)getTimeStringArray{
    int interval = [self countTimeInterval:[self GetCurrentTime] withShould:self.endTime];
    NSString * hour = [NSString stringWithFormat:@"%02d",interval/3600];
    NSString * min = [NSString stringWithFormat:@"%02d",(interval%3600)/60];
    NSString * second = [NSString stringWithFormat:@"%02d",(interval%3600)%60];
    NSArray * timeArray = @[hour,min,second];
    return timeArray;
}
//更新时分秒label的展示
- (void)UpDataTimeLabel{
    NSArray * timeArray = [self getTimeStringArray];
    //当时间为0的时候，需要传出事件，关闭定时器
    if([timeArray[0] isEqualToString:@"00"]&&[timeArray[1] isEqualToString:@"00"]&&[timeArray[2] isEqualToString:@"00"]){
        [self.timer invalidate];
        self.timer = nil;
        self.maohao1.textColor = [UIColor lightGrayColor];
        self.maohao2.textColor = [UIColor lightGrayColor];
        self.timeView1.changeColor = [UIColor lightGrayColor];
        self.timeView2.changeColor = [UIColor lightGrayColor];
        self.timeView3.changeColor = [UIColor lightGrayColor];
        self.block();
    }
    self.timeView1.timeString = timeArray[0];
    self.timeView2.timeString = timeArray[1];
    self.timeView3.timeString = timeArray[2];
}


@end
