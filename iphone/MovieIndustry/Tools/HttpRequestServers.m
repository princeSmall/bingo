//
//  HttpRequestServers.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HttpRequestServers.h"
//阿里支付需要的头文件
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation HttpRequestServers

+ (void)requestBaseUrl:(NSString *) url withParams:(NSMutableDictionary *) params withRequestFinishBlock:(HttpRequestServersFinishBlock) finishBlock withFieldBlock:(HttpRequestServersFieldBlock) fieldBlock{
    
    // 在状态栏显示有网络请求的提示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        //        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSLog(@"responseObject:%@",responseObject);
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&err];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在状态栏关闭有网络请求的提示器
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (dic) {
                if (finishBlock){
                    finishBlock(dic);
                }
            }else{
                NSString *data = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (data) {
                    if (finishBlock) {
                        finishBlock(data);
                    }
                }
            }
            if (err) {
                NSString *str = [[NSString alloc] initWithFormat:@"%@",err];
                NSLog(@"err:%@",str);
                if (fieldBlock) {
                    fieldBlock();
                }
            }
            
        });
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在状态栏关闭有网络请求的提示器
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//            NSString *str = [[NSString alloc] initWithFormat:@"%@",error];
//            NSLog(@"err1:%@",str);
            if (fieldBlock) {
                fieldBlock();
            }
            
        });
        
    }];
}

#pragma mark- 上传图片
+ (AFHTTPRequestOperationManager *)postImageRequest:(NSString *)URLString
                                            UIImage:(UIImage*)image
                                         parameters:(NSMutableDictionary *)parameters
                                      requestFinish:(HttpRequestServersFinishBlock) finishBlock
                                       requestField:(HttpRequestServersFieldBlock) fieldBlock
{
    
    
    // 在状态栏显示有网络请求的提示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *currentRequest = [AFHTTPRequestOperationManager manager];
    
    //image_upload  fileInput
    
    [currentRequest POST:URLString
              parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //UIImageJPEGRepresentation(image, 0.5)
    [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
                                name:@"image_upload"
                            fileName:@"icon.jpg"
                            mimeType:@"image/*"];
    
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在状态栏关闭有网络请求的提示器
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (finishBlock) {
            finishBlock(responseObject);
        }
        
    });
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在状态栏关闭有网络请求的提示器
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"%@",error);
        if (fieldBlock) {
            fieldBlock();
        }
        
    });
}];
    
    return currentRequest;
}



+ (void)requestGETBaseUrl:(NSString *) url withParams:(NSMutableDictionary *) params withRequestFinishBlock:(HttpRequestServersFinishBlock) finishBlock withFieldBlock:(HttpRequestServersFieldBlock) fieldBlock{
    
    if (!url) {
        if (fieldBlock) {
            fieldBlock();
        }
        return;
    }
    // 在状态栏显示有网络请求的提示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.requestSerializer.timeoutInterval = 30.00f;
    //    NSLog(@"%@:%@",url,params);
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&err];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在状态栏关闭有网络请求的提示器
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (dic) {
                if (finishBlock) {
                    finishBlock(dic);
                }
            }else{
                NSString *data = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (data) {
                    if (finishBlock) {
                        finishBlock(data);
                    }
                }
            }
            if (err) {
                NSString *str = [[NSString alloc] initWithFormat:@"%@",err];
                NSLog(@"err:%@",str);
                if (fieldBlock) {
                    fieldBlock();
                }
            }
            
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在状态栏关闭有网络请求的提示器
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSString *str = [[NSString alloc] initWithFormat:@"%@",error];
            NSLog(@"err1:%@",str);
            if (fieldBlock) {
                fieldBlock();
            }
            
        });
    }];
    
}

#pragma mark - 支付宝支付
+ (void)sendAlipayWithOrderSn:(NSString *)orderSn orderName:(NSString *)orderName orderDescription:(NSString *)orderDescription orderPrice:(NSString *)OrderPrice andScallback:(Callback)scallback
{
    //商家信息
//    NSString *partner = @"2088021828324789";
    NSString *partner = @"2088612301888269";
//    NSString *seller = @"cs@comefilm.com";
    NSString *seller = @"butterfly02@shanggong.sh.cn";
//    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOPrCXVVALT8fV5RtJxM433FBhKQxbrbvXdw7Dhsy6piA0ncZezwbV3N1lu+hpVa6h+aqPeKCl9WEmizOtmmkIC22Cl8bkMDxse4Wgmo+8bL65AvJc+lJ9d41JP23HUgtKM+JMHpGvev4KyKVCbgEGRseLFO5M/11N9O9sIbZrbrAgMBAAECgYEA3Ef060cNmN8TmE5lvk797De5h8YOpWvt8fvdAyf7rCBwxzlR9a/mNCxWSnOZhc7Jy2PifOUY403AGxtm/Kdkrn8BIozNz0MWfd5WnLGajjgmT+GI0aSg0SEMQRq2XkKIl730gN6m8gg42hxewi6z3kJwSYUY+4rzgyz2SUtZbNkCQQD+Pfs1xUGKhDjHSQCv8Ocn+zw/eyg1fTQ3MnQ5ksjIYYoK8ZdM/BVKRSlkleXAHNFe3AmN2pv/El7PGHzd/XhFAkEA5X52DBqSI8K20iulGX3ZpuMTRmaiB984WiXvxxY4MoxXv/fmoRWhXdsqmUkRzb+zT+Z6yAzOpyn5kn+Ly7zdbwJAcTA0+95i7IErKgXlSW8t6k3ep8BzyUSBj6VluxAPVa6fH3opSvvbmqIp6H8XtyzdRacelcnis2+BSB/1z3r+JQJBAJIad5bvF5jSrseQ57QZ7gYUTMImNwOh9eNWgZeSqsZrmLXrYhWtiqUREcaywTXm1IaKqiJQHQRJccz1jI9xttsCQQCjiWeroaG0ju9J0VF4X+Am6qOL64BtgkjpuNerBuD5TfBE2zE64E8bjmUlngcaG4xkDHGW7gePrKV7GbT8dRli";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTyLdYdgafOQ1M9\nnCHSbstTBakA4598jgR8PYk8MxNRhLHblpvXo98JXSPgigAvOSwfCmwNldO8fku0\nLfmxWHv2JYHmSMz+HpdU7UhUJeIEj+z5+NEz22p/l6NNtSZD8vxi/+n+K8Ap2/2g\nWYpjZjhkIgFzz5JJaS3ikAJwzDXXAgMBAAECgYA1y2TDwGmC2W9AVGrKPj1vIi1A\nnXKPRKlSBlGUo7Hby/9vyWgZB0zGhjs/qnxnUn7OU2g4XXmYTTs+GGgadNuS/dUg\nPEJ08JmPlU7R8W6ceuBSA2jaEJ0zf3iOhe22v1WEmnhvn8Oum2i33JaoQhoNhKzs\n8LbwJIJLJBE9hlUeUQJBAOXcKGdhcAxgQymkN0hMj6DCwyfLXKuyjQzQpQPWR+a6\nm8Oy+JHQxwhKElI8xB7fLwZbZ8jW6LuWV62s/99NUE8CQQDbV86K+mUJrQz7L5CF\nTF+ncopQGUUW1e7B0UaWO98xYl2ehxp2wxQHn6E8iyL0gnc6wsmUuI20LBuahIQC\n/hf5AkBdo4RqKQ2GXSi/LADBWT8hlHYAHh5Qa9p+H/k5SO/dlKOj46LTdCPAwrwX\n+F1E3lK/2ji7XqFM2gA55kIOa+aNAkEA1X/XhEGL/Woa+5hltMoNRWDhLmwaasrb\ntn5slak7a8dSVw8sfDMQGQeRGuxXnuYrBeA59G/bRme0iqe4E22eiQJBAM1gnVKG\nE568ImvBNn1fvl//0Slh0E7xbyjSGvQebLr7LiD+Cl6lgQfZcDWrohYnPvzB7p2o\nDiQBiU+lzfJ7COM=";
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
//   NSString *publicKey =  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDj6wl1VQC0/H1eUbScTON9xQYSkMW62713cOw4bMuqYgNJ3GXs8G1dzdZbvoaVWuofmqj3igpfVhJoszrZppCAttgpfG5DA8bHuFoJqPvGy+uQLyXPpSfXeNST9tx1ILSjPiTB6Rr3r+CsilQm4BBkbHixTuTP9dTfTvbCG2a26wIDAQAB";
    
    //生成商品信息
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = orderSn; //订单ID（由商家自行制定）
    order.productName = orderName; //商品标题
    order.productDescription = orderDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[OrderPrice floatValue]]; //商品价格
    order.notifyURL = @"";
//    order.notifyURL =  @"http://1.szmytravel.sinaapp.com/home/index/DoPayDemo"; //回调URL
    
    
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"YH.CFSH";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            //支付之后 返回的参数
            NSLog(@"reslut = %@",resultDic);
            
            //block返回支付完成之后的字典文件
            scallback(resultDic);
            
        }];
        
    }
    
}



@end
