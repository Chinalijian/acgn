//
//  UserViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "UserViewController.h"
#import "UserView.h"
@interface UserViewController () <UserViewDelegate>
@property (nonatomic, strong) UserView *userView;
@end

@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [self loadUI];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
