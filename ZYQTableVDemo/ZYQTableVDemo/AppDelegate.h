//
//  AppDelegate.h
//  ZYQTableVDemo
//
//  Created by Zhao Yiqi on 13-3-5.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
