//
//  AttentViewController.m
//  acgn
//
//  Created by lijian on 2018/2/5.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "AttentViewController.h"
#import "AttentionPeopleList.h"
#import "ContentListView.h"
@interface AttentViewController () <AttentionPeopleListDelegate, ContentListDelegate>
@property (nonatomic, strong) AttentionPeopleList *apListView;
@property (nonatomic, strong) ContentListView *contentListView;

@property (nonatomic, strong) NSString *lastPeopleID;
@property (nonatomic, strong) NSMutableArray *roleListDatas;
@property (nonatomic, strong) NSMutableArray *noFollowIDs;

@property (nonatomic, strong) NSString *lastID;
@property (nonatomic, strong) NSMutableArray *attentListDatas;

@end

@implementation AttentViewController

- (void)notificationAll {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUserInfo:)
                                                 name:DMNotification_Login_Success_Key
                                               object:nil];
}

- (void)updateUserInfo:(NSNotification *)notification {
    NSString *hasCollection = [AccountInfo getHasFollowStatus];
    self.roleListDatas = [NSMutableArray array];
    self.noFollowIDs = [NSMutableArray array];//不关注的roleID列表
    [self.attentListDatas removeAllObjects];
    self.lastID = @"-1";
    self.lastPeopleID = @"-1";
    if (hasCollection.intValue > 0) {
        [self addRefreshLoadMore:self.contentListView.aTableView];
        [self.contentListView.aTableView reloadData];
        [self removePeopleListView];
        [self attentDynamicList];
    } else {
        [self.view addSubview:self.apListView];
        [self addRefreshLoadMore:self.apListView.aTableView];
        [self getRoleListData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.attentListDatas = [NSMutableArray array];
    self.lastID = @"-1";
    [self.view addSubview:self.contentListView];
    if (STR_IS_NIL([AccountInfo getUserID])) {
        self.roleListDatas = [NSMutableArray array];
        self.noFollowIDs = [NSMutableArray array];//不关注的roleID列表
        self.lastPeopleID = @"-1";
        [self.view addSubview:self.apListView];
        [self addRefreshLoadMore:self.apListView.aTableView];
    } else {
        [self addRefreshLoadMore:self.contentListView.aTableView];
    }
    
    [self notificationAll];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    if (!STR_IS_NIL([AccountInfo getUserID])) {
        self.lastID = @"-1";
        [self attentDynamicList];
        return;
    }
    self.lastPeopleID = @"-1";
    [self getRoleListData];
    
}

- (void)loadMore {
    
    if (!STR_IS_NIL([AccountInfo getUserID])) {
        [self attentDynamicList];
        return;
    }
    [self getRoleListData];
}

- (void)getRoleListData {
    WS(weakSelf);
    [AApiModel getRoleListForHome:self.lastPeopleID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                if (weakSelf.lastPeopleID.intValue > -1) {
                    [weakSelf.roleListDatas addObjectsFromArray:array];
                } else {
                    [weakSelf.roleListDatas removeAllObjects];
                    [weakSelf.roleListDatas addObjectsFromArray:array];
                }
                [weakSelf.apListView updateList:weakSelf.roleListDatas];
                
                PeopleDataModel *model = [array lastObject];
                weakSelf.lastPeopleID = model.roleId;
            }
        }
        [weakSelf endRefreshing:weakSelf.apListView.aTableView];
    }];
}

- (void)requestAttentPeoples {
    NSMutableArray *arrayRoleIDs = [NSMutableArray array];
    for (PeopleDataModel *model in self.roleListDatas) {
        if (![self.noFollowIDs containsObject:model.roleId]) {
            [arrayRoleIDs addObject:[NSNumber numberWithInt:model.roleId.intValue]];
        } else {
            [self.noFollowIDs removeObject:model.roleId];
        }
    }
    WS(weakSelf);
    //添加关注请求接口
    [AApiModel addFollowForUser:arrayRoleIDs block:^(BOOL result) {
        if (result) {
            //[weakSelf attentDynamicList];
            [weakSelf removePeopleListView];
            [weakSelf addRefreshLoadMore:weakSelf.contentListView.aTableView];
        } else { }
    }];
}

- (void)clickSelectedPeople:(BOOL)follow roleId:(NSString *)roleId {
    if (follow) {
        //添加关注选择
        if ([self.noFollowIDs containsObject:roleId]) {
            [self.noFollowIDs removeObject:roleId];
        }
    } else {
        //取消关注选择
        if (![self.noFollowIDs containsObject:roleId]) {
            [self.noFollowIDs addObject:roleId];
        }
    }
    NSLog(@"不关注的列表 = %@", self.noFollowIDs);
}

- (void)attentDynamicList {
    WS(weakSelf);
    [AApiModel getHomeAttentList:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (weakSelf.lastID.intValue == -1) {
                [weakSelf.attentListDatas removeAllObjects];
            }
            if (!OBJ_IS_NIL(array) && array.count > 0) {
                [weakSelf.attentListDatas addObjectsFromArray:array];
            }
            [weakSelf updataAttentList:weakSelf.attentListDatas];
            DynamicListData *model = [array lastObject];
            weakSelf.lastID = model.postId;
        } else {
               // [weakSelf.contentListView.aTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
    }];
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

- (void)clickPraiseUser:(id)sender { //点评论
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

- (void)clickFavUser:(id)sender view:(id)viewSelf {
    DynamicListData *obj = (DynamicListData *)sender;
    ContentCom *cc = (ContentCom *)viewSelf;
    if (obj.hasCollection.intValue == 0) {
        [AApiModel addCollectionForUser:obj.postId roleId:obj.roleId block:^(BOOL result) {
            if (result) {
                obj.hasCollection = @"1";
                [cc updateCollectionView];
            }
        }];
    } else {
        [AApiModel delCollectionForUser:obj.postId block:^(BOOL result) {
            if (result) {
                obj.hasCollection = @"0";
                [cc updateCollectionView];
            }
        }];
    }
}

- (void)clickSelectRowAtIndexPath:(id)obj {
    DynamicListData *data = (DynamicListData *)obj;
    DynamicDetailsViewController *ddVC = [[DynamicDetailsViewController alloc] init];
    ddVC.postID = data.postId;
    [self.navigationController pushViewController:ddVC animated:YES];
}

- (void)clickPeopleHead:(NSString *)roleID {
    PeopleDetailsViewController *peopleVC = [[PeopleDetailsViewController alloc] init];
    peopleVC.roleID = roleID;
    [self.navigationController pushViewController:peopleVC animated:YES];
}

-(void)updataAttentList:(NSMutableArray *)array {
    [self.contentListView updateList:array];
}

- (void)removePeopleListView {
    if (self.apListView != nil) {
        self.apListView.hidden = YES;
        [self.apListView removeFromSuperview];
        self.apListView = nil;
    }
}

-(AttentionPeopleList *)apListView{
    if (_apListView == nil) {
        _apListView = [[AttentionPeopleList alloc] initWithFrame:
                       CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) delegate:self];
        _apListView.backgroundColor = [UIColor whiteColor];
    }
    return _apListView;
}

- (ContentListView *)contentListView {
    if (_contentListView == nil) {
        _contentListView = [[ContentListView alloc] initWithFrame:
                            CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) delegate:self];
        _contentListView.backgroundColor = [UIColor whiteColor];
    }
    return _contentListView;
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
