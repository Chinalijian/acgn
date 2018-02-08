//
//  AboutViewController.m
//  acgn
//
//  Created by lijian on 2018/2/4.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic, strong) ComonTop *topView;
@end

@implementation AboutViewController
#define TopView_H 198
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [self.view addSubview:self.topView];

}

- (ComonTop *)topView {
    if (_topView == nil) {
        _topView = [[ComonTop alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TopView_H)];
        _topView.logoNameLabel.text = @"加一次元";
    }
    return _topView;
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
