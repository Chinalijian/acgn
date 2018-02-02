//
//  AEnums.h
//  acgn
//
//  Created by Ares on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#ifndef AEnums_h
#define AEnums_h

typedef NS_ENUM(NSInteger, AAccountType) {
    AAccountType_Login       = 1, // 登录
    AAccountType_Register    = 2, // 注册
    AAccountType_ResetPsd    = 3, // 找回密码
    AAccountType_SetPsd      = 4, // 设置密码
    AAccountType_NickName    = 5, // 修改昵称
};


#endif /* AEnums_h */
