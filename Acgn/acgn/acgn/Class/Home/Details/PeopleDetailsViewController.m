//
//  PeopleDetailsViewController.m
//  acgn
//
//  Created by lijian on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "PeopleDetailsViewController.h"

@interface PeopleDetailsViewController ()

@end

@implementation PeopleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人详情";
    [self getPeopleInfoDetails];
}

- (void)getPeopleInfoDetails {
    [AApiModel getRoleInfoData:self.roleID block:^(BOOL result, RoleDetailsDataModel *obj) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
