//
//  ATools.h
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATools : NSObject
+ (NSString*)MD5:(NSString*)s;
//按钮图片在上，文字再下
+ (void)setButtonContentCenter:(UIButton *)btn;
//计算文字宽度
+(CGFloat)getContactWidth:(NSString*)contact font:(UIFont *)font height:(CGFloat)height;
//成功提示框
+(void)showSVProgressHudCustom:(NSString *)imageName title:(NSString *)title;
@end






