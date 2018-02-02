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
@end





