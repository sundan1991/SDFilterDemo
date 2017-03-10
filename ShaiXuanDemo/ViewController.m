//
//  ViewController.m
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SDViewDelegate>


@property (nonatomic ,strong)   NSMutableArray *dataArray;//筛选条件下的具体条件（形象品主推品等）

@property (nonatomic ,strong)   NSMutableArray *titleArray;//筛选条件（产品类型等）

@property (nonatomic ,strong)   SDView *sdView;//自定义筛选view


@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //加载数据 
    NSDictionary *dic = [GetData getFilterDataWithPcnumber:@"T281"];
    
    self.dataArray = dic[@"content"];
    
    self.titleArray = dic [@"title"];
    
    //加载UI
    [self.view addSubview:[self returnSDView]];
    
}

// 加载筛选控件
- (UIView *)returnSDView{
    
    //筛选条件view的高度
    CGFloat shaiXuanViewHeight = self.titleArray.count*30+30;
    
    self.sdView = [[SDView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, shaiXuanViewHeight)];
    
    self.sdView.delegate = self;
    
    //load数据
    [self reloadShaiXuanButton];
    
    
    return self.sdView;
    
}

//加载数据
- (void)reloadShaiXuanButton{
    
    //Array:筛选条件（一个二维数组）
    //titleArr:筛选条件标题
    //selectedButton:放在tableView上重载筛选view的时候需要传selectedButtonArray
    [self.sdView loadShaiXuanButtonWithArray:self.dataArray titleArr:self.titleArray andSelectedButton:[NSMutableArray array]];
    
}

#pragma mark - SDView delegate method

- (void)sendClass:(SDView *)sdView{
    
}
- (void)delegateButton:(UIButton *)btn{
    
}
- (void)addButton:(UIButton *)btn{
    
}

@end
