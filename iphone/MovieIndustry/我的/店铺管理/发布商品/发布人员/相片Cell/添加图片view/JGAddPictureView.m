//
//  JGAddPictureView.m
//  图片View的封装（scrollerView）
//
//  Created by aaa on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGAddPictureView.h"
#import "JGPictureBtn.h"
#import "SysTool.h"
#import "JGCover1View.h"
#import "ViewController.h"



@interface JGAddPictureView ()

@property (nonatomic,strong) UIViewController* viewController;
@property (nonatomic,strong)JGCover1View * coverView;
@end


@implementation JGAddPictureView
- (instancetype)initWithFrame:(CGRect)frame AndViewController:(UIViewController *)controller{
    if (self = [super initWithFrame:frame]) {
        self.viewController = controller;
        self.imageArray = [NSMutableArray array];
       [self ViewWithPictures:[self arrayFromArray:self.imageArray]];
    }
    return self;
}

+ (CGSize)sizeWithCount:(int)count{
    int row = (count-1)/countNumber + 1;
    CGFloat Height = row * PictureWH + (row - 1)*Magrin;
    CGFloat Width = countNumber * PictureWH + (countNumber - 1) * Magrin;
    return CGSizeMake(Width, Height);
}

- (NSArray *)arrayFromArray:(NSArray *)array{
    NSMutableArray * imageArray = [NSMutableArray array];
    [imageArray addObjectsFromArray:array];
    UIImage * addPicture = [UIImage imageNamed:@"addPicture"];
    
    if (array.count < 6) {
        [imageArray addObject:addPicture];
    }
    return imageArray;
}

- (void)ViewWithPictures:(NSArray *)imageArray{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    /**
     *  这边不需要设置frame了
     *
     *  @param int <#int description#>
     *
     *  @return <#return value description#>
     */
//   CGSize  size  = [JGAddPictureView sizeWithCount:(int)imageArray.count];
//    self.frame = CGRectMake(0, 0, size.width, size.height);
    for (int i = 0; i < imageArray.count-1; i ++) {
        CGFloat imageX = (PictureWH + Magrin)*(i%countNumber);
        CGFloat imageY = (PictureWH + Magrin)*(i/countNumber);
        JGPictureBtn * picBtn = [[JGPictureBtn alloc]initWithFrame:CGRectMake(imageX, imageY, PictureWH, PictureWH) AndImage:imageArray[i] AndButtonClickBlock:^(UIImage *img) {
            [self.viewController.view endEditing:YES];
            JGCover1View * coverView = [[JGCover1View alloc]initWithFrame:[UIScreen mainScreen].bounds WithImage:img AndController:self.viewController AndCancelBlock:^(NSString *type,UIImage * imageNew) {
                if ([type isEqualToString:@"0"]) {
                    [self.coverView removeFromSuperview];
                }
                if ([type isEqualToString:@"1"]) {
                    [self.coverView removeFromSuperview];
                    [self.imageArray removeObject:img];
                     [self ViewWithPictures:[self arrayFromArray:self.imageArray]];
                }
                if ([type isEqualToString:@"2"]) {
                    [self.coverView removeFromSuperview];
                    
                    for (int i = 0; i < self.imageArray.count; i ++) {
                        if ([self.imageArray[i] isEqual:img]) {
                              [self.imageArray replaceObjectAtIndex:i withObject:imageNew];
                              [self ViewWithPictures:[self arrayFromArray:self.imageArray]];
                            break;
                        }
                    }
                }
                
            }];
            self.coverView = coverView;
            [self.viewController.view.superview addSubview:coverView];
        }];
        [self addSubview:picBtn];
    }
    CGFloat imageX = (PictureWH + Magrin)*((imageArray.count-1)%countNumber);
    CGFloat imageY = (PictureWH + Magrin)*((imageArray.count-1)/countNumber);
    
    if (imageArray.count < 6) {
        JGPictureBtn * picBtn = [[JGPictureBtn alloc]initWithFrame:CGRectMake(imageX, imageY, PictureWH, PictureWH) AndImage:[imageArray lastObject] AndButtonClickBlock:^(UIImage *img) {
            [self.viewController.view endEditing:YES];
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [[SysTool ShareTool]ShowActionSheetInViewController:self.viewController AndChoseBlock:^(UIImage *img, NSData *data) {
                    
//                    [self uploadStoreLogoImage:img];
                    [self.imageArray addObject:img];
                    [self ViewWithPictures:[self arrayFromArray:self.imageArray]];
                }];
            }];
        }];
        [self addSubview:picBtn];
    }
    

}





@end
