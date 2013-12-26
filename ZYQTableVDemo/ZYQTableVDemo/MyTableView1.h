//
//  MyTableView1.h
//  ZYQTableVDemo
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "BaseTableView1.h"

@interface MyTableView1 : BaseTableView1<UITableViewDelegate,UITableViewDataSource,ZYQTableViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *items;
}

- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;

@end
