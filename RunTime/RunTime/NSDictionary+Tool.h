//
//  NSDictionary+Tool.h
//  RunTime
//
//  Created by zlhj on 2018/8/23.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tool)
/**
 将model转换为字典
 */
+ (NSDictionary *)dictionaryWithModel:(NSObject *)object;
@end
