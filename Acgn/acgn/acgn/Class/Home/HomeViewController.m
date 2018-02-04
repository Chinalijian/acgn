//
//  HomeViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "HomeViewController.h"
#import "AttentionPeopleList.h"
#import "UserViewController.h"
#import "YLSwitch.h"
@interface HomeViewController () <AttentionPeopleListDelegate,YLSwitchDelegate>
@property (nonatomic, strong) AttentionPeopleList *apListView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRigthBtn:CGRectMake(0, 0, 44, 44) title:@"" titileColor:nil imageName:@"user_icon" font:nil];
    [self loadUI];
}

- (void)rightOneAction:(id)sender {
    UserViewController *userVC = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
}

- (void)loadUI {
    
    YLSwitch *mySwitch = [[YLSwitch alloc] initWithFrame:CGRectMake(0, 0, 128, 30)];
    mySwitch.tag = 1;
    mySwitch.isSelectedIndex = 0;
    mySwitch.delegate = self;
    mySwitch.leftTitle = @"关注";
    mySwitch.rightTitle = @"广场";
    self.navigationItem.titleView  = mySwitch;
    
    [self.view addSubview:self.apListView];
}
#pragma mark -- YLSwitchDelegate

- (void)switchState:(UIView *)view leftTitle:(NSString *)title {
    if (view.tag == 1) {
        NSLog(@"导航栏switch");
    }
    NSLog(@"%@",title);
}

- (void)switchState:(UIView *)view rightTitle:(NSString *)title {
    if (view.tag == 1) {
        NSLog(@"导航栏switch");
    }
    NSLog(@"%@",title);
}

-(AttentionPeopleList *)apListView{
    if (_apListView == nil) {
        _apListView = [[AttentionPeopleList alloc] initWithFrame:CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) delegate:self];
        _apListView.backgroundColor = [UIColor whiteColor];
    }
    return _apListView;
}

- (void)clickAttentButton:(id)sender {
    //判断是否登录，没登录去登录页面，登录的话去首页
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
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
