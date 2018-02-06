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
#import "ContentBaseViewController.h"
#import "MulCategoryScrollView.h"
@interface HomeViewController () <YLSwitchDelegate>

@property (nonatomic, strong) NSMutableArray *categoryCtrNameArray;
@property (nonatomic, strong) NSMutableArray *categoryCtrArray;

@end

@implementation HomeViewController
#define H_AttentVC        @"AttentViewController"
#define H_SquareVC        @"SquareViewController"
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

    
    [self addMulCategoryScrollView];
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

- (void)addMulCategoryScrollView {
    self.categoryCtrNameArray = [NSMutableArray arrayWithObjects:H_AttentVC, H_SquareVC, nil];
    self.categoryCtrArray = [NSMutableArray array];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i<[self.categoryCtrNameArray count]; i++) {
        ContentBaseViewController *ctr = [[NSClassFromString([self.categoryCtrNameArray objectAtIndex:i]) alloc] init];
        [self.categoryCtrArray addObject:ctr];
        [viewsArray addObject:ctr.view];
        [self addChildViewController:ctr];
    }
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, DMScreenHeight-64);
    __weak typeof(self)bsel = self;
    MulCategoryScrollView *mulCSV = [[MulCategoryScrollView alloc] initWithFrame:rect andViews:viewsArray andIndexBlock:^(NSInteger index,id obj) {
    }];
    [self.view addSubview:mulCSV];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    //[self.navigationController setNavigationBarHidden:NO];
    //[self setNavigationBarTransparence:NO titleColor:[UIColor blackColor]];
    [self useMethodToFindBlackLineAndHind:NO];
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
