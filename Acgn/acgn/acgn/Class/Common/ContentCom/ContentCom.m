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
@property (nonatomic, strong) UIView *alphaView;
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
#define Time_Label_H 14
#define From_Label_H 14

#define PeopleImage_Height 186.5
#define PeopleImage_Width  138.5

#define Content_Label_Space_Y 16
#define Content_Label_Widht DMScreenWidth-Space_Left_X*2-PeopleImage_Width

#define Image_Space 8
#define BottomView_H 34

+ (CGFloat)getContentCommonCellHeight:(DynamicListData *)obj {
    CGFloat totalHeight = 0;
    CGFloat imageH = [ContentCom getImageMaxHeight:obj];
    CGFloat contentH = [ContentCom getContentMaxHeight:obj];
    totalHeight =  contentH + imageH + Name_Label_H+Time_Label_H+From_Label_H + Space_Y + Label_Space_Y*2 + Image_Space*2 + BottomView_H;
    if (totalHeight <= PeopleImage_Height) {
        totalHeight = totalHeight + 20;
    }
    return totalHeight;
}

+ (CGFloat)getImageMaxHeight:(DynamicListData *)obj {
    if (obj.postUrls.count == 1) {
        NSString *url = [obj.postUrls firstObject];
        
    } else {
        
    }
    return 124;
}

+ (CGFloat)getContentMaxHeight:(DynamicListData *)obj {
    if (OBJ_IS_NIL(obj)) {
        return 0;
    }
    return [ATools getHeightByWidth:Content_Label_Widht title:obj.postContext font:Commit_Font];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
                        frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (void)configInfo:(DynamicListData *)obj {
    
    self.nameLabel.text = obj.userName;
    self.timeLabel.text = obj.postTime;
    self.fromLabel.text = obj.postSource;
    self.contentLabel.text = obj.postContext;
    [ATools changeLineSpaceForLabel:self.contentLabel WithSpace:5];
    [self.peopleImageView sd_setImageWithURL:[NSURL URLWithString:obj.imageUrl] placeholderImage:nil];
    [self.attButton setTitle:obj.seeNum forState:UIControlStateNormal];
    [self.comButton setTitle:obj.commentNum forState:UIControlStateNormal];
    [self.praButton setTitle:obj.fabulousNum forState:UIControlStateNormal];
    
//    CGFloat HH = [ContentCom getContentCommonCellHeight:obj];
//    self.frame = CGRectMake(0, 0, self.bounds.size.width, HH);
    
//    CGRect rect = self.frame;
//    rect.size.height = [ContentCom getContentCommonCellHeight:obj];
//    self.frame = rect;
//
}

- (void)loadUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.fromLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentView addSubview:self.imageComView];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.alphaView];
    [self.bottomView addSubview:self.attButton];
    [self.bottomView addSubview:self.comButton];
    [self.bottomView addSubview:self.praButton];
    [self.bottomView addSubview:self.favButton];
    
    [self.contentView addSubview:self.peopleImageView];
    [self setupTopContentLayout];
}

- (void)setupTopContentLayout {

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(Space_Y);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_offset(Name_Label_H);
        make.left.mas_equalTo(self.contentView).mas_offset(Space_Left_X);
        make.right.mas_equalTo(self.contentView).mas_offset(-Space_Left_X);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Label_Space_Y);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_offset(Time_Label_H);
        make.left.mas_equalTo(self.nameLabel).mas_offset(0);
        make.right.mas_equalTo(self.nameLabel).mas_offset(0);
    }];
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(Label_Space_Y-4);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_offset(From_Label_H);
        make.left.mas_equalTo(self.timeLabel).mas_offset(0);
        make.right.mas_equalTo(self.timeLabel).mas_offset(0);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fromLabel.mas_bottom).mas_offset(Content_Label_Space_Y);
        make.left.mas_equalTo(self.fromLabel).mas_offset(0);
        make.width.mas_offset(Content_Label_Widht);
        make.height.mas_offset(72);
    }];
    
    [self setupMakeBottomSubViewsLayout];
    
    [_peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
        make.height.mas_offset(PeopleImage_Height);
        make.width.mas_offset(PeopleImage_Width);
    }];
    
}

- (void)setupMakeBottomSubViewsLayout {
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_offset(0);
        make.left.mas_equalTo(self.contentView).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_offset(BottomView_H);
    }];
    [_alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView).mas_offset(0);
        make.top.mas_equalTo(self.bottomView).mas_offset(0);
        make.left.mas_equalTo(self.bottomView).mas_offset(0);
        make.right.mas_equalTo(self.bottomView).mas_offset(0);
    }];
    CGFloat width = (DMScreenWidth-PeopleImage_Width-Space_Left_X*2)/3;
    [_attButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView).mas_offset(0);
        make.top.mas_equalTo(self.bottomView).mas_offset(0);
        make.left.mas_equalTo(self.bottomView).mas_offset(Space_Left_X);
        make.width.mas_offset(width);
    }];
    [_comButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.attButton).mas_offset(0);
        make.top.mas_equalTo(self.attButton).mas_offset(0);
        make.left.mas_equalTo(self.attButton.mas_right).mas_offset(0);
        make.width.mas_offset(width);
    }];
    [_praButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.comButton).mas_offset(0);
        make.top.mas_equalTo(self.comButton).mas_offset(0);
        make.left.mas_equalTo(self.comButton.mas_right).mas_offset(0);
        make.width.mas_offset(width);
    }];
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = UIColorFromRGB(0xE98A79);
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.backgroundColor = [UIColor clearColor];
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
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
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
- (UIView *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = .2;
    }
    return _alphaView;
}
- (UIButton *)attButton {
    if (_attButton == nil) {
        _attButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _attButton;
}
- (UIButton *)comButton {
    if (_comButton == nil) {
        _comButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_comButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_comButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _comButton;
}
- (UIButton *)praButton {
    if (_praButton == nil) {
        _praButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_praButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
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

















































