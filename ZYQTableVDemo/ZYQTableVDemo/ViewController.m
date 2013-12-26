//
//  ViewController.m
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
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
    self.navigationController.navigationBar.translucent=NO;
    // add sample items

    
    MyTableView *tableV=[[MyTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [self.view addSubview:tableV];
    [tableV release];

    UIButton *btnPush=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPush.frame=CGRectMake(60, 330, 200, 50);
    btnPush.layer.borderWidth=1;
    btnPush.layer.borderColor=[[UIColor colorWithRed:0.6 green:0.6 blue:0.8 alpha:1] CGColor];
    [self.view addSubview:btnPush];
    [btnPush addTarget:self action:@selector(btnPushClick:) forControlEvents:UIControlEventTouchUpInside];
	// Do any additional setup after loading the view.
}

-(void)btnPushClick:(UIButton*)sender{
    ViewController1 *vc1=[[ViewController1 alloc] init];
    [self.navigationController pushViewController:vc1 animated:YES];
    [vc1 release];
}

@end
