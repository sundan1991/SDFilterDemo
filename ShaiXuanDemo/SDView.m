//
//  SDView.m
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import "SDView.h"

#import "GetFilterModel.h"


//筛选类目title

#define KLabelTopSpace 5

#define KLabelLeftSpace 5

#define KLabelHeight 30

#define KLabelFont 15

#define KSelectedLabelFont 13

#define KLabelWidth 120

//筛选button

#define KButtonHeight 30


//筛选view
@interface SDView ()


@property (nonatomic ,strong)   NSArray *dataArray;

@property (nonatomic ,strong)   UIView  *topView;//筛选条目的背景view

@property (nonatomic ,strong)   NSMutableArray *selectedButtonArr;//用户选择的筛选条件集合

@property (nonatomic ,assign)   CGFloat selectedBtnWidthTotle;//选中的筛选条件button的长度集和

@property (nonatomic ,strong)   NSMutableArray *sendSelectedArr;// controller传过来的被点击过的数组,重载的时候显示之前被选中过的筛选项目

@end


@implementation SDView


- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.selectedBtnWidthTotle = KLabelLeftSpace+KLabelWidth+10;//第一个选中按钮的横坐标
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
    
}


//arr:筛选二维数组
//titleArr:筛选title
//selectedArr:记录被选中的button
- (void)loadShaiXuanButtonWithArray:(NSArray *)arr titleArr:(NSMutableArray *)titleArr andSelectedButton:(NSMutableArray *)selectedArr{
    
    self.selectedButtonArr = nil;
    self.selectedButtonArr = selectedArr;
    
    
    if (titleArr.count) {
        
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(KLabelLeftSpace, 0, ([UIScreen mainScreen].bounds.size.width-2*KLabelLeftSpace), KLabelHeight)];
        
        self.topView.backgroundColor = [[UIColor alloc] initWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        
        [self addSubview:self.topView];
        
        //
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KLabelWidth, KLabelHeight)];
        label.text = @"筛选项目:";
        label.textColor = [[UIColor alloc] initWithRed:113/255.0 green:112/255.0 blue:111/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:KLabelFont];
        [self.topView addSubview:label];
        //数据源
        self.dataArray = arr;
        
        //把类目拿出来
        
        CGFloat space = 10;
        
        CGFloat x = KLabelLeftSpace+KLabelWidth+10;
        
        CGFloat y = 30;
        
        //按钮
        for (int j = 0; j<arr.count; j++) {
            
            CGFloat button_x = x;
            //单条类目
            NSArray *subArr = arr[j];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KLabelLeftSpace, y+j*(KButtonHeight), KLabelWidth, KLabelHeight)];
            
            //        SDLog(@"%d",j);
            GetFilterModel *model = titleArr[j];
            
            titleLabel.text = [NSString stringWithFormat:@"%@:",model.attributename];
            
            titleLabel.backgroundColor = [[UIColor alloc] initWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
            
            titleLabel.textColor = [[UIColor alloc] initWithRed:116/255.0 green:118/255.0 blue:118/255.0 alpha:1];
            
            titleLabel.font = [UIFont systemFontOfSize:KLabelFont];
            
            [self addSubview:titleLabel];
            
            
            //        SDLog(@"%@",subArr);
            
            for (int i = 0; i<subArr.count; i++) {
                
                GetFilterModel *model = subArr[i];
                
                UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
                
                button.tag = j*100+i;
                
                CGFloat b_y = y+j*(KButtonHeight);
                
                UIFont *font = [UIFont systemFontOfSize:KLabelFont];
                
                
                
                CGSize titleSize = [model.cvalue sizeWithFont:font constrainedToSize:CGSizeMake(button_x, CGFLOAT_MAX)lineBreakMode:NSLineBreakByWordWrapping];
                
                [button setFrame:CGRectMake(button_x+i*space, b_y, titleSize.width, KButtonHeight)];
                
                button.titleLabel.font = font;
                
                [button setTitleColor: [UIColor lightGrayColor] forState:(UIControlStateNormal)];
                
                [button setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
                
                [button setTitle:model.cvalue forState:(UIControlStateNormal)];
                
                button.selected = NO;
                
                if (selectedArr.count) {
                    
                    for (UIButton *btn in selectedArr) {
                        if (btn.tag == button.tag) {
                            //被选中过
                            button.selected = YES;
                        }
                    }
                    
                }
                
                //添加点击事件
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                [self addSubview:button];
                
                //所有button的横坐标之和
                button_x += titleSize.width;
                
            }
            
            
        }
        
        ////重载后加载上次被点击过的按钮
        [self addSelectedButton];
        
        
    }
    
    
    
}

// 筛选条件点击
- (void)buttonClick:(UIButton *)sender{
    
    //首先判断用户点击的button所在行
    int m = 100;
    int j = 0;
    int selectedIndex = 0;//用户点击行的首个位置
    
    for (int i = 0; i<self.dataArray.count+1; i++) {
        //循环多少次就是有多少个筛选条件
        if (j<= sender.tag && sender.tag < m) {
            //定位到用户点击的所在行
            selectedIndex = j;
            
            break;
        }
        
        j = m;
        m = (i+1)*100;//100 200...
    }
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)view;
            
            if (selectedIndex <= button.tag && button.tag < selectedIndex+100) {
                
                //                NSLog(@"%d ====%d",selectedIndex,selectedIndex+10);
                //拿到用户点击那一行的所有button
                if (sender.tag == button.tag) {
                    //用户选中的那个就是button
                    if (sender.selected) {
                        sender.selected = NO;
                        
                        for (UIButton *selectedBtn in self.selectedButtonArr) {
                            if (selectedBtn.tag == sender.tag) {
                                //删除
                                [self.selectedButtonArr removeObject:selectedBtn];
                                [self removeButtonWithButton:sender];
                                break;
                                
                            }
                        }
                        
                    }
                    else {
                        sender.selected = YES;
                        if (self.selectedButtonArr.count) {
                            //有数据
                            for (UIButton *selectedButton in self.selectedButtonArr) {
                                if (selectedButton.tag != sender.tag ) {
                                    //保证这条数据不被重复添加
                                    [self.selectedButtonArr addObject:sender];
                                    [self addButtonWithButton:sender reloadData:NO i:-1];
                                    break;
                                }
                            }
                        }
                        //第一次添加
                        else
                        {
                            [self.selectedButtonArr addObject:sender];
                            [self addButtonWithButton:sender reloadData:NO i:-1];
                        }
                        
                        
                        
                    }
                }
                else{
                    // 区间内没有被选中的
                    button.selected = NO;
                    
                    for (UIButton *selectedBtn in self.selectedButtonArr) {
                        if (selectedBtn.tag == button.tag) {
                            //删除
                            [self.selectedButtonArr removeObject:selectedBtn];
                            [self removeButtonWithButton:button];
                            break;
                            
                        }
                    }
                    
                }
                
                
            }
            
        }
        
        
    }
    
}


// 删除button
- (void)removeButtonWithButton:(UIButton *)sender{
    //删除
    for (UIButton *button in self.selectedButtonArr) {
        if (button.tag == sender.tag) {
            // 需要删除的那个
            [self.selectedButtonArr removeObject:button];
            break;
        }
    }
    //告诉controller 刷表
    if ([self.delegate respondsToSelector:@selector(delegateButton:)]) {
        [self.delegate delegateButton:sender];
    }
    
    //找到用户要删除的button，并删除
    CGFloat deleteBtn_x = 0.0;
    CGFloat deleteBtn_width = 0.0;
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *deleteBtn = (UIButton *)view;
            if (deleteBtn.tag == sender.tag) {
                //拿到要删除的那个button了
                //获取他的横坐标
                deleteBtn_x = deleteBtn.frame.origin.x;
                
                deleteBtn_width = deleteBtn.frame.size.width;
                
                [deleteBtn removeFromSuperview];// 删除掉
                
                //告诉筛选条件这个按钮被干掉了
                for (UIView *view in self.subviews) {
                    if ([view isKindOfClass:[UIButton class]]) {
                        //是button
                        UIButton *tellBtn = (UIButton *)view;
                        //看这个button是不是筛选条件那个需要被干掉的button
                        if (tellBtn.tag == deleteBtn.tag) {
                            // shi那个button
                            tellBtn.selected = NO;
                            break;
                        }
                    }
                }
                
                break;
                
            }
        }
    }
    //找到删除按钮后面的button，动态改变他们的坐标
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *otherBtn = (UIButton *)view;
            if (otherBtn.frame.origin.x>deleteBtn_x) {
                //拿到删除button后面的那些按钮
                //改变他们的坐标
                CGFloat width = otherBtn.frame.size.width;
                
                [UIView animateWithDuration:0.2 animations:^{
                    [otherBtn setFrame:CGRectMake(otherBtn.frame.origin.x-deleteBtn_width-10, 2, width, KButtonHeight-4)];
                }];
                
                
            }
        }
    }
    
    self.selectedBtnWidthTotle -= deleteBtn_width;
    
}

//重载后加载上次被点击过的按钮
- (void)addSelectedButton{
    
    self.selectedBtnWidthTotle = KLabelLeftSpace+KLabelWidth+10;
    
    for (int i = 0; i<self.selectedButtonArr.count; i++) {
        [self addButtonWithButton:self.selectedButtonArr[i] reloadData:YES i:i];
    }
    self.selectedBtnWidthTotle -= 10;
    
}

//增加button
- (void)addButtonWithButton:(UIButton *)sender reloadData:(BOOL)isReload i:(int)i{
    
    
    if (self.selectedButtonArr.count == 1) {
        // 添加第一个的时候
        self.selectedBtnWidthTotle = KLabelLeftSpace+KLabelWidth+10;//第一个选中按钮的横坐标
    }
    
    //添加筛选条件，告诉controller 刷表
    if ([self.delegate respondsToSelector:@selector(addButton:)]) {
        [self.delegate addButton:sender];
    }
    
    //创建筛选项目上的button
    
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    addBtn.layer.cornerRadius = 3;
    
    addBtn.backgroundColor = [UIColor whiteColor];
    
    //自适应宽度
    NSString *str = [NSString stringWithFormat:@" %@❌ ",sender.titleLabel.text];
    
    CGSize titleSize = [str sizeWithFont:[UIFont systemFontOfSize:KSelectedLabelFont] constrainedToSize:CGSizeMake(self.selectedBtnWidthTotle, CGFLOAT_MAX)lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat x;
    
    if (isReload) {
        
        x = i*10+self.selectedBtnWidthTotle;
        
    }
    else
        x = self.selectedButtonArr.count *10 + self.selectedBtnWidthTotle;
    
    //设置button frame
    [addBtn setFrame:CGRectMake(x, 2 ,titleSize.width , KButtonHeight-4)];
    
    //其它设置
    addBtn.tag = sender.tag;
    
    addBtn.titleLabel.font = [UIFont systemFontOfSize:KSelectedLabelFont];
    
    [addBtn setTitle:str forState:(UIControlStateNormal)];
    
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    
    //添加点击事件
    [addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.topView addSubview:addBtn];
    
    //设置下一个追加button的横坐标
    self.selectedBtnWidthTotle += titleSize.width;
    
}


//筛选项目的button被点击
- (void)addButtonClick:(UIButton *)sender{
    
    
    for (UIButton *selectedBtn in self.selectedButtonArr) {
        if (selectedBtn.tag == sender.tag) {
            //删除
            [self.selectedButtonArr removeObject:selectedBtn];
            break;
            
        }
    }
    
    [self removeButtonWithButton:sender];
    
    
}



@end
