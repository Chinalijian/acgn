//
//  EmptyView.h
//  acgn
//
//  Created by Ares on 2018/2/12.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EmptyViewDelegate <NSObject>
@optional
- (void)clickEmptyButton:(id)sender;
@end
@interface EmptyView : UIView
@property (nonatomic, weak) id <EmptyViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame delegate:(id<EmptyViewDelegate>) delegate;
- (void)updateInfo:(NSString *)imageName title:(NSString *)title btnTitle:(NSString *)btnTitle;
@end
