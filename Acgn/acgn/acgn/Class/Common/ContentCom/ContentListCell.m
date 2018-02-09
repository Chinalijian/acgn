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

- (void)loadUI {
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.commitLabel];
    [self addSubview:self.secondView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.praiseLabel];
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
        _commitLabel.font = [UIFont systemFontOfSize:13];
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
