//
//  AApiModel.m
//  acgn
//
//  Created by Ares on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AApiModel.h"
#import "DMHttpClient.h"
@implementation AApiModel
//登录
+ (void)loginSystem:(NSString *)account psd:(NSString *)password block:(void(^)(BOOL result))block {
    
    NSString *psdStr = [ATools MD5:password];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:account, @"phone", psdStr, @"passWord",nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_User_Loing_Url parameters:dic method:DMHttpRequestPost dataModelClass:[UserDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            //保存数据
            UserDataModel *model = (UserDataModel *)responseObject;
            [AccountInfo saveAccountInfo:model];
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//注册
+ (void)registerSystem:(NSString *)account psd:(NSString *)password code:(NSString *)code block:(void(^)(BOOL result))block {
    NSString *psdStr = [ATools MD5:password];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:account, @"phone", psdStr, @"passWord", code, @"code", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_User_Register_Url parameters:dic method:DMHttpRequestPost dataModelClass:[UserDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            //保存数据
            UserDataModel *model = (UserDataModel *)responseObject;
            [AccountInfo saveAccountInfo:model];
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//获取验证码
+ (void)getCodeForRegisterSystem:(NSString *)phone block:(void(^)(BOOL result))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone, @"phone", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Register_Code_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//获取找回密码验证码
+ (void)getFindCodeForPsdSystem:(NSString *)phone block:(void(^)(BOOL result))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone, @"phone", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Find_Psd_Code_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//获取找回密码验证码
+ (void)getFindCodeConfirmSystem:(NSString *)phone code:(NSString *)code block:(void(^)(BOOL result))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone, @"phone", code, @"verCode",nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Confirm_Code_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//确认找回密码
+ (void)getFindPsdForUserSystem:(NSString *)psd block:(void(^)(BOOL result))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:psd, @"passWord", [AccountInfo getUserID], @"uId",nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_FindPassWord_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
    
}

@end
