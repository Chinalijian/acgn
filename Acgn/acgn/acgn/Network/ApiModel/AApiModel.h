//
//  AApiModel.h
//  acgn
//
//  Created by Ares on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AApiModel : NSObject
//登录
+ (void)loginSystem:(NSString *)account psd:(NSString *)password block:(void(^)(BOOL result))block;
//退出登录
+ (void)logoutSystem:(NSString *)account psd:(NSString *)password block:(void(^)(BOOL result))block;
@end
