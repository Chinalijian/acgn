//
//  AccountCell.m
//  acgn
//
//  Created by Ares on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AccountCell.h"

@interface AccountCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UITextField *contentTextField;
@end
#define X_SPACE 47
@implementation AccountCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        [self loadUI];
    }
    return self;
}

- (void)configInfo:(NSString *)imageName placeholders:(NSString *)placeholderName {
    self.titleImageView.image = [UIImage imageNamed:imageName];
    self.contentTextField.placeholder = placeholderName;
}


- (void)loadUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleImageView];
    [self.bgView addSubview:self.contentTextField];
    [self setupMakeBodyViewSubViewsLayout];
}

- (void)setupMakeBodyViewSubViewsLayout {
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(15);
        make.left.mas_equalTo(self).mas_offset(X_SPACE);
        make.right.mas_equalTo(self).mas_offset(-X_SPACE);
        make.height.mas_equalTo(44);
    }];
    
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.centerX.mas_equalTo(self.bgView);
        make.width.mas_equalTo(30.5);
        make.height.mas_equalTo(30.5);
    }];
    
    [_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.bgView).mas_offset(-10);
        make.centerX.mas_equalTo(self.bgView);
    }];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 15;
        _bgView.layer.borderColor = UIColorFromRGB(0xBAB8B9).CGColor;
        _bgView.layer.borderWidth = .5;
    }
    return _bgView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
