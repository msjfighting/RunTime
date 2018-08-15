//
//  NSObject+Model.h
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ModelDelegate <NSObject>

@optional
// 提供一个协议，只要准备这个协议的类，都能把数组中的字典转模型
// 用在三级数组转换
+ (NSDictionary *)arrayContainModelClass;

@end
@interface NSObject ()
+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;
@end
