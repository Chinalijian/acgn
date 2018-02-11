//
//  MyFavViewController.m
//  acgn
//
//  Created by lijian on 2018/2/5.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "MyFavViewController.h"
#import "ContentListView.h"
@interface MyFavViewController () <ContentListDelegate>
@property (nonatomic, strong) ContentListView *contentListView;
@property (nonatomic, strong) NSString *lastID;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation MyFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarTransparence:NO
                            titleColor:[UIColor whiteColor]];
    self.lastID = @"-1";
    self.datas = [NSMutableArray array];
    [self.view addSubview:self.contentListView];
    [self addRefreshLoadMore:self.contentListView.aTableView];
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
    [self loadData];
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

- (void)loadData {
    WS(weakSelf);
    [AApiModel getCollectionListForUser:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                if (weakSelf.lastID.intValue == -1) {
                    [weakSelf.datas removeAllObjects];
                }
                [weakSelf.datas addObjectsFromArray:array];
                [weakSelf updataAttentList:weakSelf.datas];
                DynamicListData *model = [array lastObject];
                weakSelf.lastID = model.collectionId;
            }
        }
        [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
    }];
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
