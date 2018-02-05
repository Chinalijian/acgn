//
//  PeopleListCell.h
//  acgn
//
//  Created by lijian on 2018/2/6.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleListDataModel.h"
#define People_List_Cell_H 316
@interface PeopleListCell : UITableViewCell
- (void)configPeopleInfo:(PeopleDataModel *)objL objRight:(PeopleDataModel *)objR;
@end
