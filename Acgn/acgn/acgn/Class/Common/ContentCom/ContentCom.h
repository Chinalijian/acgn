//
//  ContentCom.h
//  acgn
//
//  Created by lijian on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCom.h"


@protocol ContentComDelegate <NSObject>
@optional
- (void)clickSelectPeopleImage:(NSString *)roleId;
- (void)clickSelectSectionViewForGoToDetail:(id)obj;
@end


//列表头的通用控件View
@interface ContentCom : UITableViewHeaderFooterView
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
                        frame:(CGRect)frame;
@property (nonatomic, weak) id <ContentComDelegate> delegate;
- (void)configInfo:(DynamicListData *)obj;
+ (CGFloat)getContentCommonCellHeight:(DynamicListData *)obj;
@end
