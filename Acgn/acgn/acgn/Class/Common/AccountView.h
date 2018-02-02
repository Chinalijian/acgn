//
//  AccountView.h
//  acgn
//
//  Created by Ares on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *aTableView;
- (id)initWithFrame:(CGRect)frame type:(AAccountType)type;
@end
