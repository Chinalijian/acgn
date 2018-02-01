//
//  LoginViewController.m
//  acgn
//
//  Created by Ares on 2018/2/1.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) UIImageView *image;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速登录";
    
    [self setRigthBtn:CGRectMake(0, 0, 64, 44) title:@"11" titileColor:[UIColor blackColor] imageName:nil font:[UIFont systemFontOfSize:16]];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self loadUI];
}

- (void)loadUI {
    [self.view addSubview:self.image];
    [self setupMakeLayoutSubviews];
}

- (void)setupMakeLayoutSubviews {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(-467);
    }];
}
- (UIImageView *)image {
    if (_image == nil) {
        _image = [[UIImageView alloc] init];
        _image.image = [UIImage imageNamed:@"image.jpeg"];
    }
    return _image;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setNavigationBarTransparence:YES titleColor:[UIColor whiteColor]];
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
