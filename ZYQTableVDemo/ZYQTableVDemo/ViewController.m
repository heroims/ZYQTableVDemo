//
//  ViewController.m
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

@interface ViewController ()
- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [items removeAllObjects];
    [items release];
    [tableV release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    tableV=[[ZYQTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.pdelegate=self;
    [self.view addSubview:tableV];
    
    
    [tableV setBackgroundColor:[UIColor lightGrayColor]];
    
    // set the custom view for "pull to refresh". See DemoTableHeaderView.xib.
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil] objectAtIndex:0];
    tableV.headerView = headerView;
    
    // set the custom view for "load more". See DemoTableFooterView.xib.
//    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[[[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil] objectAtIndex:0];
    tableV.footerView = footerView;
    
    // add sample items
    items = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
        [items addObject:[self createRandomValue]];

	// Do any additional setup after loading the view.
}

#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)tableV.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"加载中...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
    
    // do custom handling for the header view
    [[(DemoTableHeaderView *)tableV.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)tableV.headerView;
    if (willRefreshOnRelease)
        hv.title.text = @"释放刷新...";
    else
        hv.title.text = @"下拉刷新...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (void) refresh:(BOOL)isRefresh
{
    if (!isRefresh)
        return ;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more).
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)tableV.footerView;
    [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void) loadMoreCompleted
{
    
    DemoTableFooterView *fv = (DemoTableFooterView *)tableV.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!tableV.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) loadMore:(BOOL)isLoadMore
{
    if (!isLoadMore)
        return ;
    
    // Do your async loading here
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Dummy data methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
    for (int i = 0; i < 3; i++)
        [items insertObject:[self createRandomValue] atIndex:0];
    [tableV reloadData];
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [tableV refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
    for (int i = 0; i < 5; i++)
        [items addObject:[self createRandomValue]];
    
    [tableV reloadData];
    
    if (items.count > 50)
        tableV.canLoadMore = NO; // signal that there won't be any more items to load
    else
        tableV.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [tableV loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Standard TableView delegates

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];  
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [tableV tableViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [tableV tableViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [tableV tableViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
