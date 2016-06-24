//
//  ShippingAddressListController.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/4.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"

@protocol ShippingAddressListDelegate <NSObject>

- (void)setAddressWithConsignee:(NSString *)consignee andAddress:(NSString *)regionAreaAddress andTel:(NSString *)tel andAddress_id:(NSString *)address_id;

@end

@protocol ShippingAddressDelegate <NSObject>
- (void)CreateOrder;

@end


@interface ShippingAddressListController : BaseViewController

@property (nonatomic,weak) id<ShippingAddressListDelegate> delegate;
@property (nonatomic,weak)id<ShippingAddressDelegate>dele;

@end
