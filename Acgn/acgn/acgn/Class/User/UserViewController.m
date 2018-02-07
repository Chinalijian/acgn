//
//  UserViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "UserViewController.h"
#import "UserView.h"
#import "AboutViewController.h"
#import "ModifyPsdViewController.h"
#import "NickNameViewController.h"

@interface UserViewController () <UserViewDelegate>
@property (nonatomic, strong) UserView *userView;
@end

@implementation UserViewController


- (void)notificationAll {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUserInfo:)
                                                 name:DMNotification_Login_Success_Key
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [self loadUI];
    //[self notificationAll];
}

- (void)updateUserInfo:(NSNotification *)notification {
    [_userView updateUserInfo];
}

- (void)clickTopGotoLogin {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)clickTopGotoNikeNamePage {
    NickNameViewController *nickNameVC = [[NickNameViewController alloc] init];
    [self.navigationController pushViewController:nickNameVC animated:YES];
}

- (void)goToPage:(AAccountType)type {
    switch (type) {
        case AAccountType_Msg:
            
            break;
        case AAccountType_Fav:
            
            break;
        case AAccountType_ChangePsd: {
            ModifyPsdViewController *modifyPsdVC = [[ModifyPsdViewController alloc] init];
            [self.navigationController pushViewController:modifyPsdVC animated:YES];
            break;
        }
        case AAccountType_About: {
            AboutViewController *usVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:usVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark - UI
- (void)loadUI {
    [self.view addSubview:self.userView];
}

- (UserView *)userView {
    if (_userView == nil) {
        _userView = [[UserView alloc] initWithFrame:self.view.bounds];
        _userView.delegate = self;
    }
    return _userView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setNavigationBarTransparence:YES titleColor:[UIColor whiteColor]];
    //[_userView updateUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
