//
//  DMServerApiConfig.h
//  acgn
//
//  Created by Ares on 2017/9/11.
//  Copyright © 2017年 Discover Melody. All rights reserved.
//

#ifndef DMServerApiConfig_h
#define DMServerApiConfig_h

#define App_Version [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

#define SERVER_ENVIRONMENT   0

/**************************************************************************************************************/


//：api.cn.discovermelody-app.com
//学生/老师英文：api.us.discovermelody-app.com

#if SERVER_ENVIRONMENT == 0 //正式
    #define DM_Local_Url @"http://www.jiayiworld.com/"//服务器访问地址
#elif

#endif

#define DM_Url      DM_Local_Url

//登录
#define DM_User_Loing_Url               [DM_Url stringByAppendingFormat:@"user/login"]
//注册
#define DM_User_Register_Url            [DM_Url stringByAppendingFormat:@"user/register"]
//注册获取验证码
#define DM_Register_Code_Url            [DM_Url stringByAppendingFormat:@"user/getVerCode"]
//找回密码验证码
#define DM_Find_Psd_Code_Url            [DM_Url stringByAppendingFormat:@"user/findByVerCode"]
//找回密码验证码校验
#define DM_Confirm_Code_Url             [DM_Url stringByAppendingFormat:@"user/confirmCode"]
//确认找回密码
#define DM_FindPassWord_Url             [DM_Url stringByAppendingFormat:@"user/findPassWord"]
//修改密码
#define DM_Modify_Psd_Url               [DM_Url stringByAppendingFormat:@"user/updatePassword"]
//修改昵称
#define DM_Modify_NickName_Url          [DM_Url stringByAppendingFormat:@"user/updateUserName"]

//老师课程列表
#define DM_User_Tcourse_List_Url        [DM_Url stringByAppendingFormat:@"lesson/tcourseList"]
//个人课程列表
#define DM_User_Scourse_List_Url        [DM_Url stringByAppendingFormat:@"lesson/scourseList"]

//个人主页学生
#define DM_User_Scourse_Index_Url       [DM_Url stringByAppendingFormat:@"lesson/scourseIndex"]
//个人主页老师
#define DM_User_Tcourse_Index_Url       [DM_Url stringByAppendingFormat:@"lesson/tcourseIndex"]

//学生进入课堂
#define DM_Student_Access_Url           [DM_Url stringByAppendingFormat:@"lesson/studentAccess"]
//老师进入课堂
#define DM_Teacher_Access_Url           [DM_Url stringByAppendingFormat:@"lesson/teacherAccess"]

//获取课件列表
#define DM_Attachment_FileList_Url      [DM_Url stringByAppendingFormat:@"Attachment/getList"]
//课件上传
#define DM_User_Attachment_Upload_Url   [DM_Url stringByAppendingFormat:@"attachment/upload"]
//删除课件
#define DM_Attachment_fileMove_Url      [DM_Url stringByAppendingFormat:@"Attachment/move"]

//客服
#define DM_Customer_Url                 [DM_Url stringByAppendingFormat:@"customer/index"]

//点播视频
#define DM_Video_Replay_Url             [DM_Url stringByAppendingFormat:@"lesson/replay"]

//获取问题列表学生
#define DM_Student_Question_List_Url    [DM_Url stringByAppendingFormat:@"survey/squestionList"]
//获取问题列表老师
#define DM_Teacher_Question_List_Url    [DM_Url stringByAppendingFormat:@"survey/tquestionList"]
//提交答案学生
#define DM_Submit_Student_Answer_Url    [DM_Url stringByAppendingFormat:@"survey/submitStudent"]
//提交答案老师
#define DM_Submit_Teacher_Answer_Url    [DM_Url stringByAppendingFormat:@"survey/submitTeacher"]
//获取老师评语
#define DM_Survey_TeacherSurvey_Url     [DM_Url stringByAppendingFormat:@"survey/teacherSurvey"]

//获取百度云配置信息
#define DM_Cloud_Config_Url             [DM_Url stringByAppendingFormat:@"Attachment/getUploadConf"]
//百度云上传成功后的通知
#define DM_Cloud_Upload_Success_Url     [DM_Url stringByAppendingFormat:@"Attachment/uploadSuccess"]

//声网用户状态
#define DM_AgoraUserStatus_Log_Url      [DM_Url stringByAppendingFormat:@"log/agoraLog"]


#endif /* DMServerApiConfig_h */



