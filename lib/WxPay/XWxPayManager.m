


//
//  XWxPayManager.m
//  XPay
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "XWxPayManager.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "XPayTool.h"
static XWxPayManager *manager  = nil;

static XPayCompletion openCompletion;
static XPayCompletion payCompletion;

@interface XWxPayManager ()<WXApiDelegate>

@end
@implementation XWxPayManager

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XWxPayManager alloc] init];
        
    });
    return manager;
}

- (void)wxPayWithOrderDic:(NSDictionary *)orderDic  withCompletion:(XPayCompletion)completion
{
    //appkey
    NSString *appId = [orderDic objectForKey:@"appId"];
    if ([XPayTool isEmpty:appId]) {
        if (completion) {
            completion(XPAY_INVALID,@"微信调起支付错误,字典中缺少微信平台注册得到的appId");
        }
        return;
    }
    //注册
    [WXApi registerApp:appId];
    
    
    PayReq *payReq= [[PayReq alloc]  init];
    payReq.partnerId = [orderDic objectForKey:@"partnerId"]?:@"";
    payReq.prepayId = [orderDic objectForKey:@"prepayId"]?:@"";
    payReq.nonceStr =[orderDic objectForKey:@"nonceStr"]?:@"";
    payReq.timeStamp = [[orderDic objectForKey:@"timeStamp"] intValue]?:0;
    payReq.package = @"Sign=WXPay";
    payReq.sign = [orderDic objectForKey:@"sign"]?:@"";
    [WXApi sendReq:payReq];
    payCompletion = completion;
}


- (void)handleOpenURL:(NSURL *)url withCompletion:(XPayCompletion)completion
{
    [WXApi handleOpenURL:url delegate:[XWxPayManager manager]];
    
    openCompletion = completion;
}

#pragma mark -- 微信的回调信息
- (void)onResp:(BaseResp *)resp
{
   
    if ([resp isKindOfClass:[PayResp class]]) {
        XPayResultStatus status = 0;
        NSString *msg;
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                status = XPAY_SUCCESS;
                msg   = @"微信支付成功";
                break;
            case -1:
                status = XPAY_FAILED;
                msg   = @"微信支付失败";
                break;
            case -2:
                status = XPAY_CANCELED;
                msg   = @"微信支付取消";
                break;
            default:
                status = XPAY_FAILED;
                msg   = @"微信支付失败";
                break;
                
                
     }
        
        if (payCompletion) {
            payCompletion(status,msg);
        }
        
        if (openCompletion) {
            openCompletion(status,msg);
        }

}
        
}
@end
