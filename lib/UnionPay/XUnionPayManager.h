//
//  XUnionPayManager.h
//  XPay
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "XPay.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XUnionPayManager : NSObject
/**
 *
 *  银联支付单例
 *
 */

+ (instancetype)manager;
/**
 *  调起银联支付
 *
 *  @param orderDic       签名信息字典
 *  @param viewController 调起支付的视图控制器
 *  @param completion     支付结果回调
 */
- (void)unionPayWithOrderDic:(NSDictionary *)orderDic viewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion;

@end
