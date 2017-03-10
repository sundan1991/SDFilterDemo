//
//  SDView.h
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SDView;


@protocol SDViewDelegate <NSObject>

- (void)sendClass:(SDView *)sdView;

- (void)delegateButton:(UIButton *)btn;

- (void)addButton:(UIButton *)btn;

@end


@interface SDView : UIView


- (void)loadShaiXuanButtonWithArray:(NSArray *)arr titleArr:(NSMutableArray *)titleArr andSelectedButton:(NSMutableArray *)selectedArr;


@property (nonatomic ,weak)   id<SDViewDelegate> delegate;

@end
