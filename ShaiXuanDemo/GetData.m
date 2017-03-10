//
//  GetData.m
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import "GetData.h"

@implementation GetData


//从数据库里取数据
+ (NSDictionary *)getFilterDataWithPcnumber:(NSString *)pcNum{
    
    
    NSMutableArray *filterDataArr = [NSMutableArray array];
    
    NSMutableArray *subArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *titleArr  = [[NSMutableArray alloc] init];
    
    //本地数据库
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"PROJECT" ofType:@"sqlite"];
    
    SDLog(@"%@",resourcePath);
    
    FMDatabase * db = [[FMDatabase alloc]initWithPath:resourcePath];
    
    if (![db open]) {
        //打开失败
        NSLog(@"Could not open db.");
        return nil;
    }
    
    NSString * sql = [NSString stringWithFormat:@"select name,attributename,cnumber,typeLineNum,fieldname from ProjectFilter where pcnumber= '%@'",pcNum];
    
    FMResultSet *rs = [db executeQuery:sql];
    
    int nn  = 0;
    
    while ([rs next]) {
        
        //筛选条件
        GetFilterModel *model = [[GetFilterModel alloc] init];
        model.attributename =[rs stringForColumn:@"attributename"];
        model.typeLineNum = [rs stringForColumn:@"typeLineNum"];
        NSString *strr = [NSString stringWithFormat:@"%@,%d",pcNum,nn];
        
        //相等说明是一个类型的筛选条件
        if ([model.typeLineNum isEqualToString:strr ]) {
            
            //添加标题
            [titleArr addObject:model];
            
            //二级数组添加到大数据源中
            if (subArr.count) {
                
                [filterDataArr addObject:subArr];
               
            }
            
            //置空
            subArr = nil;
            
            subArr = [NSMutableArray array];
            
            nn++ ;
            
        }
       
        model.cvalue = [rs stringForColumn:@"name"];
        model.cnumber = [rs stringForColumn:@"cnumber"];
        model.fieldname = [rs stringForColumn:@"fieldname"];
        
        [subArr addObject:model];
        
    }
    
    
    //最后一个数组
    if (subArr.count) {
        [filterDataArr addObject:subArr];
    }
    
    [rs close];
    
    return @{@"content":filterDataArr,@"title":titleArr};

}


@end
