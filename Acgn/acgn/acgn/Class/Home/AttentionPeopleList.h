//
//  AttentionPeopleList.h
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AttentionPeopleListDelegate <NSObject>
- (void)clickAttentButton:(id)sender;
@end

@interface AttentionPeopleList : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, weak) id <AttentionPeopleListDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *datas;
- (id)initWithFrame:(CGRect)frame delegate:(id<AttentionPeopleListDelegate>) delegate;
@end
