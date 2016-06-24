//
//  CertificationScrollView.m
//  Identifier
//
//  Created by 童乐 Patrick on 1/20/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "CertificationScrollView.h"
#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface CertificationScrollView()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong)UIButton *button;
@end
@implementation CertificationScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if(self)
    {
        if([title isEqualToString:@"个人认证"])
        {
            NSArray *arrayLabel =[NSArray arrayWithObjects:@"上传证件照(正面)",@"上传证件照(反面)",@"个人手持身份证", nil];
            [self showView:arrayLabel];
        }
        if([title isEqualToString:@"公司认证"])
        {
            NSArray *arrayLabel =[NSArray arrayWithObjects:@"营业执照",@"组织机构代码证",@"税务登记证",@"法人身份证", nil];
            [self showView:arrayLabel];
        }
    
    }
    return self;

}

-(void)showView:(NSArray *)arrayLabel
{
    
    
    for(int i=0;i<arrayLabel.count;i++)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, i*(230+55), self.frame.size.width, 305)];
        [self addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, 230)];
        [button addTarget:self action:@selector(actionAddPic:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_sczp"] forState:UIControlStateNormal];
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 230+10, self.frame.size.width, 40)];
        label.text = [arrayLabel objectAtIndex:i];
        label.textColor = RGBColor(124, 124, 124, 1.0);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        if(i==arrayLabel.count-1)
        {
            UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(10, (i+1)*(230+55)+40, self.frame.size.width-20, 45)];
            submitButton.backgroundColor = [UIColor whiteColor];
            [submitButton setTitle:@"提交" forState:UIControlStateNormal];
            [submitButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            submitButton.layer.cornerRadius = 8;
            submitButton.layer.masksToBounds =YES;
            [self addSubview:submitButton];
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, arrayLabel.count*305+130);

}
/**
 *  添加照片
 *
 *  @param sender 按钮
 */
-(void)actionAddPic:(UIButton*)sender
{
    
    self.button = sender;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"打开相机拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action){
        UIImagePickerControllerSourceType sourceType= UIImagePickerControllerSourceTypeCamera;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = sourceType;
            [self.window.rootViewController presentViewController:picker animated:YES completion:nil];
        }
        else
        {
            //模拟器下无法打开相机
        }

    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"打开相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action){
        UIImagePickerController *pick = [[UIImagePickerController alloc]init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        pick.allowsEditing =YES;
        [self.window.rootViewController presentViewController:pick animated:YES completion:nil];
    }];

    UIAlertAction *actionCancer = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action){
    }];
    [alert addAction:actionOne];
    [alert addAction:actionTwo];
    [alert addAction:actionCancer];
    [self.window.rootViewController presentViewController:alert animated:YES completion:^{
    }];

}

//选择玩图片后回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if([type isEqualToString:@"public.image"])
    {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [self.button setBackgroundImage:image forState:UIControlStateNormal];

        }];
        
    }

}
@end
