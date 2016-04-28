//
//  PublishTimeLineController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PublishTimeLineController.h"
#import "MovieCircle_KeyboardToolBar.h"
@interface PublishTimeLineController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *addPicBtnContentV;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (weak, nonatomic) IBOutlet UITextView *tv;

@end
static CGFloat btnMargin = 10;

@implementation PublishTimeLineController
- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"发布说说"];
    
    [self setNavRightItem:@"发送" rightAction:@selector(sendFilmAction)];
    
    [self creatAddPicBtn];
    
    MovieCircle_KeyboardToolBar *toolBar = [MovieCircle_KeyboardToolBar initKeyboardToolBar];
    self.tv.inputAccessoryView = toolBar;
}
- (void)setNavRightItem:(NSString *)rightTitle rightAction:(SEL)rightAction
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 45, 25)];
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //添加点击事件
    [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -12)];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置TabBar左边的按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
}
- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 40, 30)];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void) sendFilmAction {
    
}
- (void) dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) creatAddPicBtn {
    UIButton *addPicBtn = [[UIButton alloc] init];
    self.selectBtn = addPicBtn;
    [self.addPicBtnContentV addSubview:addPicBtn];
    [addPicBtn setImage:[UIImage imageNamed:@"movieCircle_addPic"] forState:UIControlStateNormal];
   CGFloat btnWH = CGRectGetHeight(self.addPicBtnContentV.frame) - 2*btnMargin;
    addPicBtn.frame = CGRectMake(btnMargin, btnMargin,  btnWH, btnWH);
    [addPicBtn addTarget:self action:@selector(openSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.addPicBtnContentV addSubview:addPicBtn];
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
        [self.selectBtn setImage:image forState:UIControlStateNormal];
        [self creatNewAddPicBtn];
        [picker dismissViewControllerAnimated:YES completion:^{
    
        }];
    }
}
- (void) creatNewAddPicBtn{
   
    UIButton *nextAddPicBtn = [[UIButton alloc] init];
    self.selectBtn = nextAddPicBtn;
    [self.addPicBtnContentV addSubview:nextAddPicBtn];
    [self.btnArray addObject:nextAddPicBtn];
    NSInteger count = self.btnArray.count;
    if (count > 3) {
        return;
    }
    [nextAddPicBtn setImage:[UIImage imageNamed:@"movieCircle_addPic"] forState:UIControlStateNormal];
    
    CGFloat btnWH = CGRectGetHeight(self.addPicBtnContentV.frame) - 2*btnMargin;
    CGFloat  btnX = btnMargin * (count + 1) + btnWH * count;
   
    nextAddPicBtn.frame = CGRectMake(btnX, btnMargin,  btnWH, btnWH);
    [nextAddPicBtn addTarget:self action:@selector(openSheet) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
