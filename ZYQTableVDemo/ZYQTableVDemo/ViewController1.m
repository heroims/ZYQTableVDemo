//
//  ViewController1.m
//  ZYQTableVDemo
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ViewController1.h"
#import "MyTableView1.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    
    MyTableView1 *tableV=[[MyTableView1 alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    tableV.canPullToRefresh=YES;
    [self.view addSubview:tableV];
    [tableV release];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
