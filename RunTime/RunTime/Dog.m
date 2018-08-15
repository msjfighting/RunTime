//
//  Dog.m
//  RunTime
//
//  Created by zlhj on 2018/8/8.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>
@implementation Dog
- (void)run{
    NSLog(@"一只狗在奔跑...");
}
+(void)eat{
    NSLog(@"一只狗正在吃东西...");
}
void jump (id self, SEL sel)
{
    NSLog(@" eat ...... %@ --- %@  ", self, NSStringFromSelector(sel));
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(jump)) {
        // 参数1 给那个类添加方法
        // 参数2 添加方法编号
        // 参数3 添加方法函数实现(函数地址)
        // 参数4 函数的类型(返回值 + 参数类型) v:void @:对象->self :表示SEL ->_cmd
        class_addMethod(self, @selector(jump), jump, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
@end
