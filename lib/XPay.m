//
//  XPay.m
//  XPay
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "XPay.h"
#import "XPayTool.h"
#import "XAliPayManager.h"
#import "XWxPayManager.h"
#import "XUnionPayManager.h"

static Class payClass;
static XPay *manager = nil;
static NSString *aliPay_scheme = nil;
static NSString *wxPay_scheme = nil;
@implementation XPay

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XPay alloc] init];
    });
    return manager;
}



- (void)payWithOrderDic:(NSDictionary *)orderDic withType:(XPayType)type withScheme:(NSString *)scheme withViewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion
{
    BOOL isSupport = [self isSupportWithPayType:type withCompletion:completion];
    if (!isSupport) {
        return;
    }
    if (type == XPayType_ALIPAY) {
        
        if ([XPayTool isEmpty:scheme]) {
            if (completion) {
                completion(XPAY_INVALID,@"支付宝支付调起错误，没有传入scheme");
            }
            return;
        }
        aliPay_scheme = scheme;
        
        [[payClass manager] aliPayWithOrderDic:orderDic withScheme:scheme withCompletion:completion];
        
    } else if (type == XPayType_WX) {
        NSString *appId = [orderDic objectForKey:@"appId"];
      if ([XPayTool isEmpty:appId]) {
            if (completion) {
                completion(XPAY_INVALID,@"微信支付调起错误，字典中缺少appId");
            }
            return;
        }
        
        wxPay_scheme = appId;
        [[payClass manager] wxPayWithOrderDic:orderDic  withCompletion:completion];
    } else if (type == XPayType_UNION) {
        
        if (![viewController isKindOfClass:[UIViewController class]] || viewController == nil) {
            if (completion) {
                completion(XPAY_INVALID,@"银联支付调起错误，必须传入控制器");
            }
            return;
        }
        [[payClass manager] unionPayWithOrderDic:orderDic viewController:viewController withCompletion:completion];

    } else {
        if (completion) {
            completion(XPAY_INVALID,@"调起支付错误,请传入正确的支付类型");
        }
    }
}

- (void)handleOpenWithURL:(NSURL *)url withComletion:(XPayCompletion)completion
{
    if ([url.scheme isEqualToString:aliPay_scheme]) {
        [[payClass manager] handleOpenURL:url withCompletion:completion];
    } else if ([url.scheme isEqualToString:wxPay_scheme]) {
        [[payClass manager] handleOpenURL:url withCompletion:completion];
    }
}

- (BOOL)isSupportWithPayType:(XPayType)type withCompletion:(XPayCompletion)completion {

    if (type == XPayType_ALIPAY) {
        payClass = NSClassFromString(@"VAliPayManager");
        if (![payClass instancesRespondToSelector:@selector(aliPayWithOrderDic:withScheme:withCompletion:)]) {
            if (completion) {
                completion(XPAY_INVALID,@"调起支付宝支付错误，没有支付宝这个渠道");
            }
            return NO;
        }

    } else  if (type == XPayType_WX) {
        payClass = NSClassFromString(@"VWxPayManager");
        if (![payClass instancesRespondToSelector:@selector(wxPayWithOrderDic:withCompletion:)]) {
            if (completion) {
                completion(XPAY_INVALID,@"调起微信支付错误，没有微信这个渠道");
            }
            return NO;
        }
        
    } else  if (type == XPayType_UNION) {
        payClass = NSClassFromString(@"VUnionPayManager");
        if (![payClass instancesRespondToSelector:@selector(unionPayWithOrderDic:viewController:withCompletion:)]) {
            if (completion) {
                completion(XPAY_INVALID,@"调起银联支付错误，没有银联这个渠道");
            }
            return NO;
        }
    }
    
    return YES;
}
@end
