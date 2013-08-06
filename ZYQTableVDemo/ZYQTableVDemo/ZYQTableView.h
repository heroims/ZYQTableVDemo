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

// The minimum height that the user should drag down in order to trigger a "refresh" when
// dragging ends.
- (CGFloat) headerRefreshHeight;

// Will be called if the user drags down which will show the header view. Override this to
// update the header view (e.g. change the label to "Pull down to refresh").
- (void) willShowHeaderView:(UIScrollView *)scrollView;

// If the user is dragging, will be called on every scroll event that the headerView is shown.
// The value of willRefreshOnRelease will be YES if the user scrolled down enough to trigger a
// "refresh" when the user releases the drag.
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView;

// By default, will permanently show the headerView by setting the tableView's contentInset.
- (void) pinHeaderView;

// Reverse of pinHeaderView.
- (void) unpinHeaderView;

// Called when the user stops dragging and, if the conditions are met, will trigger a refresh.
- (void) willBeginRefresh;

// Override to perform fetching of data. The parent method [super refresh] should be called first.
// If the value is NO, -refresh should be aborted.
- (void) refresh:(BOOL)isRefresh;

// Call to signal that refresh has completed. This will then hide the headerView.
- (void) refreshCompleted;

#pragma mark - Load More

// The value of the height starting from the bottom that the user needs to scroll down to in order
// to trigger -loadMore. By default, this will be the height of -footerView.
- (CGFloat) footerLoadMoreHeight;

// Override to perform fetching of next page of data. It's important to call and get the value of
// of [super loadMore] first. If it's NO, -loadMore should be aborted.
- (void) loadMore:(BOOL)isLoadMore;

// Called when all the conditions are met and -loadMore will begin.
- (void) willBeginLoadingMore;

// Call to signal that "load more" was completed. This should be called so -isLoadingMore is
// properly set to NO.
- (void) loadMoreCompleted;

// Helper to show/hide -footerView
- (void) setFooterViewVisibility:(BOOL)visible;

@end

@interface ZYQTableView : UITableView<UIScrollViewDelegate> {
    
@protected
    
    BOOL isDragging;
    BOOL isRefreshing;
    BOOL isLoadingMore;
    
    // had to store this because the headerView's frame seems to be changed somewhere during scrolling
    // and I couldn't figure out why >.<
    CGRect headerViewFrame;
}
// The view used for "pull to refresh"
@property (nonatomic, retain) UIView *headerView;

// The view used for "load more"
@property (nonatomic, retain) UIView *footerView;

@property (readonly) BOOL isDragging;
@property (readonly) BOOL isRefreshing;
@property (readonly) BOOL isLoadingMore;
@property (nonatomic) BOOL canLoadMore;

@property (nonatomic) BOOL pullToRefreshEnabled;

// Defaults to YES
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

@property (nonatomic,assign)id<ZYQTableViewDelegate> pdelegate;
// Just a common initialize method
- (void) initialize;

- (void) loadMoreCompleted;
- (void) refreshCompleted;
- (void) refresh;
- (void) loadMore;

- (void) tableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) tableViewDidScroll:(UIScrollView *)scrollView;
- (void) tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
