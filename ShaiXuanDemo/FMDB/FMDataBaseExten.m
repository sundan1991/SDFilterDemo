//
//  FMDataBaseExten.m
//  JiuMu
//
//  Created by lzt on 16/3/31.
//  Copyright © 2016年 西搜(韦忠添). All rights reserved.
//

#import "FMDataBaseExten.h"



@implementation FMDatabase (name)

+ (FMDatabase*)dataBaseWithName:(NSString*)name{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:name];
    return [[FMDatabase alloc]initWithPath:path];
}

+ (FMDatabase*)dataBase{
    return [FMDatabase dataBaseWithName:@"PROJECT.sqlite"];
}

@end

