//
//  XWxPayManager.h
//  XPay
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPay.h"
@interface XWxPayManager : NSObject
/**
 *  微信支付单例
 *
 */
+ (instancetype)manager;

/**
 *  调起微信支付
 *
 *  @param orderDic   订单相关信息
 *  @param scheme     回调本应用的scheme
 *  @param completion 支付结果回调
 */
- (void)wxPayWithOrderDic:(NSDictionary *)orderDic  withCompletion:(XPayCompletion)completion;
/*
  处理微信通过URL启动App时传递的数据
* 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
* @param url 微信启动第三方应用时传递过来的URL
* @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
*/
- (void)handleOpenURL:(NSURL *)url withCompletion:(XPayCompletion)completion;

@end
