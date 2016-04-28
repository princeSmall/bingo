//
//  MyTableViewCell.m
//  烦恼光
//
//  Created by aaa on 16/1/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"
#import "DJSView.h"
#define UCColor [[UIColor alloc]initWithRed:200/255.0 green:0 blue:0 alpha:1.0]

@interface  MyTableViewCell()

@property (nonatomic,strong)UILabel * lineLabelDraw;
@property (nonatomic,strong)UILabel * countLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *DJSView;
@property (weak, nonatomic) IBOutlet UIButton *qianggouBtn;
//轮播图View  这边需要传入图片数据


//第多少期的抢购记录
@property (nonatomic,strong)NSString * whichTimeStr;
//block
@property (nonatomic,strong)EndBlock block;

@end


@implementation MyTableViewCell
- (IBAction)panicBtn:(id)sender {
    self.block(self.whichTimeStr);
}

- (void)SetQishu:(NSString *)qs AndPeopleJoinCount:(NSString *)pj AndEndTime:(NSString *)endtime AndEndBlock:(EndBlock)block{
    self.whichTimeStr = qs;
    self.block = block;
    self.whichTime.text = [NSString stringWithFormat:@" 第 %@ 期",qs];
    self.howMany.text = [NSString stringWithFormat:@"%@人参与",pj];
    self.endTime.text = [NSString stringWithFormat:@"%@止",endtime];
}

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString * ID = @"cell";
    MyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;

}
//创建定时器View
- (void)createTimerLabel{
    DJSView * view = [[DJSView alloc]initWithFrame:CGRectMake(10, 10, 200, 30) AndEndTime:@"2016-2-29-18:48:30" AndEndBlock:^{
        NSLog(@"结束");
    }];
    [self.DJSView addSubview:view];
}

//创建咖么价格1元
- (void)CreateCameLabelWithPrice:(NSString *)price{
    [self createTimerLabel];
    NSString * string = [NSString stringWithFormat:@"咔么价：%@元",price];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 4)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:UCColor range:NSMakeRange(4, string.length - 4)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(4, price.length)];
      [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(string.length -1,1)];
    
     CGSize size = [attributeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.kamoLabel = [[UILabel alloc]initWithFrame:CGRectMake(146, 126, size.width, 21)];
    [self addSubview:self.kamoLabel];
    self.kamoLabel.attributedText = attributeStr;
}
//创建划线label
- (void)CreateCameLabelWithLine:(NSString *)price{
    self.nameLabel.text = @"当时间为0的时候，需要传出事件，关闭定时器";
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    
    CGSize size = [price boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGFloat labelX = CGRectGetMaxX(self.kamoLabel.frame) + 10;
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, 128, size.width, 21)];
    [self addSubview:self.lineLabel];
    self.lineLabel.text = price;
    self.lineLabel.textColor = [UIColor grayColor];
    self.lineLabel.font = [UIFont systemFontOfSize:12];
    CGRect rect = self.lineLabel.frame;
    rect.origin.y += 12;
    rect.size.height = 1;
    self.lineLabelDraw = [[UILabel alloc]init];
    [self addSubview:_lineLabelDraw];
    self.lineLabelDraw.frame = rect;
    self.lineLabelDraw.backgroundColor = [UIColor lightGrayColor];
}
//创建共五件 label
- (void)CreateCountLabel:(NSString *)count{

    CGFloat countX = CGRectGetMaxX(self.lineLabel.frame) + 10;
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(countX, 128, 100, 21)];
    self.countLabel.text = [NSString stringWithFormat:@"共%@件",count];
    self.countLabel.textColor = [UIColor grayColor];
    self.countLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.countLabel];
}
//多少人抢购
- (void)CreateHowManyPeople:(NSString *)count{
    CGFloat labelX = self.nameLabel.frame.origin.x;
    CGFloat labelY = self.qianggouBtn.frame.origin.y+6;
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSString * string = [NSString stringWithFormat:@"%@人抢购成功",count];
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, size.width + 10, size.height)];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, count.length)];
    [attributeStr addAttribute: NSFontAttributeName value:[UIFont systemFontOfSize:13]  range:NSMakeRange(count.length,5)];
    label.attributedText = attributeStr;
    label.textColor = UCColor;
    [self addSubview:label];
}


@end
