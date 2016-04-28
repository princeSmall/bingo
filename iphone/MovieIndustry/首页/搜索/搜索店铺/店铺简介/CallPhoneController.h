//
//  CallPhoneController.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallPhoneController : UIViewController
/**
 *  打电话
 *
 *  @param number                  电话号码
 *  @param inViewController     需要打电话的控制器
 */
+(void)call:(NSString *)number inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock;
@end
