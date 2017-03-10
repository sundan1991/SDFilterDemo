//
//  GetFilterModel.h
//  ShaiXuanDemo
//
//  Created by sundan on 16/5/4.
//  Copyright © 2016年 lzt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetFilterModel : NSObject


//因为是本地筛选，筛选属性有很多，不能一一定义字段，所以统一用key-value的形式存取

@property (nonatomic ,copy)   NSString  *attributename;

@property (nonatomic ,copy)   NSString  *pcnumber;

@property (nonatomic ,copy)   NSString  *cnumber;//筛选数字

@property (nonatomic ,copy)   NSString  *cvalue;//扩展属性的value

@property (nonatomic ,copy)   NSString  *typeLineNum;

@property (nonatomic ,copy)   NSString  *fieldname;//筛选扩展属性名字


@end
