//
//  BaseTableView.h
//  PhotoAlbum
//
//  Created by apple on 13-8-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ZYQTableView.h"
#import "SRRefreshView.h"
#import "TableFooterV.h"

@interface BaseTableView : ZYQTableView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZYQTableViewDelegate,SRRefreshDelegate>{
    BOOL isInit;
}

@property(nonatomic,retain)SRRefreshView *slimeView;

@end
