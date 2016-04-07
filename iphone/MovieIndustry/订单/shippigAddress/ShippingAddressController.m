//
//  ShippingAddressController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShippingAddressController.h"
#import "ManagerShippingAddressController.h"
#import "JGButtonAreaView.h"
#import "JGAreaModel.h"


@interface ShippingAddressController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    UIView *_pickBgView;
    
    NSString *_proviceStr;
    NSString *_cityStr;
    NSString *_areaStr;
}
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,strong) UIPickerView *cityPickView;
///城市选择
@property (nonatomic,strong) UITextField *cityPickTextField;
///省
@property (nonatomic,strong) NSMutableArray *provinceArray;
//城市
@property (nonatomic,strong) NSMutableArray *cityArray;
//区
@property (nonatomic,strong) NSMutableArray *areaArray;
///省市区字符串
@property (nonatomic,copy) NSString *areaString;
///选择了地址
@property (nonatomic,assign) BOOL isChooseCity;
//省份label
@property (nonatomic,strong)NSString * proID;
@property (nonatomic,strong)NSString * citID;
@property (nonatomic,strong)NSString * areID;

@property (nonatomic,strong)NSString * type;

@end

@implementation ShippingAddressController

- (UITextField *)cityPickTextField
{
    if (!_cityPickTextField) {
        _cityPickTextField = [[UITextField alloc] init];
    }
    return _cityPickTextField;
}

- (NSMutableArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (IBAction)SaveBtnClick:(id)sender {
    NSLog(@"保存");
    [self saveButtonAction];
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (void)DownSwip{
    [self.view endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    self.view.frame = rect;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self.addressDetailTextView isExclusiveTouch]) {
        [self.addressDetailTextView resignFirstResponder];
    }
    [self.view endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    [UIView animateWithDuration:0.3 animations:^{
         self.view.frame = rect;
    }];
    
   
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"新建收货地址"];

    self.addressDetailTextView.delegate = self;
    //从本地读取plist文件
    self.postCodeLabel.delegate = self;

    NSArray * arr = [self.addressString componentsSeparatedByString:@","];
    _proviceStr = arr[0];
    _cityStr = arr[1];
    _areaStr = arr[2];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
    [self.consigneeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumberText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.postCodeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.view addSubview:self.cityPickTextField];

}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction
{
    if (self.isQuerenOrder) {
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate backleftViewController];
    }else
    {
        [self.navigationController popToViewController:APP_DELEGATE.managerShip animated:YES];
    }
}

#pragma mark - 选择省市区


#pragma mark - 保存地址
- (void)saveButtonAction
{
    
    if ([self.consigneeTextField.text isEqualToString:@""]) {
         [DeliveryUtility showMessage:@"请输入收货人姓名" target:nil];
    }else
    {
        //这边需要判断 手机号码是否合法
        if ([self.phoneNumberText.text isEqualToString:@""]) {
             [DeliveryUtility showMessage:@"请输入手机号码" target:nil];
        }else
        {
            if ([self.addressDetailTextView.text isEqualToString:@""]||[self.addressDetailTextView.text isEqualToString:@"详细地址"]) {
                 [DeliveryUtility showMessage:@"请输入详细地址" target:nil];
                
            }else if ([self.postCodeLabel.text isEqualToString:@""]) {
                [DeliveryUtility showMessage:@"请输入邮编" target:nil];
            } else {
                        
                        MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
                        
                        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                        dict[@"user_id"] = APP_DELEGATE.user_id;
                        dict[@"consignee_name"] = self.consigneeTextField.text;
                        dict[@"mobile"] = self.phoneNumberText.text;
                        dict[@"tel"] = @"13245678910";
                        dict[@"post_code"] = self.postCodeLabel.text;
                        dict[@"addr_detail"] = self.addressDetailTextView.text;
                
                NSArray * arr = [self.addressID componentsSeparatedByString:@","];
                NSArray * arr1 = [self.addressString componentsSeparatedByString:@","];
                dict[@"spare_address"] = [arr1 componentsJoinedByString:@""];
                dict[@"province_id"] = arr[0];
                        dict[@"city_id"] = arr[1];
                dict[@"province_name"] = arr1[0];
                dict[@"city_name"] = arr1[1];
                        dict[@"post_code"] = self.postCodeLabel.text;
                dict[@"district_id"] = arr[2];
                dict[@"district_name"] = arr1[2];
                        [HttpRequestServers requestBaseUrl:TIShipping_AddSAddr withParams:dict withRequestFinishBlock:^(id result) {
                            
                            NSDictionary *dict1 = result;
//                            HHNSLog(@"%@",dict1);
                            if ([dict1[@"code"] intValue] == 0 ) {
                                hud.labelText = @"保存成功";

                                [self backAction];
                                
                                
                           
                            }
                            
                            [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                            }];
                            
                       
                        } withFieldBlock:^{
                            [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                            }];
                        }];
                
            }
                    
                    
            
        }
        
    }
            
    
}



#pragma mark - UIPickerView代理方法
//返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//每组返回的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return self.provinceArray.count;
}

//返回每一列的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    JGAreaModel * model = self.provinceArray[row];
        return model.local_name;
        
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = self.view.frame;
    if ([textField isEqual:self.consigneeTextField]||[textField isEqual:self.phoneNumberText]) {
        
    }else{
    rect.origin.y = -100;
    [UIView animateWithDuration:0.3 animations:^{
         self.view.frame = rect;
    }];
}
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 限制输入框的字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneNumberText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.consigneeTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.postCodeLabel) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
}


#pragma mark - UItextView
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>30) {
        textView.text = [textView.text substringToIndex:30];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"详细地址"]) {
        textView.text = @"";
    }
    CGRect rect = self.view.frame;
    rect.origin.y = -50;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = rect;
    }];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"详细地址"]||[textView.text isEqualToString:@""]) {
        textView.text = @"详细地址";
        textView.textColor = [UIColor lightGrayColor];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        [self.view endEditing:YES];
        CGRect rect = self.view.frame;
        rect.origin.y = 64;
        
        [UIView animateWithDuration:0.3 animations:^{
             self.view.frame = rect;
        }];
        
       
//        [self.postCodeLabel becomeFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
