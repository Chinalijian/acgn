//
//  DynamicDetailsViewController.m
//  acgn
//
//  Created by lijian on 2018/2/11.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "DynamicDetailsViewController.h"
#import "ContentListView.h"
@interface DynamicDetailsViewController () <ContentListDelegate>
@property (nonatomic, strong) ContentListView *contentListView;
@property (nonatomic, strong) NSMutableArray *commitArray;
@property (nonatomic, strong) NSString *lastID;

@property (nonatomic, strong) NSMutableArray *detailsData;
@property (nonatomic, strong) DynamicListData *obj;

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
    [self addRefreshLoadMore:self.contentListView.aTableView];
}

- (void)loadData {
    [self getPostDetailsData];
}

- (void)getPostDetailsData {
    WS(weakSelf);
    [AApiModel getPostDetilsData:self.postID block:^(BOOL result, DynamicListData *obj) {
        if (result) {
            if (!OBJ_IS_NIL(obj)) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
