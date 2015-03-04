//
//  ShopDetailController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShopDetailController.h"
#import "SearchShopHeaderView.h"
#import "ShopDetailView.h"

@interface ShopDetailController ()
@property (nonatomic,strong) SearchShopHeaderView *searchHeaderView;
@property (nonatomic,strong) ShopDetailView *detailView;
@end

@implementation ShopDetailController
- (SearchShopHeaderView *)searchHeaderView
{
    if (!_searchHeaderView) {
        _searchHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"SearchShopHeaderView" owner:nil options:nil] lastObject];
        _searchHeaderView.frame = CGRectMake(0, 0, kViewWidth, 128);
        _searchHeaderView.shopDetailButton.userInteractionEnabled = NO;
        [_searchHeaderView.callPhoneButton addTarget:self action:@selector(callPhoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchHeaderView;
}

- (void)callPhoneButtonAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_searchHeaderView.shopPhoneLabel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (ShopDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailView" owner:nil options:nil] lastObject];
        _detailView.frame = CGRectMake(0, 128+10, kViewWidth, 228);
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"店铺简介"];
    
    [self createUI];
    
    [self loadData];
}

- (void)createUI
{
    [self.view addSubview:self.searchHeaderView];
    [self.view addSubview:self.detailView];
}

- (void)loadData
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.shopID,@"location_id", nil];
    [HttpRequestServers requestBaseUrl:Shop_Detail_Url withParams:userDict withRequestFinishBlock:^(id result) {
        
        @try {
            NSDictionary *dict = result;
            HHNSLog(@"%@",dict);
            if ([dict[@"status"] isEqualToString:@"f99"]) {
                
                for (NSDictionary *shopInfoDcit in dict[@"list"]) {
                    
                    [self.searchHeaderView.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,shopInfoDcit[@"preview"]]]];
                    
                    self.searchHeaderView.shopNameLabel.text = shopInfoDcit[@"name"];
                    self.searchHeaderView.shopAddressLabel.text = shopInfoDcit[@"address"];
                    self.searchHeaderView.shopPhoneLabel.text = shopInfoDcit[@"tel"];
                    
                    
                    self.detailView.shopDescTextView.text = shopInfoDcit[@"brief"];
                    self.detailView.shopCreateTimeLabel.text = shopInfoDcit[@"time"];
                    
                    self.detailView.likeLabel.text = [NSString stringWithFormat:@"%@%%",shopInfoDcit[@"bili"]];
                    
                    if ([[WNController nullString:shopInfoDcit[@"xingji"]] isEqualToString:@""]) {

                          StarView *startView = [[StarView alloc] initWithFrame:CGRectMake(100, 13, 80, 20) score:0 canscore:@"0"];
                        [self.detailView.startView addSubview:startView];
                    }else
                    {
                              StarView *startView = [[StarView alloc] initWithFrame:CGRectMake(100, 13, 80, 20) score:0 canscore:@"0"];
                        NSInteger startCount = [shopInfoDcit[@"xingji"] integerValue];
//                        [startView createStartView:startCount];
                        [self.detailView.startView addSubview:startView];
                    }
                    
                    
                    
                    if ([[WNController nullString:shopInfoDcit[@"xingji"]] isEqualToString:@""]) {
                                StarView *startView = [[StarView alloc] initWithFrame:CGRectMake(kViewWidth-100, 20, 80, 20) score:0 canscore:@"0"];
               
                        [self.searchHeaderView addSubview:startView];
                    }else
                    {
                               StarView *startView = [[StarView alloc] initWithFrame:CGRectMake(kViewWidth-100, 20, 80, 20) score:0 canscore:@"0"];
                        NSInteger startCount = [shopInfoDcit[@"xingji"] integerValue];
//                        [startView createStartView:startCount];
                        [self.searchHeaderView addSubview:startView];
                    }
                    
                }
                
                
                
            }
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
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
