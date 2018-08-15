//
//  NSObject+DictionaryToModel.h
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DictionaryToModel)
// 自动打印属性字符串
+(void)transformToModelByDictionary:(NSDictionary *)dict;

@end
