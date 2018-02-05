//
//  NickNameViewController.m
//  acgn
//
//  Created by lijian on 2018/2/2.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "NickNameViewController.h"
#import "AccountView.h"
@interface NickNameViewController ()<AccountViewDelegate>
@property (nonatomic, strong) AccountView *aView;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    self.view.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [self loadUI];
}

- (void)clickAccountSure:(id)sender datas:(NSMutableArray *)array {
    AccountLocalDataModel *obj = [array firstObject];
    [AApiModel modifyNickNameForUser:obj.content block:^(BOOL result) {
        if (result) {
            [ATools showSVProgressHudCustom:@"" title:@"修改成功"];
        }
    }];
}

#pragma mark -
#pragma mark - UI
- (void)loadUI {
    [self.view addSubview:self.aView];
}

- (AccountView *)aView {
    if (_aView == nil) {
        _aView = [[AccountView alloc] initWithFrame:self.view.bounds type:AAccountType_NickName];
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
