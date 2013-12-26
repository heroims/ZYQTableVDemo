//
//  BaseTableView.m
//  PhotoAlbum
//
//  Created by apple on 13-8-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        self.pdelegate=self;
        self.canPullToRefresh=NO;
        
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        _slimeView.slime.skinColor = [UIColor whiteColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = _slimeView.slime.bodyColor;
        
        [self addSubview:_slimeView];
        
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
        
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        _slimeView.slime.skinColor = [UIColor whiteColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = _slimeView.slime.bodyColor;
        
        [self addSubview:_slimeView];

        TableFooterV *footerView = (TableFooterV *)[[[NSBundle mainBundle] loadNibNamed:@"TableFooterV" owner:self options:nil] objectAtIndex:0];
        self.footerView = footerView;

        isInit=YES;


        // Initialization code
    }
    return self;
}

#pragma mark - SRRefreshView Delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self performSelector:@selector(refreshData)
               withObject:nil];
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
    
}

- (void) unpinHeaderView
{
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView{
}

- (void) refresh:(BOOL)isRefresh{
    if (!isRefresh)
        return ;
    
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
    [_slimeView scrollViewDidScroll];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self tableViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    [_slimeView scrollViewDidEndDraging];
    
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
