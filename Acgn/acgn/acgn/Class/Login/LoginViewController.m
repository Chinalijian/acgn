//
//  LoginViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountView.h"
#import "RegisterViewController.h"
#import "ResetPsdViewController.h"
@interface LoginViewController () <AccountViewDelegate>
@property (nonatomic, strong) AccountView *aView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [self loadUI];
}

- (void)clickAccountSure:(id)sender datas:(NSMutableArray *)array {
    AccountLocalDataModel *phoneObj = [array firstObject];
    AccountLocalDataModel *psdObj = [array lastObject];
    if (STR_IS_NIL(phoneObj.content)) {
        [ATools showSVProgressHudCustom:@"" title:@"请输入手机号码"];
        return;
    }
    if (STR_IS_NIL(psdObj.content)) {
        [ATools showSVProgressHudCustom:@"" title:@"请输入密码"];
        return;
    }
    if (phoneObj.content.length != 11) {
        [ATools showSVProgressHudCustom:@"" title:@"请输入正确的手机号码"];
        return;
    }
    //登录
    WS(weakSelf);
    [AApiModel loginSystem:phoneObj.content psd:psdObj.content block:^(BOOL result) {
        if (result) {
            //发送登录成功的广播
            [[NSNotificationCenter defaultCenter] postNotificationName:DMNotification_Login_Success_Key object:nil userInfo:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            
        }
    }];
}

- (void)clickAccountRegister:(id)sender {
    //注册
    RegisterViewController *regVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
}

- (void)clickAccountResetPsd:(id)sender {
    //找回密码
    ResetPsdViewController *resVC = [[ResetPsdViewController alloc] init];
    [self.navigationController pushViewController:resVC animated:YES];
}

- (void)clickThirdPartyQQ:(id)sender {
    //qq登录
}

- (void)clickThirdPartyWecat:(id)sender {
    //微信登录
}

- (void)clickThirdPartyWeibo:(id)sender {
    //微博登录
}

#pragma mark -
#pragma mark - UI
- (void)loadUI {
    [self.view addSubview:self.aView];
}

- (AccountView *)aView {
    if (_aView == nil) {
        _aView = [[AccountView alloc] initWithFrame:self.view.bounds type:AAccountType_Login];
        _aView.delegate = self;
    }
    return _aView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setNavigationBarTransparence:YES titleColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
