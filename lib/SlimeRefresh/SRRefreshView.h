//
//  SRRefreshView.h
//  SlimeRefresh
//
//  A refresh view looks like UIRefreshControl
//
//  Created by Zhao Yiqi on 13-8-19.
//  Copyright (c) 2013年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSlimeView.h"

@class SRRefreshView;

typedef void (^SRRefreshBlock)(SRRefreshView* sender);

@protocol SRRefreshDelegate;

@interface SRRefreshView : UIView{
    UIImageView     *_refleshView;
    SRSlimeView     *_slime;
}

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;
- (void)setLoadingWithexpansion;

//set the slime's style by this property.
@property (nonatomic, strong, readonly) SRSlimeView *slime;
//set your refresh icon.
@property (nonatomic, strong, readonly) UIImageView *refleshView;
//select one to receive the refreshing message.
@property (nonatomic, copy)     SRRefreshBlock      block;
@property (nonatomic, assign)   id<SRRefreshDelegate>   delegate;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicationView;
@property (nonatomic, readonly) UILabel *lblTime;
//default is false, if true when slime go back it will have a alpha effect 
//to go to miss.
@property (nonatomic, assign)   BOOL    slimeMissWhenGoingBack;

// 
@property (nonatomic, assign)   CGFloat upInset;

@property (nonatomic, assign)   CGFloat sizeHeight;

//
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDraging;

//as the name, called when loading over.
- (void)endRefresh;

// init default is 32
- (id)initWithHeight:(CGFloat)height;

@end

@protocol SRRefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(SRRefreshView*)refreshView;

@end