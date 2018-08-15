//
//  UIImage+RunTimeImage.m
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "UIImage+RunTimeImage.h"
#import <objc/runtime.h>
@implementation UIImage (RunTimeImage)
// 加载内存时调用
+(void)load{
    // 交换方法
    // 获取ImageOriginalWithStrName:方法
    Method imageWithName = class_getClassMethod(self, @selector(ImageOriginalWithStrName:));
    
    // 获取imageName方法
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    // 交换方法地址,相当于交换实现
    
    method_exchangeImplementations(imageWithName, imageName);
}
// 注意 这里返回值是一个函数结果类型,使用instancetype会产生类型不匹配,所以使用id
// 不能再改分类UIImage中重写,imageName:因为系统会把imageName:原来的功能覆盖掉
// 分类中不能使用super本身

+(id)ImageOriginalWithStrName:(NSString *)name{
    UIImage *image = [[self ImageOriginalWithStrName:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (image == nil) {
        NSLog(@"加载图片为空");
    }
    return image;
}

@end
