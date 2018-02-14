//
//  ATools.h
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//


#import "ATools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation ATools

+ (NSString*)MD5:(NSString*)s
{
    // Create pointer to the string as UTF8
    const char *ptr = [s UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
   
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

//按钮图片在上，文字再下
+ (void)setButtonContentCenter:(UIButton *)btn {
    
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 10.0f;
    //设置按钮内边距
    imgViewSize = btn.imageView.bounds.size;
    titleSize = btn.titleLabel.bounds.size;
    btnSize = btn.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(-heightSpace, 0.0, btnSize.height-imgViewSize.height-heightSpace, -titleSize.width);
    [btn setImageEdgeInsets:imageViewEdge];
    titleEdge = UIEdgeInsetsMake(imgViewSize.height+heightSpace, -imgViewSize.width, 0.0, 0.0);
    [btn setTitleEdgeInsets:titleEdge];
}
//计算文字宽度
+(CGFloat)getContactWidth:(NSString*)contact font:(UIFont *)font height:(CGFloat)height {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);
    // 计算文字占据的高度
    CGSize size = [contact boundingRectWithSize:maxSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attrs
                                        context:nil].size;
    
    
    return size.width;
    
}
//成功提示框
+(void)showSVProgressHudCustom:(NSString *)imageName title:(NSString *)title {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];//背景颜色
    [SVProgressHUD setCornerRadius:5];
    
    if (!STR_IS_NIL(imageName)) {
        
        [SVProgressHUD setMinimumSize:CGSizeMake(130, 130)];
        [SVProgressHUD setFont:DMFontPingFang_Regular(16)];
        [SVProgressHUD setImageViewSize:CGSizeMake(62, 62)];
        
    } else {
        
        NSInteger w = [ATools getContactWidth:title font:DMFontPingFang_Regular(18) height:25];
        NSInteger h = 65;
        if (w <= 72) {
            w = 146;
        } else if (w > 200) {
            w = 276;
            h = 95;
        } else {
            w = w+80;
        }
        [SVProgressHUD setMinimumSize:CGSizeMake(w, h)];
        [SVProgressHUD setFont:DMFontPingFang_Regular(18)];
        [SVProgressHUD setImageViewSize:CGSizeMake(0, 0)];
        [SVProgressHUD setRingRadius:40];
        
    }
    [SVProgressHUD showImage:[UIImage imageNamed:imageName] status:title];
}

+ (CGFloat)setViewFrameYForIPhoneX:(CGFloat)y {
    CGFloat H = y;
    if (IS_IPHONE_X) {
        H = H + 20;
    }
    return H;
}
+ (CGFloat)setViewFrameBottomForIPhoneX:(CGFloat)b {
    CGFloat B = b;
    if (IS_IPHONE_X) {
        B = B + 44;
    }
    return B;
}

+ (CGFloat)setViewFrameHeightToBottomForIPhoneX:(CGFloat)b {
    CGFloat B = b;
    if (IS_IPHONE_X) {
        B = B - 44;
    }
    return B;
}

//获取Label的高度和宽度，根据文字
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

//获取Label的高度和宽度，根据文字
+ (CGFloat)getHeightByHeight:(CGFloat)height title:(NSString *)title font:(UIFont*)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat width1 = label.frame.size.width;
    return width1;
}

+ (NSMutableAttributedString *)colerString:(NSString *)sourceStr allStr:(NSString *)allStr color:(UIColor *)color font:(UIFont *)font {
    NSString *colorString = sourceStr;
    NSString *textString = allStr;
    UIColor *colorStr = color;
    UIFont *fontStr = font;
    NSRange strRange = [textString rangeOfString:colorString];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributeString setAttributes:@{NSFontAttributeName: fontStr, NSForegroundColorAttributeName: colorStr} range:strRange];
    return attributeString;
}
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
@end
























