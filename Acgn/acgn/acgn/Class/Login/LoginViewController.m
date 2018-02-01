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

@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UIView *psdView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIImageView *psdImageView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *psdTextField;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *resetPsdButton;

@property (nonatomic, strong) UIView *thirdPartyView;
@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *wecatButton;
@property (nonatomic, strong) UIButton *weiboButton;

@end

@implementation LoginViewController

#define X_SPACE 47

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速登录";
    self.view.backgroundColor = [UIColor yellowColor];
    [self loadUI];
}

- (void)clickLogin:(id)sender {
    //登录
}

- (void)clickRegister:(id)sender {
    //快速注册
}

- (void)clickResetPsd:(id)sender {
    //忘记密码
}

- (void)clickQQ:(id)sender {
    //
}

- (void)clickWecat:(id)sender {
    //
}

- (void)clickWeibo:(id)sender {
    //
}






#pragma mark -
#pragma mark - UI
- (void)loadUI {
    [self.view addSubview:self.image];
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.thirdPartyView];
    
    [self.bodyView addSubview:self.phoneView];
    [self.bodyView addSubview:self.psdView];
    [self.bodyView addSubview:self.loginButton];
    [self.bodyView addSubview:self.registerButton];
    [self.bodyView addSubview:self.resetPsdButton];
    
    [self.phoneView addSubview:self.phoneImageView];
    [self.phoneView addSubview:self.phoneTextField];
    
    [self.psdView addSubview:self.psdImageView];
    [self.psdView addSubview:self.psdTextField];
    
    [self.thirdPartyView addSubview:self.qqButton];
    [self.thirdPartyView addSubview:self.wecatButton];
    [self.thirdPartyView addSubview:self.weiboButton];
    
    [self setupMakeLayoutSubviews];
    [self initThirdPartyButtons];
}

- (void)initThirdPartyButtons {
    
}

- (void)setupMakeLayoutSubviews {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(-467);
    }];
    
    [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_image.mas_bottom).mas_offset(0);
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(-250);
    }];
    
    [_thirdPartyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(_bodyView.mas_bottom).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
    }];
   
    [self setupMakeBodyViewSubViewsLayout];
    [self setupMakeThirdParytViewSubViewsLayout];
}

- (void)setupMakeBodyViewSubViewsLayout {
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bodyView).mas_offset(15);
        make.left.mas_equalTo(_bodyView).mas_offset(X_SPACE);
        make.right.mas_equalTo(_bodyView).mas_offset(-X_SPACE);
        make.height.mas_equalTo(44);
    }];
    [_psdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(_bodyView).mas_offset(X_SPACE);
        make.right.mas_equalTo(_bodyView).mas_offset(-X_SPACE);
        make.height.mas_equalTo(44);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_psdView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(_bodyView).mas_offset(X_SPACE);
        make.right.mas_equalTo(_bodyView).mas_offset(-X_SPACE);
        make.height.mas_equalTo(44);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginButton.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(_bodyView).mas_offset(X_SPACE);
        make.width.mas_equalTo(self.view.frame.size.width/2-X_SPACE);
        make.bottom.mas_equalTo(_bodyView).mas_offset(0);
    }];
    [_resetPsdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginButton.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(_bodyView).mas_offset(-X_SPACE);
        make.width.mas_equalTo(self.view.frame.size.width/2-X_SPACE);
        make.bottom.mas_equalTo(_bodyView).mas_offset(0);
    }];
}

- (void)setupMakeThirdParytViewSubViewsLayout {
    [_wecatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_thirdPartyView).mas_offset(60);
        make.centerX.mas_equalTo(_thirdPartyView);
        make.height.mas_offset(72);
        make.width.mas_offset(57);
    }];
    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_wecatButton.mas_left).mas_offset(-67);
        make.top.mas_equalTo(_wecatButton);
        make.height.mas_offset(72);
        make.width.mas_offset(57);
    }];
    [_weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_wecatButton.mas_right).mas_offset(67);
        make.top.mas_equalTo(_wecatButton);
        make.height.mas_offset(72);
        make.width.mas_offset(57);
    }];
}

- (UIImageView *)image {
    if (_image == nil) {
        _image = [[UIImageView alloc] init];
        _image.image = [UIImage imageNamed:@"image.jpeg"];
    }
    return _image;
}

- (UIView *)bodyView {
    if (_bodyView == nil) {
        _bodyView = [[UIView alloc] init];
        _bodyView.backgroundColor = [UIColor whiteColor];
    }
    return _bodyView;
}

- (UIView *)phoneView {
    if (_phoneView == nil) {
        _phoneView = [[UIView alloc] init];
        _phoneView.backgroundColor = [UIColor whiteColor];
        _phoneView.layer.cornerRadius = 15;
        _phoneView.layer.borderColor = UIColorFromRGB(0xBAB8B9).CGColor;
        _phoneView.layer.borderWidth = .5;
    }
    return _phoneView;
}

- (UIView *)psdView {
    if (_psdView == nil) {
        _psdView = [[UIView alloc] init];
        _psdView.backgroundColor = [UIColor whiteColor];
        _psdView.layer.cornerRadius = 15;
        _psdView.layer.borderColor = UIColorFromRGB(0xBAB8B9).CGColor;
        _psdView.layer.borderWidth = .5;
    }
    return _psdView;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = UIColorFromRGB(0xE96A79);
        _loginButton.layer.cornerRadius = 15;
        _loginButton.layer.borderColor = UIColorFromRGB(0xBAB8B9).CGColor;
        _loginButton.layer.borderWidth = .5;
        [_loginButton setTitle:@"确定" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        _registerButton.backgroundColor = [UIColor whiteColor];
        [_registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)resetPsdButton {
    if (_resetPsdButton == nil) {
        _resetPsdButton = [[UIButton alloc] init];
        _resetPsdButton.backgroundColor = [UIColor whiteColor];
        [_resetPsdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_resetPsdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetPsdButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _resetPsdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_resetPsdButton addTarget:self action:@selector(clickResetPsd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetPsdButton;
}

- (UIView *)thirdPartyView {
    if (_thirdPartyView == nil) {
        _thirdPartyView = [[UIView alloc] init];
        _thirdPartyView.backgroundColor = [UIColor whiteColor];
    }
    return _thirdPartyView;
}

- (UIButton *)qqButton {
    if (_qqButton == nil) {
        _qqButton = [[UIButton alloc] init];
        _qqButton.backgroundColor = [UIColor whiteColor];
        [_qqButton setTitle:@"QQ登录" forState:UIControlStateNormal];
        [_qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_qqButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_qqButton addTarget:self action:@selector(clickQQ:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}
- (UIButton *)wecatButton {
    if (_wecatButton == nil) {
        _wecatButton = [[UIButton alloc] init];
        _wecatButton.backgroundColor = [UIColor whiteColor];
        [_wecatButton setTitle:@"微信登录" forState:UIControlStateNormal];
        [_wecatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_wecatButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_wecatButton addTarget:self action:@selector(clickWecat:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wecatButton;
}
- (UIButton *)weiboButton {
    if (_weiboButton == nil) {
        _weiboButton = [[UIButton alloc] init];
        _weiboButton.backgroundColor = [UIColor whiteColor];
        [_weiboButton setTitle:@"微博登录" forState:UIControlStateNormal];
        [_weiboButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_weiboButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_weiboButton addTarget:self action:@selector(clickWeibo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboButton;
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
