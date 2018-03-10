//
//  ModelShowViewController.m
//  acgn
//
//  Created by Ares on 2018/3/6.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "ModelShowViewController.h"
#import "IPhoneUtil.h"
#import "LAppModel.h"
#import "LAppDefine.h"
#include "LAppLive2DManager.h"
#import <ZipArchive.h>
#import "ModelFileManager.h"
@interface ModelShowViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *defaultShowImageView;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) NSArray *leftArray;
@property (nonatomic, strong) NSArray *rightArray;
@property (nonatomic, strong) NSArray *rightTitleArray;

@property (nonatomic, strong) UIProgressView *bottomProgressView;
@property (nonatomic, assign) Model_Show_Type type;
@end

@implementation ModelShowViewController
{
    LAppLive2DManager* live2DMgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"立体形象";
    self.type = Model_Show_Type_Default;
    self.leftArray = [NSArray arrayWithObjects:@"ms_l_icon_1",@"ms_l_icon_2",@"ms_l_icon_3",@"ms_l_icon_4", nil];
    self.rightArray = [NSArray arrayWithObjects:@"ms_r_icon_1",@"ms_r_icon_2",@"ms_r_icon_3",@"ms_r_icon_4", nil];
    self.rightTitleArray = [NSArray arrayWithObjects:@"活 动",@"福 利",@"道 具",@"信 息", nil];
    //[self loadLive2D];
    [self loadUI];
    
    if (!OBJ_IS_NIL(self.detailData)) {
        if (self.detailData.showType.integerValue == Model_Show_Type_2D) {
            self.type = Model_Show_Type_2D;
            [self downLoadModelFiles];
        } else if (self.detailData.showType.integerValue == Model_Show_Type_3D) {
            self.type = Model_Show_Type_3D;
            [self downLoadModelFiles];
        } else {
            [self.defaultShowImageView sd_setImageWithURL:[NSURL URLWithString:self.detailData.showUrl] placeholderImage:[UIImage imageNamed:@"default_model_Image"]];
        }
    }
}

- (void)showWaitingPop {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];//背景颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD show];
}

- (void)downLoadModelFiles {
    WS(weakSelf);

    NSString *tPath = [ATools getCachesHaveFile:[NSString stringWithFormat:@"%@/%@", self.detailData.fileName, self.detailData.showJson]];
    BOOL isHave = [ATools fileExistsAtPathForLocal:tPath];
    if (isHave) {
        [self load2DModelOr3DMoel];
        self.bottomProgressView.progress = 1.0;
        return;
    }
    [self showWaitingPop];
    
    __weak __typeof(&*self.bottomProgressView) weakProgressView = self.bottomProgressView;
    [AApiModel downloadFileFromServer:self.detailData.showUrl fileName:self.detailData.fileName block:^(BOOL result, NSString *filePathUrl) {
        if (result) {
            NSString*unzipPath = [ATools autoUnZipFile:filePathUrl fileName:@""];
            if (!STR_IS_NIL(unzipPath)) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [weakSelf load2DModelOr3DMoel];
                });
            } else {
                [SVProgressHUD dismiss];
                [weakSelf performSelector:@selector(faileErrorShowModel) withObject:nil afterDelay:1];
            }
        } else {
            [SVProgressHUD dismiss];
            [weakSelf performSelector:@selector(faileErrorShowModel) withObject:nil afterDelay:1];
        }
    } progress:^(double fractionCompleted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"进度条进度更新");
            [weakProgressView setProgress:fractionCompleted animated:YES];
        });
        
    }];
}

- (void)load2DModelOr3DMoel {
    if (self.type == Model_Show_Type_2D) {
        [self loadLive2D];
    } else if (self.type == Model_Show_Type_3D) {
        
    }
    self.bgImageView.hidden = YES;
    self.defaultShowImageView.hidden = YES;
}

- (void)faileErrorShowModel {
    [ATools showSVProgressHudCustom:@"" title:@"加载失败"];
}

- (void)loadLive2D {
    // Live2Dを初期化
    live2DMgr = new LAppLive2DManager();
    CGRect screen = [IPhoneUtil getScreenRect];
    LAppView* viewA = live2DMgr->createView(screen);
    
    live2DMgr->changeModel();
    
    UIView *liView = (UIView *)viewA;
    // 画面に表示
    [self.view addSubview:liView];
    
    [self.view sendSubviewToBack:liView];
    
    if (LAppDefine::DEBUG_LOG) NSLog(@"viewWillAppear @ViewController");
    live2DMgr->onResume();
}

- (void)clickButton:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1000:
            
            break;
        case 1001:
            
            break;
        case 1002:
            
            break;
        case 1003:
            
            break;
        case 2000://活动
            
            break;
        case 2001://福利
            
            break;
        case 2002://道具
            
            break;
        case 2003://信息
            
            break;
        case 3000://故事
            
            break;
        case 3001://动态
            
            break;
        case 3002://衣橱
            
            break;
        case 3003://任务
            
            break;
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    if (self.type == Model_Show_Type_2D) {
        if (live2DMgr == nil) {
            return;
        }
        if (LAppDefine::DEBUG_LOG) NSLog(@"viewDidUnload @ViewController");
        delete live2DMgr;
        live2DMgr=nil;
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.type == Model_Show_Type_2D) {
        if (live2DMgr == nil) {
            return;
        }
        if (LAppDefine::DEBUG_LOG) NSLog(@"viewWillDisappear @ViewController");
        live2DMgr->onPause();
    }

    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarTransparence:YES titleColor:[UIColor whiteColor]];
}

- (void)loadUI {
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.defaultShowImageView];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    self.progressView.backgroundColor = [UIColor blackColor];
    self.progressView.alpha = .5;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.view).mas_offset(0);
    }];
    [self.defaultShowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(16);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-16);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-[ATools setViewFrameBottomForIPhoneX:30]);
        make.top.mas_equalTo(self.view).mas_offset(130);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset([ATools setViewFrameBottomForIPhoneX:30]);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.progressView.mas_top).mas_offset(0);
        make.height.mas_offset(212);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(18);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(0);
        make.height.mas_offset(232);
        make.width.mas_offset(38);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-18);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(0);
        make.height.mas_offset(232);
        make.width.mas_offset(38);
    }];
    
    [self loadProgressSubView];
    [self loadBottomSubViews];
    [self loadSubButtons:self.leftArray direction:YES roorView:self.leftView];
    [self loadSubButtons:self.rightArray direction:NO roorView:self.rightView];
}

- (void)loadProgressSubView {
    self.bottomProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(18, 14, self.view.frame.size.width-18*2, 7)];
    _bottomProgressView.progressImage = [UIImage imageNamed:@"jindu_progress_"];//[UIColor whiteColor];
    _bottomProgressView.trackImage = [UIImage imageNamed:@"jindu_progress_bg_"];
    _bottomProgressView.progress = 0.01;
    [self.progressView addSubview:_bottomProgressView];
}

- (void)loadBottomSubViews {
    UIButton *storyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    storyButton.frame = CGRectMake(self.view.frame.size.width/2-99-10, 70, 99, 99);
    [storyButton setImage:[UIImage imageNamed:@"ms_big_icon_3"] forState:UIControlStateNormal];
    [storyButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    storyButton.tag = 3000;
    [self.bottomView addSubview:storyButton];
    UIButton *dymaicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dymaicButton.frame = CGRectMake(self.view.frame.size.width/2+10, 70, 99, 99);
    [dymaicButton setImage:[UIImage imageNamed:@"ms_big_icon_2"] forState:UIControlStateNormal];
    [dymaicButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    dymaicButton.tag = 3001;
    [self.bottomView addSubview:dymaicButton];
    UIButton *wardrobeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wardrobeButton.frame = CGRectMake(20, 20, 65, 65);
    [wardrobeButton setImage:[UIImage imageNamed:@"ms_big_icon_1"] forState:UIControlStateNormal];
    [wardrobeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    wardrobeButton.tag = 3002;
    [self.bottomView addSubview:wardrobeButton];
    UIButton *taskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    taskButton.frame = CGRectMake(self.view.frame.size.width-20-65, 20, 65, 65);
    [taskButton setImage:[UIImage imageNamed:@"ms_big_icon_4"] forState:UIControlStateNormal];
    [taskButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    taskButton.tag = 3003;
    [self.bottomView addSubview:taskButton];
}

- (void)loadSubButtons:(NSArray *)array direction:(BOOL)left roorView:(UIView *)rV {
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*38+i*20, 38, 38);
        [btn setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = (left == YES)?(1000+i):(2000+i);
        if (!left) {
            [btn setTitle:[self.rightTitleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
            [ATools setButtonContentCenter:btn];
            //btn.backgroundColor = [UIColor redColor];
        }
        [rV addSubview:btn];
    }
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"ms_back_view"];
    }
    return _bgImageView;
}

- (UIImageView *)defaultShowImageView {
    if (_defaultShowImageView == nil) {
        _defaultShowImageView = [[UIImageView alloc] init];
        _defaultShowImageView.image = [UIImage imageNamed:@"default_model_Image"];
    }
    return _defaultShowImageView;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor clearColor];
    }
    return _leftView;
}
- (UIView *)rightView {
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor clearColor];
    }
    return _rightView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}
- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
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
