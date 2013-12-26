//
//  BaseTableView1.m
//  ZYQTableVDemo
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "BaseTableView1.h"

@implementation BaseTableView1

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        self.pdelegate=self;
        self.canPullToRefresh=NO;
        
        TableHeaderV *headerView = (TableHeaderV *)[[[NSBundle mainBundle] loadNibNamed:@"TableHeaderV" owner:self options:nil] objectAtIndex:0];
        self.headerView=headerView;
        
        TableFooterV *footerView = (TableFooterV *)[[[NSBundle mainBundle] loadNibNamed:@"TableFooterV" owner:self options:nil] objectAtIndex:0];
        self.footerView = footerView;
        
        isInit=YES;
        
        
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        self.pdelegate=self;
        self.canPullToRefresh=NO;
        
        TableHeaderV *headerView = (TableHeaderV *)[[[NSBundle mainBundle] loadNibNamed:@"TableHeaderV" owner:self options:nil] objectAtIndex:0];
        self.headerView=headerView;
        
        TableFooterV *footerView = (TableFooterV *)[[[NSBundle mainBundle] loadNibNamed:@"TableFooterV" owner:self options:nil] objectAtIndex:0];
        self.footerView = footerView;
        
        isInit=YES;
        
        
        // Initialization code
    }
    return self;
}

#pragma mark - BaseTableView DataSource
-(void)loadMoreData{
}

-(void)refreshData{
    
}
#pragma mark - ZYQTableViewDelegate

#pragma mark  Pull to Refresh

- (void) pinHeaderView
{
    TableHeaderV *fv = (TableHeaderV *)self.headerView;
    [fv.aiv startAnimating];
    
    fv.aiv.hidden=NO;
    fv.lblText.text = @"正在加载...";

}

- (void) unpinHeaderView
{
    TableHeaderV *fv = (TableHeaderV *)self.headerView;
    [fv.aiv stopAnimating];
    fv.aiv.hidden=YES;
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView{
    TableHeaderV *fv = (TableHeaderV *)self.headerView;
    fv.aiv.hidden=YES;
    [fv.aiv stopAnimating];

    if (willRefreshOnRelease)
       fv.lblText.text = @"释放刷新...";
    else
       fv.lblText.text = @"下拉刷新...";
}

- (void) refresh:(BOOL)isRefresh{
    if (!isRefresh)
        return ;
    [self performSelector:@selector(refreshData) withObject:nil];
    
}

#pragma mark  Load More

- (void) willBeginLoadingMore
{
    TableFooterV *fv = (TableFooterV *)self.footerView;
    [fv.aiv startAnimating];
    
    fv.aiv.hidden=NO;
    fv.lblText.text = @"正在加载...";
    
}

- (void) loadMoreCompleted
{
    
    TableFooterV *fv = (TableFooterV *)self.footerView;
    [fv.aiv stopAnimating];
    
    fv.aiv.hidden=YES;
    fv.aiv.hidden=YES;
    if (self.canLoadMore) {
        if (self.isEmpty) {
            fv.lblText.text = @"";
        }else{
            fv.lblText.text = @"上拉加载更多";
        }
    }
    else{
        if (self.isEmpty) {
            fv.lblText.text = @"";
        }else{
            fv.lblText.text = @"没有更多了";
        }
    }
}


- (void) loadMore:(BOOL)isLoadMore
{
    if (!isLoadMore||!isInit){
        return ;
    }
    
    // Do your async loading here
    [self performSelector:@selector(loadMoreData) withObject:nil];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
}

#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


#pragma mark - UIScrollView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self tableViewWillBeginDragging:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self tableViewDidScroll:scrollView];
    if (scrollView.contentOffset.y<0) {
        NSLog(@"header: %f",-scrollView.contentOffset.y/44);
    }
    
    if ((self.contentSize.height-(scrollView.contentOffset.y+scrollView.frame.size.height)-self.footerView.frame.size.height)<0) {
        NSLog(@"footer: %f",-(self.contentSize.height-(scrollView.contentOffset.y+scrollView.frame.size.height)-self.footerView.frame.size.height)/self.footerView.frame.size.height);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self tableViewDidEndDragging:scrollView willDecelerate:decelerate];    
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
