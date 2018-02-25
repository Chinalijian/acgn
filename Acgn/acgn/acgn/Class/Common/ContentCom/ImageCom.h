//
//  ImageCom.h
//  acgn
//
//  Created by lijian on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>

//列表图片/视频的View
@interface ImageCom : UIView
- (id)initWithBigImage:(CGFloat)width
        bigImageHeight:(CGFloat)height
       smallImageWidth:(CGFloat)swidth
      samllImageHeight:(CGFloat)sheight
            smallSpace:(CGFloat)sspace
                frameW:(CGFloat)frameW
                frameH:(CGFloat)frameH;
- (void)configImageCom:(NSArray *)array height:(CGFloat)height type:(Info_Type)type;
@end
