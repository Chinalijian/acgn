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
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:account, @"phone", password, @"password",nil];
    [[DMHttpClient sharedInstance] initWithUrl:@"" parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            //保存数据
            //DMLoginDataModel *model = (DMLoginDataModel *)responseObject;
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
@end
