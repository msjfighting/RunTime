//
//  NSObject+Property.m
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
static const char *key = "name";
@implementation NSObject (Property)
- (NSString *)name{
    //根据关联的key,获取关联的值
    return objc_getAssociatedObject(self, key);
}
- (void)setName:(NSString *)name{
    // 参数1 给那个对象添加关联
    // 参数2 关联的key值,通过这个key值获取
    // 参数3 关联的value
    // 参数4 关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
