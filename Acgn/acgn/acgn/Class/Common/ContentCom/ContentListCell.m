//
//  ContentListCell.m
//  acgn
//
//  Created by Ares on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "ContentListCell.h"
#import "CommintSecondView.h"

@interface ContentListCell ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *commitLabel;
@property (nonatomic, strong) CommintSecondView *secondView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *praiseLabel;

@end

@implementation ContentListCell

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

- (void)configDynamicObj:(DynamicCommentListData *)obj {
    if (!OBJ_IS_NIL(obj)) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:obj.avatar] placeholderImage:PlaceholderImage];
        self.nameLabel.text = obj.userName;
        self.commitLabel.text = obj.commentContext;
        self.timeLabel.text = obj.commentTime;
        [self.praiseLabel setTitle:obj.praiseNum forState:UIControlStateNormal];
    } else {
        self.headImageView.image = nil;
        self.nameLabel.text = @"";
        self.commitLabel.text = @"";
        self.timeLabel.text = @"";
        [self.praiseLabel setTitle:@"" forState:UIControlStateNormal];
    }
    
    CGFloat commitH = [self getCommitContentMaxHeight:obj];
    CGFloat secondH = [self getSecondViewMaxHeight:obj];
    [self upDateCellLayout:commitH secondHeight:secondH];
    [self updateCommitContentFrame:commitH];
    [self updateSecondCommitViewFrame:secondH];
    
}

- (void)upDateCellLayout:(CGFloat)commitH secondHeight:(CGFloat)secondH {
    CGFloat heightRow = Content_List_Cell_H + commitH + secondH;
    self.frame = CGRectMake(0, 0, DMScreenWidth, heightRow);
}

- (void)updateCommitContentFrame:(CGFloat)commitH {
    [self.commitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left).offset(0);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(Label_Space_Y);
        make.width.mas_offset(Info_Width);
        make.height.mas_offset(commitH);
    }];
}

- (void)updateSecondCommitViewFrame:(CGFloat)secondH {
    [self.secondView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left).offset(0);
        make.top.mas_equalTo(_commitLabel.mas_bottom).offset(SecondView_Top_SPace_Y);
        make.width.mas_offset(Info_Width);
        make.height.mas_offset(secondH);
    }];
}

- (CGFloat)getCellMaxHeightAndUpdate:(DynamicCommentListData *)dynamicObj {
    CGFloat commitH = [self getCommitContentMaxHeight:dynamicObj];
    CGFloat secondH = [self getSecondViewMaxHeight:dynamicObj];
    CGFloat heightRow = Content_List_Cell_H + commitH + secondH;
    return heightRow;
}

- (CGFloat)getCommitContentMaxHeight:(DynamicCommentListData *)dynamicObj {
    if (OBJ_IS_NIL(dynamicObj)) {
        return 0;
    }
    return [ATools getHeightByWidth:Info_Width title:dynamicObj.commentContext font:Commit_Font];
}

- (CGFloat)getSecondViewMaxHeight:(DynamicCommentListData *)dynamicObj {
  
    if (!OBJ_IS_NIL(dynamicObj)) {
        CGFloat commitSecond = 0;
        NSInteger count = dynamicObj.secondView.count;
        if (count > 0) {
            CGFloat commitListH = 30;//
            if (count > 3) {
                commitListH = commitListH + 28;
            }
            for (int i = 0; i < count; i++) {
                DynamicCommentSecondData *seObj = [dynamicObj.secondView objectAtIndex:i];
                NSString *content = [NSString stringWithFormat:@"%@@%@:%@",seObj.userName,seObj.otherName,seObj.commentContext];
                CGFloat h = [ATools getHeightByWidth:Info_Width-SecondView_LeftRight_SPace*2 title:content font:Commit_Font];
                commitListH = commitListH + h;
                if (i == 2) {
                    break;
                }
            }
            commitSecond = commitListH;
        }
        return commitSecond;
    }
    
    return 0;
}

- (void)loadUI {
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.commitLabel];
    [self addSubview:self.secondView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.praiseLabel];
    [self setupMakeBodyViewSubViewsLayout];
}

- (void)setupMakeBodyViewSubViewsLayout {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Top_Space_Y);
        make.left.mas_equalTo(self).mas_offset(Left_Space_X);
        make.width.mas_offset(Head_Image_WH);
        make.height.mas_offset(Head_Image_WH);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).offset(Label_Space_X);
        make.top.mas_equalTo(_headImageView.mas_top).offset(0);
        make.width.mas_offset(Info_Width);
        make.height.mas_offset(NameLabel_H);
    }];
    [self.commitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left).offset(0);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(Label_Space_Y);
        make.width.mas_offset(Info_Width);
        make.height.mas_offset(NameLabel_H);
    }];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left).offset(0);
        make.top.mas_equalTo(_commitLabel.mas_bottom).offset(SecondView_Top_SPace_Y);
        make.width.mas_offset(Info_Width);
        make.height.mas_offset(0);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.width.mas_offset(DMScreenWidth/3);
        make.height.mas_offset(Bottom_Area_H/2);
    }];
    [self.praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-Left_Space_X);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.width.mas_offset(Bottom_Area_H);
        make.height.mas_offset(Bottom_Area_H);
    }];
}

- (CommintSecondView *)secondView {
    if (_secondView == nil) {
        _secondView = [[CommintSecondView alloc] init];
    }
    return _secondView;
}
- (UIButton *)praiseLabel {
    if (_praiseLabel == nil) {
        _praiseLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _praiseLabel;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = UIColorFromRGB(0xE96A79);
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}
- (UILabel *)commitLabel {
    if (_commitLabel == nil) {
        _commitLabel = [[UILabel alloc] init];
        _commitLabel.text = @"";
        _commitLabel.textAlignment = NSTextAlignmentLeft;
        _commitLabel.textColor = UIColorFromRGB(0x000000);
        _commitLabel.font = Commit_Font;
        _commitLabel.backgroundColor = [UIColor whiteColor];
        _commitLabel.lineBreakMode  =NSLineBreakByClipping;
        _commitLabel.numberOfLines = 0;
    }
    return _commitLabel;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = UIColorFromRGB(0x939393);
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = Head_Image_WH/2;
    }
    return _headImageView;
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
