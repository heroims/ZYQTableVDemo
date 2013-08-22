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

    UIButton *btnPlayPlane=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnPlayPlane.frame=CGRectMake(0, self.view.frame.size.height-60, 320, 60);
    [btnPlayPlane setTitle:@"玩打飞机" forState:UIControlStateNormal];
    [btnPlayPlane addTarget:self action:@selector(btnPlayPlaneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlayPlane];
}

-(void)btnPlayPlaneClick{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    UIWindow *newwindow = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    newwindow.backgroundColor = [UIColor whiteColor];
    newwindow.rootViewController=((AppDelegate*) [UIApplication sharedApplication].delegate).navController;
    
    ((AppDelegate*) [UIApplication sharedApplication].delegate).window=newwindow;
    [newwindow makeKeyAndVisible];
}



@end
