//
//  SquareViewController.m
//  acgn
//
//  Created by lijian on 2018/2/5.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "SquareViewController.h"
#import "ContentListView.h"
@interface SquareViewController () <ContentListDelegate>
@property (nonatomic, strong) ContentListView *contentListView;
@property (nonatomic, strong) NSString *lastID;
@property (nonatomic, strong) NSMutableArray *squareArray;
@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.squareArray = [NSMutableArray array];
    self.lastID = @"-1";
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
    [self getSquareListData];
    
}

- (void)loadMore {
    [self getSquareListData];
}

-(void)updataAttentList:(NSMutableArray *)array {
    [self.contentListView updateList:array];
}

- (void)getSquareListData {
    WS(weakSelf);
    [AApiModel getHomePostList:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                if (weakSelf.lastID.intValue > -1) {
                    [weakSelf.squareArray addObjectsFromArray:array];
                } else {
                    [weakSelf.squareArray removeAllObjects];
                    [weakSelf.squareArray addObjectsFromArray:array];
                }
                [weakSelf updataAttentList:weakSelf.squareArray];
                DynamicListData *model = [array lastObject];
                weakSelf.lastID = model.postId;
            } else {

            }
        }
        [weakSelf endRefreshing:weakSelf.contentListView.aTableView];
    }];
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
