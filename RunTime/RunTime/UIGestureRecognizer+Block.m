//
//  UIGestureRecognizer+Block.m
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>
static const int target_key;
@implementation UIGestureRecognizer (Block)
+ (instancetype)msj_gestureRecoginizerWithActionBlock:(MSJGestureBlock)block{
    return [[self alloc] initWithActionBlock:block];
}
- (instancetype)initWithActionBlock:(MSJGestureBlock)block{
    self = [self init];
    [self addActionBlock:block];
    [self addTarget:self action:@selector(invoke:)];
    return self;
}
- (void)addActionBlock:(MSJGestureBlock)block{
    if (block) {
        //将值value 跟对象object 关联起来（将值value 存储到对象object 中）
        //参数 object：给哪个对象设置属性
        //参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节
        //参数 value：给属性设置的值
        //参数policy：存储策略 （assign 、copy 、 retain就是strong）
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
    }
}
- (void)invoke:(id)sender{
    MSJGestureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}
@end
