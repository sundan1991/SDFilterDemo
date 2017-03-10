 ![image](http://github.com/986754907@qq.com/SDFilterDemo/raw/master/aaa.png)
引入头文件 #import "SDView.h"
声明属性 @property (nonatomic ,strong)  SDView *sdView;
遵循代理 <SDViewDelegate>
调用 [self.view addSubview:[self returnSDView]];
实现方法
- (UIView *)returnSDView{
    
    //筛选条件view的高度
    CGFloat shaiXuanViewHeight = self.titleArray.count*30+30;
    
    self.sdView = [[SDView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, shaiXuanViewHeight)];
    
    self.sdView.delegate = self;
    
    //load数据
    [self reloadShaiXuanButton];
    
    return self.sdView;
    
}

   
