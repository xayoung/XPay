


//
//  XUnionPayManager.m
//  XPay
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "XUnionPayManager.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"
#import "XPayTool.h"
static XUnionPayManager *manger;
static XPayCompletion payCompletion;

@interface XUnionPayManager ()<UPPayPluginDelegate>

@end
@implementation XUnionPayManager

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[XUnionPayManager alloc] init];
    });
    return manger;
}

- (void)unionPayWithOrderDic:(NSDictionary *)orderDic viewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion
{
    
    NSString *sign = [orderDic objectForKey:@"sign"];
    if ([XPayTool isEmpty:sign]) {
        completion(XPAY_INVALID,@"银联调起支付错误,缺少订单签名字符串sign");
        return;
    }
 
    [UPPayPlugin startPay:sign mode:@"00" viewController:viewController delegate:self];
    payCompletion = completion;
}

- (void)UPPayPluginResult:(NSString *)result
{
    XPayResultStatus status = 0;
    NSString *msg = nil;
    if ([result isEqual:@"success"]) {
        status = XPAY_SUCCESS;
        msg = @"银联支付成功";
    }else if ([result isEqual:@"fail"]) {
        status = XPAY_FAILED;
        msg = @"银联支付失败";
    }else if ([result isEqual:@"cancel"]) {
        status = XPAY_CANCELED;
        msg = @"银联支付取消";
    }
    
    if (payCompletion) {
        payCompletion(status,msg);
    }

}
@end
