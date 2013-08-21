//
//  MyTableView.m
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-8-21.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++)
            [items addObject:[self createRandomValue]];
        
        self.delegate=self;
        self.dataSource=self;
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    [items removeAllObjects];
    [items release];
    [super dealloc];
}

#pragma mark - BaseTableView DataSource

-(void)loadMoreData{
    [self addItemsOnBottom];
}

-(void)refreshData{
    [self addItemsOnTop];
}

#pragma mark - Dummy data methods

- (void) addItemsOnTop
{
    for (int i = 0; i < 3; i++)
        [items insertObject:[self createRandomValue] atIndex:0];
    [self reloadData];
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self.slimeView performSelectorOnMainThread:@selector(endRefresh) withObject:nil waitUntilDone:NO];
    
}

- (void) addItemsOnBottom
{
    for (int i = 0; i < 5; i++)
        [items addObject:[self createRandomValue]];
    
    [self reloadData];
    
    if (items.count > 50)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self performSelectorOnMainThread:@selector(loadMoreCompleting) withObject:nil waitUntilDone:NO];
    
}

- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}

#pragma mark - UITableView DataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
