//
//  AttentionPeopleList.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AttentionPeopleList.h"

@interface AttentionPeopleList ()
@property (nonatomic, strong) UIButton *attBtn;
@end

@implementation AttentionPeopleList

- (id)initWithFrame:(CGRect)frame delegate:(id<AttentionPeopleListDelegate>) delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self loadUI];
    }
    return self;
}

- (void)clickAttentButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickAttentButton:)]) {
        [self.delegate clickAttentButton:sender];
    }
}

- (void)loadUI {
    [self addSubview:self.attBtn];
    [self setupMakeLayoutSubviews];
}

- (void)setupMakeLayoutSubviews {
    [_attBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(94/2);
        make.right.mas_equalTo(self).mas_offset(-94/2);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-15);
        make.height.mas_equalTo(44);
    }];
}

- (UIButton *)attBtn {
    if (_attBtn == nil) {
        _attBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attBtn setTitle:@"关注他们" forState:UIControlStateNormal];
        [_attBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attBtn.backgroundColor = UIColorFromRGB(0xE96A79);
        _attBtn.layer.cornerRadius = 15;
        [_attBtn addTarget:self action:@selector(clickAttentButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attBtn;
}


@end
