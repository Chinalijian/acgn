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
//注册
+ (void)registerSystem:(NSString *)account psd:(NSString *)password code:(NSString *)code block:(void(^)(BOOL result))block;
//获取验证码
+ (void)getCodeForRegisterSystem:(NSString *)phone block:(void(^)(BOOL result))block;
//获取找回密码验证码
+ (void)getFindCodeForPsdSystem:(NSString *)phone block:(void(^)(BOOL result))block;
//获取找回密码验证码
+ (void)getFindCodeConfirmSystem:(NSString *)phone code:(NSString *)code block:(void(^)(BOOL result))block;
//确认找回密码
+ (void)getFindPsdForUserSystem:(NSString *)psd phone:(NSString *)phone block:(void(^)(BOOL result))block;
//修改密码
+ (void)modifyPsdForUser:(NSString *)psd latestPsd:(NSString *)latestPsd block:(void(^)(BOOL result))block;
//修改昵称
+ (void)modifyNickNameForUser:(NSString *)nickName block:(void(^)(BOOL result))block;
//获取首页角色列表
+ (void)getRoleListForHome:(NSString *)lastID block:(void(^)(BOOL result, NSArray *array))block;
//首页关注
+ (void)getHomeAttentList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//首页广场
+ (void)getHomePostList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//获取动态详情
+ (void)getPostDetilsData:(NSString *)postId block:(void(^)(BOOL result, DynamicListData *obj))block;
//获取动态评论列表
+ (void)getPostCommentListData:(NSString *)postId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//个人详情里 人物发的帖子列表
+ (void)getRoleDtailsListData:(NSString *)roleId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//个人详情人物信息
+ (void)getRoleInfoData:(NSString *)roleId block:(void(^)(BOOL result, RoleDetailsDataModel *obj))block;
//吐槽中心
+ (void)getGetCommentDetailsData:(NSString *)commentId lastId:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//收藏
+ (void)addCollectionForUser:(NSString *)postId roleId:(NSString *)roleId block:(void(^)(BOOL result))block;
//取消收藏
+ (void)delCollectionForUser:(NSString *)postId block:(void(^)(BOOL result))block;
//点赞-帖子
+ (void)addFabulousForUser:(NSString *)postId block:(void(^)(BOOL result))block;
//取消点赞-帖子
+ (void)delFabulousForUser:(NSString *)postId block:(void(^)(BOOL result))block;
//点赞-评论
+ (void)addPraiseForUser:(NSString *)postId commentId:(NSString *)commentId block:(void(^)(BOOL result))block;
//取消点赞-评论
+ (void)delPraiseForUser:(NSString *)postId commentId:(NSString *)commentId block:(void(^)(BOOL result))block;
//发表评论
+ (void)addCommentForUser:(id)obj block:(void(^)(BOOL result))block;
//添加关注
+ (void)addFollowForUser:(NSMutableArray *)roleIDs block:(void(^)(BOOL result))block;
//取消关注
+ (void)delFollowForUser:(NSString *)roleId block:(void(^)(BOOL result))block;
//吐槽我的
+ (void)replyMeList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//我吐槽的
+ (void)mySendList:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//是否有未读消息
+ (void)getHasNoReadForUser:(void(^)(BOOL result))block;
//收藏列表
+ (void)getCollectionListForUser:(NSString *)lastId block:(void(^)(BOOL result, NSArray *array))block;
//获取用户信息
+ (void)getUserInfoForUser:(void(^)(BOOL result))block;



@end


















