//
//  GetData.h
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetData : NSObject

//从数据库里取筛选数据
+ (NSDictionary *)getFilterDataWithPcnumber:(NSString *)pcNum;



@end
