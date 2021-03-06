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
+ (void)getFindPsdForUserSystem:(NSString *)psd phone:(NSString *)phone block:(void(^)(BOOL result))block {
    NSString *psdStr = [ATools MD5:psd];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:psdStr, @"password", phone, @"phone",nil];
    NSLog(@"参数 = %@", dic);
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
//修改密码
+ (void)modifyPsdForUser:(NSString *)psd latestPsd:(NSString *)latestPsd block:(void(^)(BOOL result))block {
    NSString *uID = [AccountInfo getUserID];
    NSString *psdStr = [ATools MD5:psd];
    NSString *latestPsdStr = [ATools MD5:latestPsd];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:uID, @"uId", psdStr, @"password", latestPsdStr, @"newPassWord",nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Modify_Psd_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//修改昵称
+ (void)modifyNickNameForUser:(NSString *)nickName block:(void(^)(BOOL result))block {
    NSString *uID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:uID, @"uid", nickName, @"userName", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Modify_NickName_Url parameters:dic method:DMHttpRequestPost dataModelClass:[UserDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            UserDataModel *model = (UserDataModel *)responseObject;
            [AccountInfo saveUserName:model.userName];
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//获取首页角色列表
+ (void)getRoleListForHome:(NSString *)lastID block:(void(^)(BOOL result, NSArray *array))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"lastId", @"20", @"rowPage", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Role_List_Url parameters:dic method:DMHttpRequestPost dataModelClass:[PeopleListDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            PeopleListDataModel *model = (PeopleListDataModel *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//首页关注
+ (void)getHomeAttentList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastId, @"lastId", @"20", @"rowPage", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_FollowHome_Url parameters:dic method:DMHttpRequestPost dataModelClass:[DynamicData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            DynamicData *model = (DynamicData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//首页广场
+ (void)getHomePostList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastId, @"lastId", @"20", @"rowPage", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_HomePost_Url parameters:dic method:DMHttpRequestPost dataModelClass:[DynamicData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            DynamicData *model = (DynamicData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//获取动态详情
+ (void)getPostDetilsData:(NSString *)postId block:(void(^)(BOOL result, DynamicListData *obj))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_GetPostDetails_Url parameters:dic method:DMHttpRequestPost dataModelClass:[DynamicListData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            DynamicListData *model = (DynamicListData *)responseObject;
            block(YES, model);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//获取动态评论列表
+ (void)getPostCommentListData:(NSString *)postId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", lastId, @"lastId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_GetPostComment_List_Url parameters:dic method:DMHttpRequestPost dataModelClass:[DynamicDetailsCommentData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            DynamicDetailsCommentData *model = (DynamicDetailsCommentData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}
//个人详情里 人物发的帖子列表
+ (void)getRoleDtailsListData:(NSString *)roleId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:roleId, @"roleId", lastId, @"lastId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_GetRoleDetails_List_Url parameters:dic method:DMHttpRequestPost dataModelClass:[RoleDetailsPostListData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            RoleDetailsPostListData *model = (RoleDetailsPostListData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//个人详情人物信息
+ (void)getRoleInfoData:(NSString *)roleId block:(void(^)(BOOL result, RoleDetailsDataModel *obj))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:roleId, @"roleId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_GetRoleInfoDetails_Url parameters:dic method:DMHttpRequestPost dataModelClass:[RoleDetailsDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            RoleDetailsDataModel *model = (RoleDetailsDataModel *)responseObject;
            block(YES, model);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//吐槽中心
+ (void)getGetCommentDetailsData:(NSString *)commentId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:commentId, @"commentId", lastId, @"lastId", @"20", @"rowPage", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_GetCommentDetails_Url parameters:dic method:DMHttpRequestPost dataModelClass:[DynamicData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            DynamicData *model = (DynamicData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//收藏
+ (void)addCollectionForUser:(NSString *)postId roleId:(NSString *)roleId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", userID, @"uId", roleId, @"roleId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Add_Collection_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//取消收藏
+ (void)delCollectionForUser:(NSString *)postId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Del_Collection_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//点赞-帖子
+ (void)addFabulousForUser:(NSString *)postId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Add_Fabulous_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//取消点赞-帖子
+ (void)delFabulousForUser:(NSString *)postId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Del_Fabulous_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//点赞-评论
+ (void)addPraiseForUser:(NSString *)postId commentId:(NSString *)commentId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:commentId, @"commentId", postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Add_Praise_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//取消点赞-评论
+ (void)delPraiseForUser:(NSString *)postId commentId:(NSString *)commentId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:commentId, @"commentId", postId, @"postId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Del_Praise_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}


//发表评论
+ (void)addCommentForUser:(id)obj block:(void(^)(BOOL result))block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                @"", @"type",
                                @"", @"replyUid",
                                @"", @"replyId",
                                @"", @"postId",
                                @"", @"parentCommentId",
                                @"", @"commentUid",
                                @"", @"replyContext",
                                @"", @"commentContext", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Add_Comment_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//添加关注
+ (void)addFollowForUser:(NSMutableArray *)roleIDs block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:roleIDs, @"roleId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Add_Follow_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}

//取消关注
+ (void)delFollowForUser:(NSString *)roleId block:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:roleId, @"roleId", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Del_Follow_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//吐槽我的
+ (void)replyMeList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastId, @"lastId", @"20", @"rowPage", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_ReplyMe_Url parameters:dic method:DMHttpRequestPost dataModelClass:[MsgData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            MsgData *model = (MsgData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}
//我吐槽的
+ (void)mySendList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastId, @"lastId", @"20", @"rowPage", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_MySend_Url parameters:dic method:DMHttpRequestPost dataModelClass:[MsgData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            MsgData *model = (MsgData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}
//是否有未读消息
+ (void)getHasNoReadForUser:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_HasNoRead_Msg_Url parameters:dic method:DMHttpRequestPost dataModelClass:[NSObject class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            block(YES);
        } else {
            block(NO);
        }
    } failure:^(NSError *error) {
        block (NO);
    }];
}
//收藏列表
+ (void)getCollectionListForUser:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:lastId, @"lastId", @"20", @"rowPage", userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_CollectionList_Url parameters:dic method:DMHttpRequestPost dataModelClass:[CollectionData class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
            CollectionData *model = (CollectionData *)responseObject;
            block(YES, model.data);
        } else {
            block(NO, nil);
        }
    } failure:^(NSError *error) {
        block (NO, nil);
    }];
}

//获取用户信息
+ (void)getUserInfoForUser:(void(^)(BOOL result))block {
    NSString *userID = [AccountInfo getUserID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:userID, @"uId", nil];
    [[DMHttpClient sharedInstance] initWithUrl:DM_Get_User_Info_Url parameters:dic method:DMHttpRequestPost dataModelClass:[UserDataModel class] isMustToken:NO success:^(id responseObject) {
        if (!OBJ_IS_NIL(responseObject)) {
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






























