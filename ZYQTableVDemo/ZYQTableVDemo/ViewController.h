//
//  ViewController.h
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQTableView.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ZYQTableViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *items;
    ZYQTableView *tableV;
}
@end
