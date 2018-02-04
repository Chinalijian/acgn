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
@end
