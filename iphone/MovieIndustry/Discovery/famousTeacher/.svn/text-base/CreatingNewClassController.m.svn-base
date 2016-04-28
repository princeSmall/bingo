//
//  CreatingNewClassController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CreatingNewClassController.h"

@interface CreatingNewClassController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *classPostBtn;
@property (weak, nonatomic) IBOutlet UIButton *classClassifyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *classClasssifyVHCT;
@property (nonatomic, assign) BOOL isClassifyBtnClicked;
@property (weak, nonatomic) IBOutlet UIView *classClassifyContentV;

@end

@implementation CreatingNewClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewBorderRadius(self.classPostBtn, 5, 0, [UIColor whiteColor]);
    [self setNavTabBar:@"我要开课"];
    self.isClassifyBtnClicked = NO;
    [self classClassifyBtnClicked:self.classClassifyBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)classPostBtnClicked:(UIButton *)sender {
}
- (IBAction)classClassifyBtnClicked:(UIButton *)sender {
    if (!self.isClassifyBtnClicked) {
        self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
        [UIView animateWithDuration:0.5 animations:^{
            self.classClasssifyVHCT.constant = 0;
            [self.classClassifyContentV layoutIfNeeded];
        }];
    } else {
        self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
        [UIView animateWithDuration:0.5 animations:^{            
            self.classClasssifyVHCT.constant = 81;
            [self.classClassifyContentV layoutIfNeeded];
        }];
       
    }
}
- (IBAction)classifyCameraBtnClick:(UIButton *)sender {
    [self.classClassifyBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
    [UIView animateWithDuration:0.5 animations:^{
        self.classClasssifyVHCT.constant = 0;
        [self.classClassifyContentV layoutIfNeeded];
    }];
}
- (IBAction)equipment:(UIButton *)sender {
    [self.classClassifyBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
    [UIView animateWithDuration:0.5 animations:^{
        self.classClasssifyVHCT.constant = 0;
        [self.classClassifyContentV layoutIfNeeded];
    }];
}

- (IBAction)addPictureBtnClicked:(UIButton *)sender {
    [self openSheet];
}
- (void) openSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = sourceType;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        } else {
            
        }
    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
        
    }];
    [alert addAction:actionOne];
    [alert addAction:actionTwo];
    [alert addAction:actionCancle];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
// 选择完图片后回调
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
@end
