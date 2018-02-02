//
//  RegisterViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountView.h"
#import "NickNameViewController.h"
@interface RegisterViewController () <AccountViewDelegate>
@property (nonatomic, strong) AccountView *aView;

@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [self loadUI];
}

- (void)clickAccountSure:(id)sender datas:(NSMutableArray *)array {
    AccountLocalDataModel *phoneObj = [array firstObject];
    AccountLocalDataModel *codeObj = [array objectAtIndex:1];
    AccountLocalDataModel *psdObj = [array lastObject];
    
    NickNameViewController *nickNameVC = [[NickNameViewController alloc] init];
    [self.navigationController pushViewController:nickNameVC animated:YES];
}

#pragma mark -
#pragma mark - UI
- (void)loadUI {
    [self.view addSubview:self.aView];
}

- (AccountView *)aView {
    if (_aView == nil) {
        _aView = [[AccountView alloc] initWithFrame:self.view.bounds type:AAccountType_Register];
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
