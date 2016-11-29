

//
//  XPayTool.m
//  XPayTool
//
//  Created by xayoung on 16/11/29.
//  Copyright © 2016年 xayoung. All rights reserved.
//

#import "XPayTool.h"
@implementation XPayTool
#pragma mark - check String is Empty
+ (BOOL)isEmpty:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]])
        string = [string description];
    if (string == nil || string == NULL)
        return YES;
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        return YES;
    if ([string isEqualToString:@"(null)"])
        return YES;
    if ([string isEqualToString:@"(null)(null)"])
        return YES;
    if ([string isEqualToString:@"<null>"])
        return YES;
    
    // return Default
    return NO;
}



@end
