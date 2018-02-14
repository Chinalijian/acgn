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
#import "MyFavViewController.h"
#import "MyMsgViewController.h"
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
    [self notificationAll];
}

- (void)getNoReadMsg {
    WS(weakSelf);
    [AApiModel getHasNoReadForUser:^(BOOL result) {
        if (result) {
            weakSelf.userView.hasNoMsg = YES;
            [weakSelf.userView.uTableView reloadData];
        }
    }];
}

- (void)getUserInfo {
    WS(weakSelf);
    [AApiModel getUserInfoForUser:^(BOOL result) {
        [weakSelf.userView updateUserInfo];
    }];
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
        case AAccountType_Msg: {
            self.userView.hasNoMsg = NO;
            MyMsgViewController *myMsgVC = [[MyMsgViewController alloc] init];
            [self.navigationController pushViewController:myMsgVC animated:YES];
            break;
        }
        case AAccountType_Fav: {
            MyFavViewController *myFavVC = [[MyFavViewController alloc] init];
            [self.navigationController pushViewController:myFavVC animated:YES];
            break;
        }
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
    if (!STR_IS_NIL([AccountInfo getUserID])) {
        [self getNoReadMsg];
        [self getUserInfo];
    }
    
    [_userView.uTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
