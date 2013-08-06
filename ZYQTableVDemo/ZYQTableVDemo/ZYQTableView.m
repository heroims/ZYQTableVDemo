//
//  ZYQTableView.m
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ZYQTableView.h"

@implementation ZYQTableView

#define DEFAULT_HEIGHT_OFFSET 52.0f

@synthesize headerView;
@synthesize footerView;

@synthesize isDragging;
@synthesize isRefreshing;
@synthesize isLoadingMore;

@synthesize canLoadMore;

@synthesize pullToRefreshEnabled;

@synthesize clearsSelectionOnViewWillAppear;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) initialize
{
    pullToRefreshEnabled = YES;
    
    canLoadMore = YES;
    
    clearsSelectionOnViewWillAppear = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])){
        [self initialize];
        self.frame = self.bounds;
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return self;

}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init
{
    if ((self = [super init])){
        [self initialize];
        self.frame = self.bounds;
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])){
        [self initialize];
        self.frame = self.bounds;
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//- (void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (clearsSelectionOnViewWillAppear) {
//        NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
//        if (selected)
//            [self.tableView deselectRowAtIndexPath:selected animated:animated];
//    }
//}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setHeaderView:(UIView *)aView
{
    if (!self)
        return;
    
    if (headerView && [headerView isDescendantOfView:self])
        [headerView removeFromSuperview];
    [headerView release]; headerView = nil;
    
    if (aView) {
        headerView = [aView retain];
        
        CGRect f = headerView.frame;
        headerView.frame = CGRectMake(f.origin.x, 0 - f.size.height, f.size.width, f.size.height);
        headerViewFrame = headerView.frame;
        
        [self addSubview:headerView];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat) headerRefreshHeight
{
    if (!CGRectIsEmpty(headerViewFrame))
        return headerViewFrame.size.height;
    else
        return DEFAULT_HEIGHT_OFFSET;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.contentInset = UIEdgeInsetsMake([self headerRefreshHeight], 0, 0, 0);
    }];
    [_pdelegate pinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.contentInset = UIEdgeInsetsZero;
    }];
    [_pdelegate pinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willBeginRefresh
{
    if (pullToRefreshEnabled)
        [self pinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willShowHeaderView:(UIScrollView *)scrollView
{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) refresh
{
    if (isRefreshing)
        [_pdelegate refresh:NO];
    
    [self willBeginRefresh];
    isRefreshing = YES;
    [_pdelegate refresh:YES];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) refreshCompleted
{
    isRefreshing = NO;
    
    if (pullToRefreshEnabled)
        [self unpinHeaderView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterView:(UIView *)aView
{
    if (!self)
        return;
    
    self.tableFooterView = nil;
    [footerView release]; footerView = nil;
    
    if (aView) {
        footerView = [aView retain];
        
        self.tableFooterView = footerView;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) loadMoreCompleted
{
    isLoadingMore = NO;
    [_pdelegate loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) loadMore
{
    if (isLoadingMore)
        [_pdelegate loadMore:NO];
    
    [_pdelegate willBeginLoadingMore];
    isLoadingMore = YES;
    [_pdelegate loadMore:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat) footerLoadMoreHeight
{
    if (footerView)
        return footerView.frame.size.height;
    else
        return DEFAULT_HEIGHT_OFFSET;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterViewVisibility:(BOOL)visible
{
    if (visible && self.tableFooterView != footerView)
        self.tableFooterView = footerView;
    else if (!visible)
        self.tableFooterView = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) allLoadingCompleted
{
    if (isRefreshing)
        [self refreshCompleted];
    if (isLoadingMore)
        [self loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollViewDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) tableViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isRefreshing)
        return;
    isDragging = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) tableViewDidScroll:(UIScrollView *)scrollView
{
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [_pdelegate headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight]) {
            [self loadMore];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isRefreshing)
        return;
    
    isDragging = NO;
    if (scrollView.contentOffset.y <= 0 - [self headerRefreshHeight]) {
        if (pullToRefreshEnabled)
            [self refresh];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) releaseViewComponents
{
    [headerView release]; headerView = nil;
    [footerView release]; footerView = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
    [self releaseViewComponents];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
