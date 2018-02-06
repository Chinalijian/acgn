//
//  AttentViewController.m
//  acgn
//
//  Created by lijian on 2018/2/5.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AttentViewController.h"
#import "AttentionPeopleList.h"
@interface AttentViewController () <AttentionPeopleListDelegate>
@property (nonatomic, strong) AttentionPeopleList *apListView;
@property (nonatomic, strong) NSMutableArray *roleListDatas;
@end

@implementation AttentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.roleListDatas = [NSMutableArray array];
    [self.view addSubview:self.apListView];
    [self getRoleListData];
}

- (void)getRoleListData {
    WS(weakSelf);
    [AApiModel getRoleListForHome:@"" block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                [weakSelf.roleListDatas addObjectsFromArray:array];
                [weakSelf.apListView updateList:weakSelf.roleListDatas];
            }
        }
    }];
}

- (void)requestAttentPeoples {
    
}

- (void)clickAttentButton:(id)sender {
    //判断是否登录，没登录去登录页面，登录的话去首页请求关注
    if (STR_IS_NIL([AccountInfo getUserID])) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else {
        [self requestAttentPeoples];
    }
}

-(AttentionPeopleList *)apListView{
    if (_apListView == nil) {
        _apListView = [[AttentionPeopleList alloc] initWithFrame:CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) delegate:self];
        _apListView.backgroundColor = [UIColor whiteColor];
    }
    return _apListView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
