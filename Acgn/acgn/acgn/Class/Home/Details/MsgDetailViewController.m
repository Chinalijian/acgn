//
//  MsgDetailViewController.m
//  acgn
//
//  Created by lijian on 2018/2/12.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "MsgDetailViewController.h"
#import "ContentListCell.h"
@interface MsgDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSString *lastID;
@property (nonatomic, strong) SendMsgInputTextView *inputView;
@end

@implementation MsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"吐槽详情";
    self.datas = [NSMutableArray array];
    [self loadUI];
    [self addRefreshLoadMore:self.mTableView];
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

- (void)loadData {
    WS(weakSelf);
    [AApiModel getGetCommentDetailsData:self.commitID lastId:self.lastID block:^(BOOL result, NSArray *array) {
        if (result) {
            if (array.count > 0) {
                if (weakSelf.lastID.integerValue == -1) {
                    [weakSelf.datas removeAllObjects];
                }
                [weakSelf.datas addObjectsFromArray:array];
                DynamicCommentListData *data = [weakSelf.datas lastObject];
                weakSelf.lastID = data.commentId;
            }
            [weakSelf.mTableView reloadData];
        }
        [weakSelf endRefreshing:weakSelf.mTableView];
    }];
    
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.datas.count) {
        DynamicCommentListData *data = [self.datas objectAtIndex:indexPath.row];
        CGFloat h = [ContentListCell getCellMaxHeightAndUpdate:data];
        return h;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cListCell = @"ContentListCellD";
    ContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:cListCell];
    if (!cell) {
        cell = [[ContentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cListCell];
        [self showLineForTableView:cell];
    }
    if (indexPath.row < self.datas.count) {
        DynamicCommentListData *data = [self.datas objectAtIndex:indexPath.row];
        [cell configDynamicObj:data];
    }
    if (indexPath.row == 0) {
        cell.backgroundColor = UIColorFromRGB(0xF5FAFD);
    } else {
        cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    }
    
    
    return cell;
}

- (void)showLineForTableView:(ContentListCell *)cell {
    UILabel *lineLable = [[UILabel alloc] init];
    lineLable.backgroundColor = UIColorFromRGB(0xC3C3C3);
    [cell addSubview:lineLable];
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cell.mas_bottom).offset(0);
        make.height.mas_offset(1);
        make.left.right.mas_equalTo(cell).offset(0);
    }];
}

- (void)loadUI {
    [self.view addSubview:self.mTableView];
    [self.view addSubview:self.inputView];
}

#pragma mark - 初始化UIKIT
- (UITableView *)mTableView {
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DMScreenWidth, DMScreenHeight-DMNavigationBarHeight) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTableView.backgroundColor = [UIColor whiteColor];

    }
    return _mTableView;
}
- (SendMsgInputTextView *)inputView {
    if (_inputView == nil) {
        CGFloat HX = 0;
        if (IS_IPHONE_X) {
            HX = 35;
        }
        _inputView = [[SendMsgInputTextView alloc] initWithFrame:CGRectMake(0, DMScreenHeight-DMNavigationBarHeight-55-HX, DMScreenWidth, 55)];
        _inputView.bgColor = UIColorFromRGB(0xF2F2F2);
        _inputView.showLimitNum = NO;
        _inputView.font = [UIFont systemFontOfSize:18];
        _inputView.limitNum = 1000;
    }
    return _inputView;
}


@end
