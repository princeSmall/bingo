//
//  SysTool.h
//  SystemTool
//
//  Created by aaa on 16/1/25.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImageChoseEndBlock)(UIImage * img,NSData * data);

@interface SysTool : NSObject
//单类化
+ (instancetype)ShareTool;
//打电话
+ (void)makePhoneCall:(NSString *)tel;
//发短信
+ (void)sendSMS:(NSString *)tel;
//屏幕截图返回图片
+ (UIImage *)getCutImageFromViewRect:(UIView *)view;
//屏幕截图，并保存到相册
+ (void)saveImageFromToPhotosAlbum:(UIView *)view;
//打开相册或者相机，然后将选中的图片和data用block传出去
- (void)ShowActionSheetInViewController:(UIViewController*)ViewController AndChoseBlock:(ImageChoseEndBlock)block;
//传入文本和文本的宽度，然后返回文本的size
+ (CGSize)caculateContentSizeWithContent:(NSString *)content AndWidth:(CGFloat)width andFont:(UIFont *)font;
//创建一个label用来展示一些提示消息，string为要展示的内容，View为要展示的view，y为在view上的Y坐标
+ (void)createLabelShowString:(NSString *)string WithView:(UIView*)view AndLabelYframe:(CGFloat)y;

@end
