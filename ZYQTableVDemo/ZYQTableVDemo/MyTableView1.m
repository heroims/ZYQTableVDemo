//
//  MyTableView1.m
//  ZYQTableVDemo
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "MyTableView1.h"

@implementation MyTableView1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 18; i++)
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

#pragma mark - Dummy data methods

- (void) addItemsOnTop
{
    for (int i = 0; i < 3; i++)
        [items insertObject:[self createRandomValue] atIndex:0];
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshCompleting) withObject:nil waitUntilDone:NO];

    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
}

- (void) addItemsOnBottom
{
    for (int i = 0; i < 5; i++)
        [items addObject:[self createRandomValue]];
    
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    if (items.count > 70){
        self.canLoadMore = NO; // signal that there won't be any more items to load
    }
    else{
        self.canLoadMore = YES;
    }
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

#pragma mark - BaseTableView DataSource

-(void)loadMoreData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        sleep(1);
        
        [self addItemsOnBottom];
    });
}

-(void)refreshData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        sleep(1);
        
        [self addItemsOnTop];
    });

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
