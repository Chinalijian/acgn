//
//  PeopleDetailCell.m
//  acgn
//
//  Created by Ares on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "PeopleDetailCell.h"
#import "ImageCom.h"

#define Space_Bottom_Cell 32
#define Button_View_ 25

#define Time_Width 70
#define TypeButton_W 30.5

#define Space_Right_Cell 24
#define Space_Left_View 13

#define Space_Content_ 10

#define Content_With (DMScreenWidth-Space_Right_Cell-Space_Left_View-TypeButton_W-Space_Left_View-Time_Width)

@interface PeopleDetailCell ()

@property (nonatomic, strong) UILabel *bigTimeLabel;
@property (nonatomic, strong) UILabel *smallTimeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *seeNumButton;
@property (nonatomic, strong) UIButton *commitNumButton;
@property (nonatomic, strong) UIButton *praiseNumButton;

@property (nonatomic, strong) ImageCom *imageCom;

@end

@implementation PeopleDetailCell
+ (CGFloat)getPeopleDetailCellHeight {
    
    return 0;
}
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

- (void)loadUI {
    [self addSubview:self.bigTimeLabel];
    [self addSubview:self.smallTimeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.typeImageView];
    [self addSubview:self.lineLabel];
    [self addSubview:self.buttonView];
    [self.buttonView addSubview:self.seeNumButton];
    [self.buttonView addSubview:self.commitNumButton];
    [self.buttonView addSubview:self.praiseNumButton];
    
    [self setupMakeBodyViewSubViewsLayout];
}

- (void)setupMakeBodyViewSubViewsLayout {
    [self.bigTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(0);
        make.width.mas_offset(Time_Width);
        make.height.mas_offset(28);
    }];
    [self.smallTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bigTimeLabel.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(0);
        make.width.mas_offset(Time_Width);
        make.height.mas_offset(12);
    }];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(0);
        make.left.mas_equalTo(self.bigTimeLabel.mas_right).mas_offset(13);
        make.width.mas_offset(TypeButton_W);
        make.height.mas_offset(TypeButton_W);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeImageView.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(self.typeImageView);
        make.bottom.mas_equalTo(self).mas_offset(0);
        make.width.mas_offset(0.5);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bigTimeLabel.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.typeImageView.mas_right).mas_offset(Space_Left_View);
        make.height.mas_offset(0);
        make.width.mas_offset(Content_With);
    }];
    [self.imageCom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(Space_Content_);
        make.left.mas_equalTo(self.contentLabel.mas_right).mas_offset(0);
        make.height.mas_offset(0);
        make.width.mas_offset(Content_With);
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-Space_Bottom_Cell);
        make.left.mas_equalTo(self.contentLabel.mas_right).mas_offset(0);
        make.height.mas_offset(Button_View_);
        make.width.mas_offset(Content_With);
    }];
    
    [self.seeNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.buttonView).mas_offset(0);
        make.left.mas_equalTo(self.buttonView).mas_offset(0);
        make.top.mas_equalTo(self.buttonView).mas_offset(0);
        make.width.mas_offset(Content_With/3);
    }];
    [self.commitNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.buttonView).mas_offset(0);
        make.centerX.mas_equalTo(self.buttonView);
        make.top.mas_equalTo(self.buttonView).mas_offset(0);
        make.width.mas_offset(Content_With/3);
    }];
    [self.praiseNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.buttonView).mas_offset(0);
        make.left.mas_equalTo(self.buttonView).mas_offset(0);
        make.top.mas_equalTo(self.buttonView).mas_offset(0);
        make.width.mas_offset(Content_With/3);
    }];
    
}

- (UILabel *)bigTimeLabel {
    if (_bigTimeLabel == nil) {
        _bigTimeLabel = [[UILabel alloc] init];
        _bigTimeLabel.text = @"";
        _bigTimeLabel.textAlignment = NSTextAlignmentLeft;
        _bigTimeLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _bigTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bigTimeLabel;
}
- (UILabel *)smallTimeLabel {
    if (_smallTimeLabel == nil) {
        _smallTimeLabel = [[UILabel alloc] init];
        _smallTimeLabel.text = @"";
        _smallTimeLabel.textAlignment = NSTextAlignmentLeft;
        _smallTimeLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _smallTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _smallTimeLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"";
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}
- (UILabel *)lineLabel {
    if (_lineLabel == nil) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.text = @"";
        _lineLabel.textAlignment = NSTextAlignmentLeft;
        _lineLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _lineLabel.font = [UIFont systemFontOfSize:12];
    }
    return _lineLabel;
}

- (UIImageView *)typeImageView {
    if (_typeImageView == nil) {
        _typeImageView = [[UIImageView alloc] init];
        _typeImageView.clipsToBounds = YES;
        _typeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _typeImageView.backgroundColor = [UIColor clearColor];
        _typeImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        tap.numberOfTapsRequired =1;
//        tap.numberOfTouchesRequired =1;
//        [_typeImageView addGestureRecognizer:tap];
    }
    return _typeImageView;
}

- (UIView *)buttonView {
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc] init];
    }
    return _buttonView;
}

- (UIButton *)seeNumButton {
    if (_seeNumButton == nil) {
        _seeNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_seeNumButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_seeNumButton setImage:[UIImage imageNamed:@"praise_yellow_icon"] forState:UIControlStateNormal];
        [_seeNumButton setTitle:@"粉丝：2234" forState:UIControlStateNormal];
        _seeNumButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _seeNumButton;
}
- (UIButton *)commitNumButton {
    if (_commitNumButton == nil) {
        _commitNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitNumButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_commitNumButton setImage:[UIImage imageNamed:@"praise_yellow_icon"] forState:UIControlStateNormal];
        [_commitNumButton setTitle:@"粉丝：2234" forState:UIControlStateNormal];
        _commitNumButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _commitNumButton;
}
- (UIButton *)praiseNumButton {
    if (_praiseNumButton == nil) {
        _praiseNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_praiseNumButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_praiseNumButton setImage:[UIImage imageNamed:@"praise_yellow_icon"] forState:UIControlStateNormal];
        [_praiseNumButton setTitle:@"粉丝：2234" forState:UIControlStateNormal];
        _praiseNumButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _praiseNumButton;
}


@end
