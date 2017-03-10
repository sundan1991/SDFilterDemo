# SDFilterDemo
#import "SDView.h"
@property (nonatomic ,strong)   SDView *sdView;
<SDViewDelegate>
调用 [self.view addSubview:[self returnSDView]];
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

   
