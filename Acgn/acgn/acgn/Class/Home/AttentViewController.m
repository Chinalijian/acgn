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
            [arrayRoleIDs addObject:model.roleId];
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
            if (array.count > 0) {
                if (weakSelf.lastID.intValue > -1) {
                    [weakSelf.attentListDatas addObjectsFromArray:array];
                } else {
                    [weakSelf.attentListDatas removeAllObjects];
                    [weakSelf.attentListDatas addObjectsFromArray:array];
                }
                [weakSelf updataAttentList:weakSelf.attentListDatas];
                DynamicListData *model = [array lastObject];
                weakSelf.lastID = model.postId;
            } else {
               // [weakSelf.contentListView.aTableView.mj_footer endRefreshingWithNoMoreData];
            }
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

-(void)updataAttentList:(NSMutableArray *)array {
    [self.contentListView updateList:array];
}

- (void)removePeopleListView {
    self.apListView.hidden = YES;
    [self.apListView removeFromSuperview];
    self.apListView = nil;
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
