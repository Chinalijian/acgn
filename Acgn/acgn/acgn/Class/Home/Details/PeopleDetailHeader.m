//
//  PeopleDetailHeader.m
//  acgn
//
//  Created by Ares on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "PeopleDetailHeader.h"
#import "ImageCom.h"
@interface PeopleDetailHeader()
@property (nonatomic, strong) RoleDetailsDataModel *dynamicObj;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *peopleImageView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIButton *attButton;
@property (nonatomic, strong) UIButton *fansButton;

@property (nonatomic, strong) UIButton *image3DButton;

@end

@implementation PeopleDetailHeader

#define Space_Left_X 16

#define Name_Space_Y 40
#define Name_Label_H 18
#define Source_Label_Space_Y 14
#define Source_Label_H 14
#define Introduce_Label_Space_Y 12
//#define Introduce_Label_W 196
#define Introduce_Label_Width DMScreenWidth-Space_Left_X*2-PeopleImage_Width

#define PeopleImage_Height 186.5
#define PeopleImage_Width  138.5

#define Total_Default_Height 216.5

#define BottomView_H 34

+ (CGFloat)getViewTotalHeight:(RoleDetailsDataModel *)obj {
    CGFloat totalHeight = 0;
    CGFloat indtroduceHeight = [PeopleDetailHeader getIntroduceMaxHeight:obj];
    totalHeight = indtroduceHeight + Name_Space_Y + Name_Label_H + Source_Label_Space_Y + Source_Label_H + Introduce_Label_Space_Y*2 + BottomView_H;
    if (totalHeight < Total_Default_Height) {
        totalHeight = Total_Default_Height;
    }
    return totalHeight;
}

+ (CGFloat)getIntroduceMaxHeight:(RoleDetailsDataModel *)obj {
    if (OBJ_IS_NIL(obj)) {
        return 0;
    }
    return [ATools getHeightByWidth:Introduce_Label_Width title:obj.introduce font:Commit_Font];
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(clickSelectPeopleImage:)]) {
        [self.delegate clickSelectPeopleImage:self.dynamicObj.roleId];
    }
}

- (void)configInfo:(RoleDetailsDataModel *)obj {
    self.dynamicObj = obj;
    self.nameLabel.text = obj.userName;
    self.sourceLabel.text = obj.source;
    self.introduceLabel.text = obj.introduce;
    [ATools changeLineSpaceForLabel:self.introduceLabel WithSpace:5];
    NSString * imageUrl = [obj.imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.peopleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    if (obj.hasFollow.intValue >= 1) {
        [self.attButton setTitle:@"已关注" forState:UIControlStateNormal];
    } else {
        [self.attButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    [self.fansButton setTitle:[NSString stringWithFormat:@"粉丝：%@", obj.fansNum] forState:UIControlStateNormal];
    [self layoutSubviews];
}

- (id)initWithframe:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.sourceLabel];
    [self addSubview:self.introduceLabel];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.attButton];
    [self.bottomView addSubview:self.fansButton];
    [self addSubview:self.peopleImageView];
    [self addSubview:self.image3DButton];
    
    [self setupTopContentLayout];
}

- (void)setupTopContentLayout {
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Name_Space_Y);
        make.height.mas_offset(Name_Label_H);
        make.left.mas_equalTo(self).mas_offset(Space_Left_X);
        make.width.mas_offset(Introduce_Label_Width);
    }];
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Source_Label_Space_Y);
        make.height.mas_offset(Source_Label_H);
        make.left.mas_equalTo(self.nameLabel).mas_offset(0);
        make.right.mas_equalTo(self.nameLabel).mas_offset(0);
    }];
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sourceLabel.mas_bottom).mas_offset(Introduce_Label_Space_Y);
        make.height.mas_offset(0);
        make.left.mas_equalTo(self.nameLabel).mas_offset(0);
        make.right.mas_equalTo(self.nameLabel).mas_offset(0);
    }];
    
    [self setupMakeBottomSubViewsLayout];
    
    [_peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.height.mas_offset(PeopleImage_Height);
        make.width.mas_offset(PeopleImage_Width);
    }];
    
    [_image3DButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        make.right.mas_equalTo(self).mas_offset(-13);
        make.height.mas_offset(22);
        make.width.mas_offset(82);
    }];
    
}

- (void)setupMakeBottomSubViewsLayout {
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(0);
        make.right.mas_equalTo(self).mas_offset(0);
        make.height.mas_offset(BottomView_H);
    }];
    [_alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView).mas_offset(0);
        make.top.mas_equalTo(self.bottomView).mas_offset(0);
        make.left.mas_equalTo(self.bottomView).mas_offset(0);
        make.right.mas_equalTo(self.bottomView).mas_offset(0);
    }];
    [_attButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).mas_offset(-5);
        make.top.mas_equalTo(self.bottomView).mas_offset(5);
        make.left.mas_equalTo(self.bottomView).mas_offset(Space_Left_X);
        make.width.mas_offset(44);
    }];
    [_fansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.attButton).mas_offset(0);
        make.top.mas_equalTo(self.attButton).mas_offset(0);
        make.left.mas_equalTo(self.attButton).mas_offset(Space_Left_X);
        make.width.mas_offset(90);
    }];
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = UIColorFromRGB(0xFFFFF);
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}
- (UILabel *)sourceLabel {
    if (_sourceLabel == nil) {
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.text = @"";
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _sourceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _sourceLabel;
}
- (UILabel *)introduceLabel {
    if (_introduceLabel == nil) {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.text = @"";
        _introduceLabel.textAlignment = NSTextAlignmentLeft;
        _introduceLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _introduceLabel.font = [UIFont systemFontOfSize:13];
//        _introduceLabel.lineBreakMode = NSLineBreakByCharWrapping;
//        _introduceLabel.numberOfLines = 3;
    }
    return _introduceLabel;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}
- (UIView *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor whiteColor];
        _alphaView.alpha = .1;
    }
    return _alphaView;
}
- (UIButton *)attButton {
    if (_attButton == nil) {
        _attButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_attButton setBackgroundColor: UIColorFromRGB(0xE96A79)];
        [_attButton setTitle:@"关注" forState:UIControlStateNormal];
        _attButton.layer.cornerRadius = 8;
//        _attButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _attButton;
}
- (UIButton *)fansButton {
    if (_fansButton == nil) {
        _fansButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fansButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fansButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_fansButton setImage:[UIImage imageNamed:@"praise_yellow_icon"] forState:UIControlStateNormal];
        [_fansButton setTitle:@"粉丝：2234" forState:UIControlStateNormal];
        _fansButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _fansButton;
}


- (UIImageView *)peopleImageView {
    if (_peopleImageView == nil) {
        _peopleImageView = [[UIImageView alloc] init];
        _peopleImageView.clipsToBounds = YES;
        _peopleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _peopleImageView.backgroundColor = [UIColor clearColor];
        _peopleImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired =1;
        tap.numberOfTouchesRequired =1;
        [_peopleImageView addGestureRecognizer:tap];
    }
    return _peopleImageView;
}

- (UIButton *)image3DButton {
    if (_image3DButton == nil) {
        _image3DButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_image3DButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_image3DButton setTitle:@"立体形象" forState:UIControlStateNormal];
        [_image3DButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_image3DButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _image3DButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _image3DButton;
}


@end
