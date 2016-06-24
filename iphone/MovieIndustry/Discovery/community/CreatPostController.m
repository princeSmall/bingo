//
//  CreatPostController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CreatPostController.h"

@interface CreatPostController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTf;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *addPicBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;


@end

@implementation CreatPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackColor;
    [self setNavTabBar:@"创建新帖"];
    [self creatTagBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) creatTagBtn {
    NSArray *tagArray = [NSArray arrayWithObjects:@"器材",@"软件",@"拍摄技巧",@"其他", nil];
    CGFloat margin = 10;
    CGFloat btnY = 260;
    CGFloat btnW = (kViewWidth - 5*margin)/4;
    
    for (int i = 0; i < tagArray.count; i ++ ) {
        UIButton *tagBtn = [[UIButton alloc] init];
        CGFloat btnX = margin * (i+1)  + btnW * i;
        [tagBtn setTitle:tagArray[i] forState:UIControlStateNormal];
        tagBtn.backgroundColor = [UIColor whiteColor];
        [tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagBtn.frame = CGRectMake(btnX, btnY, btnW, 30);
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:tagBtn];
    }
}

- (IBAction)ReleaseBtnClicked:(UIButton *)sender {
    
}
- (IBAction)addPicBtnClicked:(UIButton *)sender {
    [self openSheet];
}
-(void)openSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"打开相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action){
        UIImagePickerControllerSourceType sourceType= UIImagePickerControllerSourceTypeCamera;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = sourceType;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
            
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
        [self.navigationController presentViewController:pick animated:YES completion:nil];
    }];
    
    UIAlertAction *actionCancer = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:actionOne];
    [alert addAction:actionTwo];
    
    [alert addAction:actionCancer];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}
//选择完图片后回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if([type isEqualToString:@"public.image"])
    {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.addPicBtn setImage:image forState:UIControlStateNormal];
            [self creatNewAddPicBtn];
        }];
        
    }
}
- (void) creatNewAddPicBtn {
    
    
}

@end
