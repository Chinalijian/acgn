//
//  SendMsgInputTextView.h
//  acgn
//
//  Created by Ares on 2018/2/12.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  使用 直接初始化，也可以改属性
 WJEasyInputTextView *wj = [[WJEasyInputTextView alloc]init];
 wj.bgColor = [UIColor orangeColor];
 wj.showLimitNum = YES;
 wj.font = [UIFont systemFontOfSize:18];
 wj.limitNum = 13;
 [self.view addSubview:wj];
 */
@interface SendMsgInputTextView : UIView
@property (nonatomic,strong)UIColor *bgColor;   //背景色
@property (nonatomic,assign)BOOL showLimitNum; //显示字数
@property (nonatomic,assign)NSInteger limitNum; //限制字数
@property (nonatomic,strong)UIFont *font;       //文字大小
@end
