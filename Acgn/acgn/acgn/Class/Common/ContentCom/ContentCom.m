//
//  ContentCom.m
//  acgn
//
//  Created by lijian on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "ContentCom.h"

@interface ContentCom()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) ImageCom *imageComView;
@property (nonatomic, strong) UIImageView *peopleImageView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *attButton;
@property (nonatomic, strong) UIButton *comButton;
@property (nonatomic, strong) UIButton *praButton;
@property (nonatomic, strong) UIButton *favButton;

@end

@implementation ContentCom
#define Space_Left_X 16
#define Space_Y 16
#define Label_Space_Y 8.5

#define Name_Label_H 18
#define Time_Label_H 16
#define From_Label_H 16

#define Content_Label_Space_Y 26

#define Image_Space 8
#define BottomView_H 34

#define PeopleImage_Height 186.5
#define PeopleImage_Width  138.5

- (CGFloat)getConstHeight:(CGFloat)contentH imageHeight:(CGFloat)imageH {
    CGFloat H = contentH + imageH + Name_Label_H+Time_Label_H+From_Label_H + Space_Y + Label_Space_Y*2 + Image_Space*2 + BottomView_H;
    if (H <= PeopleImage_Height) {
       H = H + 20;
    }
    return H;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
                        frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}


- (void)loadUI {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.fromLabel];
    [self addSubview:self.contentLabel];
    
    [self addSubview:self.imageComView];
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.attButton];
    [self.bottomView addSubview:self.comButton];
    [self.bottomView addSubview:self.praButton];
    [self.bottomView addSubview:self.favButton];
    
    [self addSubview:self.peopleImageView];
}

- (void)setupTopContentLayout {

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Space_Y);
        make.centerX.mas_equalTo(self);
        make.height.mas_offset(Name_Label_H);
        make.left.mas_equalTo(self).mas_offset(Space_Left_X);
        make.right.mas_equalTo(self).mas_offset(-Space_Left_X);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Label_Space_Y);
        make.centerX.mas_equalTo(self);
        make.height.mas_offset(Time_Label_H);
        make.left.mas_equalTo(self.nameLabel).mas_offset(0);
        make.right.mas_equalTo(self.nameLabel).mas_offset(0);
    }];
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Label_Space_Y);
        make.centerX.mas_equalTo(self);
        make.height.mas_offset(From_Label_H);
        make.left.mas_equalTo(self.timeLabel).mas_offset(0);
        make.right.mas_equalTo(self.timeLabel).mas_offset(0);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fromLabel.mas_bottom).mas_offset(Content_Label_Space_Y);
        make.left.mas_equalTo(self.fromLabel).mas_offset(0);
        make.right.mas_equalTo(self.timeLabel).mas_offset((DMScreenWidth-Space_Left_X)/2);
        make.height.mas_offset(72);
    }];
    
    [self setupMakeBottomSubViewsLayout];
    
    [_peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_offset(PeopleImage_Height);
        make.width.mas_offset(PeopleImage_Width);
    }];
    
}

- (void)setupMakeBottomSubViewsLayout {
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(0);
        make.height.mas_offset(BottomView_H);
    }];
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = UIColorFromRGB(0xE98A79);
        _nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = UIColorFromRGB(0x000000);
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"";
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = UIColorFromRGB(0x000000);
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.lineBreakMode = NSLineBreakByClipping;
        _contentLabel.numberOfLines = 3;
    }
    return _contentLabel;
}
- (UILabel *)fromLabel {
    if (_fromLabel == nil) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.text = @"";
        _fromLabel.textAlignment = NSTextAlignmentLeft;
        _fromLabel.textColor = UIColorFromRGB(0x000000);
        _fromLabel.font = [UIFont systemFontOfSize:12];
    }
    return _fromLabel;
}

- (ImageCom *)imageComView {
    if (_imageComView == nil) {
        _imageComView = [[ImageCom alloc] init];
    }
    return _imageComView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}
- (UIButton *)attButton {
    if (_attButton == nil) {
        _attButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _attButton;
}
- (UIButton *)comButton {
    if (_comButton == nil) {
        _comButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _comButton;
}
- (UIButton *)praButton {
    if (_praButton == nil) {
        _praButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _praButton;
}

- (UIImageView *)peopleImageView {
    if (_peopleImageView == nil) {
        _peopleImageView = [[UIImageView alloc] init];
    }
    return _peopleImageView;
}

- (UIButton *)favButton {
    if (_favButton == nil) {
        _favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _favButton;
}

@end

















































