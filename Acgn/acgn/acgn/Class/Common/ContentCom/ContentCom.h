//
//  ContentCom.h
//  acgn
//
//  Created by lijian on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCom.h"

@interface ContentCom : UITableViewHeaderFooterView
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
                        frame:(CGRect)frame;
- (CGFloat)getConstHeight:(CGFloat)contentH imageHeight:(CGFloat)imageH;
@end
