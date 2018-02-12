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

//适配iPhone X 顶部与顶部的间距
+ (CGFloat)setViewFrameYForIPhoneX:(CGFloat)y;
+ (CGFloat)setViewFrameBottomForIPhoneX:(CGFloat)b;
+ (CGFloat)setViewFrameHeightToBottomForIPhoneX:(CGFloat)b;
//获取Label的高度，根据文字
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
+ (NSMutableAttributedString *)colerString:(NSString *)sourceStr allStr:(NSString *)allStr color:(UIColor *)color font:(UIFont *)font;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end






