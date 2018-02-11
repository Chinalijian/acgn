//
//  PeopleDetailsViewController.m
//  acgn
//
//  Created by lijian on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "PeopleDetailsViewController.h"
#import "PeopleDetailCell.h"
#import "PeopleDetailHeader.h"
@interface PeopleDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *pTableView;
@property (nonatomic, strong) PeopleDetailHeader *headerView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) RoleDetailsDataModel *detailData;
@property (nonatomic, strong) NSString *lastID;
@end

@implementation PeopleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人详情";
    self.lastID = @"-1";
    self.datas = [NSMutableArray array];
    self.detailData = nil;//[[RoleDetailsDataModel alloc] init];
    [self.view addSubview:self.pTableView];
    
    [self addRefreshLoadMore:self.pTableView];
    
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
    if (self.detailData == nil) {
        [self getPeopleInfoDetails];
    }
    self.lastID = @"-1";
    [self getRoleDetails];
}

- (void)loadMore {
    [self getRoleDetails];
}

- (void)getPeopleInfoDetails {
    WS(weakSelf);
    [AApiModel getRoleInfoData:self.roleID block:^(BOOL result, RoleDetailsDataModel *obj) {
        if (result) {
            weakSelf.detailData = obj;
            CGFloat headerHeight = [PeopleDetailHeader getViewTotalHeight:obj];
            weakSelf.headerView.frame = CGRectMake(0, 0, weakSelf.pTableView.frame.size.width, headerHeight);
            weakSelf.pTableView.tableHeaderView = weakSelf.headerView;
            [weakSelf.headerView configInfo:obj];
            
        }
    }];
}

- (void)getRoleDetails {
    WS(weakSelf);
    [AApiModel getRoleDtailsListData:self.roleID lastId:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array > 0) {
                if (self.lastID.intValue == -1) {
                    [weakSelf.datas removeAllObjects];
                }
                [weakSelf.datas addObjectsFromArray:array];
                RoleDetailsPostData *data = [weakSelf.datas lastObject];
                weakSelf.lastID = data.postId;
            }
            [weakSelf.pTableView reloadData];
        }
        [weakSelf endRefreshing:weakSelf.pTableView];
    }];
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.datas.count) {
        RoleDetailsPostData *data = [self.datas objectAtIndex:indexPath.row];
        CGFloat height = [PeopleDetailCell getPeopleDetailCellHeight:data];
        return height;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *peopleDCell = @"peopleDCell";
    PeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:peopleDCell];
    if (!cell) {
        cell = [[PeopleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:peopleDCell];
    }
    
    if (self.datas.count > 0) {
        RoleDetailsPostData *data = [self.datas objectAtIndex:indexPath.row];
        [cell configInfo:data];
    }
    
    return cell;
}
#pragma mark - 初始化UIKIT
- (UITableView *)pTableView {
    if (!_pTableView) {
        _pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DMScreenHeight-DMNavigationBarHeight) style:UITableViewStylePlain];
        _pTableView.delegate = self;
        _pTableView.dataSource = self;
        _pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _pTableView.backgroundColor = [UIColor whiteColor];//UIColorFromRGB(0xf6f6f6);
        //_pTableView.tableHeaderView = self.headerView;
    }
    return _pTableView;
}

#pragma mark - 初始化UIKIT
- (PeopleDetailHeader *)headerView {
    if (!_headerView) {
        _headerView = [[PeopleDetailHeader alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
