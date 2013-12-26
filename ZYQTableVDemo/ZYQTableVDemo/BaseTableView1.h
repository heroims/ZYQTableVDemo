//
//  BaseTableView1.h
//  ZYQTableVDemo
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ZYQTableView.h"
#import "TableHeaderV.h"
#import "TableFooterV.h"

@interface BaseTableView1 : ZYQTableView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZYQTableViewDelegate>{
    BOOL isInit;
}

@property(nonatomic,assign)BOOL isEmpty;

@end
