//
//  ZYQTableView.h
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYQTableViewDelegate <NSObject>

@optional
#pragma mark - Pull to Refresh

- (void) pinHeaderView;

- (void) unpinHeaderView;

- (void) refresh:(BOOL)isRefresh;

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView;

#pragma mark - Load More

- (void) loadMore:(BOOL)isLoadMore;

- (void) willBeginLoadingMore;

- (void) loadMoreCompleted;

@end

@interface ZYQTableView : UITableView<UIScrollViewDelegate> {
    
@protected
    
    BOOL isDragging;
    BOOL isRefreshing;
    BOOL isLoadingMore;
    
    CGRect headerViewFrame;
}
// The view used for "pull to refresh"
@property (nonatomic, retain) UIView *headerView;

// The view used for "load more"
@property (nonatomic, retain) UIView *footerView;

@property (readonly) BOOL isDragging;
@property (readonly) BOOL isRefreshing;
@property (readonly) BOOL isLoadingMore;

// Defaults to YES
@property (nonatomic) BOOL canLoadMore;
@property (nonatomic) BOOL canPullToRefresh;

@property (nonatomic,assign)id<ZYQTableViewDelegate> pdelegate;

// Default Config
- (void) initialize;

- (void) setFooterViewVisibility:(BOOL)visible;
- (void) setHeaderViewVisibility:(BOOL)visible;
- (void) refresh;
- (void) loadMore;

// Must insert in your refresh or loadMore
- (void) loadMoreCompleting;
- (void) refreshCompleting;

// Must insert in your scrollViewDelegate
- (void) tableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) tableViewDidScroll:(UIScrollView *)scrollView;
- (void) tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
