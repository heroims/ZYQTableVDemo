//
//  ViewController.m
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"
#import "TableHeaderV.h"
#import "TableFooterV.h"

@interface ViewController ()

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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    
    // add sample items

    
    MyTableView *tableV=[[MyTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [self.view addSubview:tableV];
    [tableV release];

	// Do any additional setup after loading the view.
}



@end
