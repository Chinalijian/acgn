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
@property (nonatomic, strong) AccountLocalDataModel *obje;
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

- (void)configInfo:(AccountLocalDataModel *)obj {
    self.obje = obj;
    self.titleImageView.image = [UIImage imageNamed:obj.titleImage];
    self.contentTextField.placeholder = obj.placeholder;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.obje.content = textField.text;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //self.clickTextFieldBlock(YES);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.obje.content = textField.text;
    //self.clickTextFieldBlock(NO);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

#pragma mark - UI
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
        make.top.mas_equalTo(self.bgView).mas_offset((44-30.5)/2);
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        //make.centerX.mas_equalTo(self.bgView);
        make.width.mas_equalTo(30.5);
        make.height.mas_equalTo(30.5);
    }];
    
    [_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleImageView).mas_offset(0);
        make.left.mas_equalTo(_titleImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.bgView).mas_offset(-20);
        make.bottom.mas_equalTo(_titleImageView).mas_offset(0);
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
- (UIImageView *)titleImageView {
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.clipsToBounds = YES;
        _titleImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _titleImageView;
}
- (UITextField *)contentTextField {
    if (_contentTextField == nil) {
        _contentTextField = [[UITextField alloc] init];
        _contentTextField.textColor = [UIColor blackColor];
        _contentTextField.font = [UIFont systemFontOfSize:14];
        _contentTextField.textAlignment = NSTextAlignmentLeft;
        _contentTextField.delegate = self;
        [_contentTextField setValue:UIColorFromRGB(0x808080) forKeyPath:@"_placeholderLabel.textColor"];
        [_contentTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return _contentTextField;
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
