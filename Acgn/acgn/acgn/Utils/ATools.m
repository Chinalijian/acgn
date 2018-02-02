//
//  ATools.h
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//


#import "ATools.h"

@implementation ATools

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
//    [SVProgressHUD setForegroundColor:DMColorWithRGBA(254, 254, 254, 1)]; //字体颜色
//    [SVProgressHUD setBackgroundColor:DMColorWithRGBA(0, 0, 0, 0.6)];//背景颜色
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
@end





