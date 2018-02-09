//
//  ContentListView.m
//  acgn
//
//  Created by Ares on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "ContentListView.h"
#import "ContentListCell.h"
#import "ContentCom.h"
@interface ContentListView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ContentListView

- (void)testData {
    NSArray *array = [NSArray arrayWithObjects:
                      @"http://img.ui.cn/data/file/5/0/0/1574005.png",
                      @"http://img.ui.cn/data/file/8/0/0/1574008.png",
                      @"http://img.ui.cn/data/file/7/0/0/1574007.png",
                      @"http://img.ui.cn/data/file/1/8/9/1573981.png",
                      @"http://img.ui.cn/data/file/1/7/9/1573971.png", nil];
    for (int i = 0; i < array.count; i ++) {
        PeopleDataModel *obj = [[PeopleDataModel alloc] init];
        obj.imageUrl = [array objectAtIndex:i];
        obj.userName = [NSString stringWithFormat:@"东方红叶%d", i];
        obj.fansNum = [NSString stringWithFormat:@"%d", i+100];
        obj.source = [NSString stringWithFormat:@"中国%d", i];
        [self.datas addObject:obj];
    }
    
}

- (id)initWithFrame:(CGRect)frame delegate:(id<ContentListDelegate>) delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.datas = [NSMutableArray array];
        //[self testData];
        [self loadUI];
    }
    return self;
}

- (void)updateList:(NSMutableArray *)array {
    self.datas = array;
    [self.aTableView reloadData];
}

- (void)clickSelectedPeople:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag < self.datas.count) {
        PeopleDataModel *obj = [self.datas objectAtIndex:btn.tag];
        obj.isSelected = !obj.isSelected;
    }
    [self.aTableView reloadData];
}

- (CGFloat)getCellMaxHeight:(NSIndexPath *)indexPath {
    DynamicListData *data = [self.datas objectAtIndex:indexPath.section];
    if (!OBJ_IS_NIL(data)) {
        if (data.commentList.count > 0) {
            DynamicCommentListData *dynamicObj = [data.commentList objectAtIndex:indexPath.row];
            if (!OBJ_IS_NIL(dynamicObj)) {
                CGFloat commitH = [ATools getHeightByWidth:Info_Width title:dynamicObj.commentContext font:Commit_Font];
                CGFloat commitSecond = 0;
                NSInteger count =dynamicObj.secondView.count;
                if (count > 0) {
                    CGFloat commitListH = 30;//
                    if (count > 3) {
                        commitListH = commitListH + 28;
                    }
                    for (DynamicCommentSecondData *seObj in dynamicObj.secondView) {
                        NSString *content = [NSString stringWithFormat:@"%@@%@:%@",seObj.userName,seObj.otherName,seObj.commentContext];
                        CGFloat h = [ATools getHeightByWidth:Info_Width-SecondView_LeftRight_SPace*2 title:content font:Commit_Font];
                        commitListH = commitListH + h;
                    }
                    commitSecond = commitListH;
                }
                
                CGFloat heightRow = Content_List_Cell_H + commitH + commitSecond;
                return heightRow;
            }
        }
    }
    return 0;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(clickSelectRowAtIndexPath:)]) {
        [self.delegate clickSelectRowAtIndexPath:nil];
    }
}

#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.datas.count) {
        CGFloat H = [self getCellMaxHeight:indexPath];
        return H;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < self.datas.count) {
        DynamicListData *data = [self.datas objectAtIndex:section];
        if (!OBJ_IS_NIL(data)) {
            if (data.commentList.count > 0) {
                return data.commentList.count;
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cListCell = @"ContentListCell";
    ContentListCell *cell = [tableView dequeueReusableCellWithIdentifier:cListCell];
    if (!cell) {
        cell = [[ContentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cListCell];
    }
    
    if (self.datas.count > 0) {
        DynamicListData *data = [self.datas objectAtIndex:indexPath.section];
        if (!OBJ_IS_NIL(data)) {
            if (data.commentList.count > 0) {
                DynamicCommentListData *dynamicObj = [data.commentList objectAtIndex:indexPath.row];
                [cell configDynamicObj:dynamicObj];
            }
        }
    }
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    static NSString *cc = @"ContentCom";
    ContentCom *infoV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cc];
    if(infoV==nil) {
        infoV = [[ContentCom alloc]
                 initWithReuseIdentifier:cc
                 frame:CGRectMake(0, 0, self.aTableView.frame.size.width, 35)];
    }
    return infoV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *infoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.aTableView.frame.size.width, 5)];
    infoV.backgroundColor = [UIColor whiteColor];
    return infoV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)loadUI {
    [self addSubview:self.aTableView];
}

#pragma mark - 初始化UIKIT
- (UITableView *)aTableView {
    if (!_aTableView) {
        _aTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        //_aTableView.scrollEnabled = NO;
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _aTableView.backgroundColor = [UIColor whiteColor];//UIColorFromRGB(0xf6f6f6);

        
        UIView *fV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _aTableView.frame.size.width, 70)];
        fV.backgroundColor = [UIColor whiteColor];
        _aTableView.tableFooterView = fV;
    }
    return _aTableView;
}

@end
