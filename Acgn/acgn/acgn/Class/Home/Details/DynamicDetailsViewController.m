//
//  DynamicDetailsViewController.m
//  acgn
//
//  Created by lijian on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "DynamicDetailsViewController.h"
#import "ContentListView.h"
#import "MsgDetailViewController.h"
@interface DynamicDetailsViewController () <ContentListDelegate, SendMsgDeInputDelegate>
@property (nonatomic, strong) ContentListView *contentListView;
@property (nonatomic, strong) NSMutableArray *commitArray;
@property (nonatomic, strong) NSString *lastID;

@property (nonatomic, strong) NSMutableArray *detailsData;
@property (nonatomic, strong) DynamicListData *obj;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) SendMsgInputTextView *inputView;

@end

@implementation DynamicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动态详情";
    self.lastID = @"-1";
    self.detailsData = [NSMutableArray array];
    self.commitArray = [NSMutableArray array];
    [self.view addSubview:self.contentListView];
    //[self.view addSubview:self.bottomView];
    [self.view addSubview:self.inputView];
    [self addRefreshLoadMore:self.contentListView.aTableView];
}

- (void)loadData {
    [self getPostDetailsData];
}

- (void)clickPraiseUser:(id)sender {
    WS(weakSelf);
    DynamicCommentListData *data = (DynamicCommentListData *)sender;
    if (data.localPraise) {
        [AApiModel delPraiseForUser:data.postId commentId:data.commentId block:^(BOOL result, NSString *praiseNum) {
            if (result) {
                data.localPraise = NO;
                data.praiseNum = praiseNum;//[NSString stringWithFormat:@"%d", data.praiseNum.intValue-1];
            }
            [weakSelf.contentListView.aTableView reloadData];
        }];
    } else {
        [AApiModel addPraiseForUser:data.postId commentId:data.commentId block:^(BOOL result, NSString *praiseNum) {
            if (result) {
                data.localPraise = YES;
                data.praiseNum = praiseNum;//[NSString stringWithFormat:@"%d", data.praiseNum.intValue+1];
            }
            [weakSelf.contentListView.aTableView reloadData];
        }];
    }
}

- (void)clickPraiseFabulous:(id)sender  view:(id)viewSelf {
    //WS(weakSelf);
    DynamicListData *data = (DynamicListData *)sender;
    ContentCom *cc = (ContentCom *)viewSelf;
    if (data.localPraise) {
        [AApiModel delFabulousForUser:data.postId block:^(BOOL result, NSString *praiseNum) {
            if (result) {
                data.localPraise = NO;
                data.fabulousNum = praiseNum;//[NSString stringWithFormat:@"%d", data.praiseNum.intValue-1];
            }
            [cc updateFabulous];
        }];
        
    } else {
        [AApiModel addFabulousForUser:data.postId block:^(BOOL result, NSString *praiseNum) {
            if (result) {
                data.localPraise = YES;
                data.fabulousNum = praiseNum;//[NSString stringWithFormat:@"%d", data.praiseNum.intValue+1];
            }
            [cc updateFabulous];
        }];
        
    }
}
- (void)getPostDetailsData {
    WS(weakSelf);
    [AApiModel getPostDetilsData:self.postID block:^(BOOL result, DynamicListData *obj) {
        if (result) {
            if (!OBJ_IS_NIL(obj)) {
                if (weakSelf.lastID.intValue == -1) {
                    [weakSelf.detailsData removeAllObjects];
                }
                [weakSelf.detailsData addObject:obj];
                weakSelf.obj = obj;
                [weakSelf getPostCommitData];
                [weakSelf updataAttentList:weakSelf.detailsData];
            } else {
                [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
            }
        } else {
            [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
        }
    }];
}

- (void)getPostCommitData {
    WS(weakSelf);
    [AApiModel getPostCommentListData:self.postID lastId:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                if (weakSelf.lastID.intValue == (-1)) {
                    [weakSelf.commitArray removeAllObjects];
                }
                [weakSelf.commitArray addObjectsFromArray:array];
                weakSelf.obj.commentList = weakSelf.commitArray;
                [weakSelf updataAttentList:weakSelf.detailsData];
                DynamicCommentListData *model = [array lastObject];
                weakSelf.lastID = model.commentId;
            }
        }
        [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
    }];
}

- (void)clickSelectRowAtIndexPathForCommit:(id)obj {
    DynamicCommentListData *data = (DynamicCommentListData *)obj;
    MsgDetailViewController *msdDetailVC = [[MsgDetailViewController alloc] init];
    msdDetailVC.obj = data;
    [self.navigationController pushViewController:msdDetailVC animated:YES];
}

- (void)addRefreshLoadMore:(UITableView *)tableView {
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [tableView.mj_header beginRefreshing];
}

- (void)endRefreshing:(UITableView *)tableView {
    [tableView.mj_footer endRefreshing];
    [tableView.mj_header endRefreshing];
}

- (void)refresh {
    self.lastID = @"-1";
    [self loadData];
}

- (void)loadMore {
    [self getPostCommitData];
}


- (void)inputContent:(NSString *)content {
    DynamicCommentListData *resultData = [[DynamicCommentListData alloc] init];
    resultData.commentContext = content;
    resultData.commentUid = [AccountInfo getUserID];
    resultData.postId = self.postID;
    resultData.isRole = @"";
    resultData.parentCommentId = @"";
    resultData.type = @"1";
    resultData.replyId = @"";
    resultData.replyUid = @"";
    resultData.roleId = @"";
    resultData.replyContext = @"";
    
    WS(weakSelf);
    [AApiModel addCommentForUser:resultData block:^(BOOL result) {
        if (result) {
            [weakSelf refresh];
        }
    }];
}

- (void)clickPeopleHead:(NSString *)roleID {
    PeopleDetailsViewController *peopleVC = [[PeopleDetailsViewController alloc] init];
    peopleVC.roleID = roleID;
    [self.navigationController pushViewController:peopleVC animated:YES];
}

-(void)updataAttentList:(NSMutableArray *)array {
    [self.contentListView updateList:array];
}

- (ContentListView *)contentListView {
    if (_contentListView == nil) {
        _contentListView = [[ContentListView alloc] initWithFrame:
                            CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) delegate:self];
        _contentListView.backgroundColor = [UIColor whiteColor];
    }
    return _contentListView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        CGFloat B = 50;
        if (IS_IPHONE_X) {
            B = B + 44;
        }
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, DMScreenHeight-150, DMScreenWidth, B)];
        _bottomView.backgroundColor = UIColorFromRGB(0xF2F2F2);
    }
    return _bottomView;
}

- (SendMsgInputTextView *)inputView {
    if (_inputView == nil) {
        CGFloat HX = 0;
        if (IS_IPHONE_X) {
            HX = 35;
        }
        _inputView = [[SendMsgInputTextView alloc] initWithFrame:CGRectMake(0, DMScreenHeight-DMNavigationBarHeight-55-HX, DMScreenWidth, 65)];
        _inputView.bgColor = UIColorFromRGB(0xF2F2F2);
        _inputView.showLimitNum = NO;
        _inputView.font = [UIFont systemFontOfSize:18];
        _inputView.limitNum = 1000;
        _inputView.delegate = self;
    }
    return _inputView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
