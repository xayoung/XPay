//
//  XPAY.h
//  XPAY
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  支付类型
 */
typedef NS_ENUM(NSInteger, XPayType) {
    XPayType_ALIPAY = 1,
    XPayType_WX,
    XPayType_UNION
};
/**
 *  支付状态
 */
typedef NS_ENUM(NSInteger, XPayResultStatus) {
    /**
     *  支付成功
     */
    XPAY_SUCCESS    = 100,
    /**
     *  支付确认中
     */
    XPAY_PENDING    = 101,
    /**
     *  支付取消
     */
    XPAY_CANCELED   = 102,
    /**
     *  支付失败
     */
    XPAY_FAILED     = 103,
    /**
     *  调起支付错误
     */
    XPAY_INVALID    = 104
};

/**
 *  支付结果回调
 *
 *  @param status 支付结果状态
 *  @param msg    支付结果
 */

typedef void(^XPayCompletion) (XPayResultStatus status, NSString *msg);

@interface XPay : NSObject


/**
 * 支付单例
 */

+ (instancetype)manager;

/**
 *  调用支付
 *  @param orderDic        订单信息字典
 *  @param type            支付类型
 *  @param scheme          调用支付的app注册在info.plist中的scheme(支付宝)
 *  @param completion      支付回调结果
 *  @param viewController  调用银联(必传)时传入调起支付的控制器，支付宝和微信直接传入nil即可
 
 ---- AliPay--orderDic ----
 * sign    订单字符串签名（服务端下发）
 
 ---- WxPay--orderDic -----
 
 * appId   微信平台注册生成的appkey
 * PayReq  相关的各个属性(服务端下发)
 ---- UnionPay--orderDic -----
 * sign    订单字符串签名 （服务端下发）
 */

- (void)payWithOrderDic:(NSDictionary *)orderDic  withType:(XPayType)type withScheme:(NSString *)scheme withViewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion;

/**
 *  微信或支付宝通过微信启动app
 *
 */
- (void)handleOpenWithURL:(NSURL *)url withComletion:(XPayCompletion)completion;

@end
