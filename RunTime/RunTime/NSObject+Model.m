//
//  NSObject+Model.m
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>
@implementation NSObject (Model)
+(instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    // 遍历模型中所用属性 -> 使用运行时
    // 创建对用的对象
    id objc = [[self alloc] init];
    // 使用runtime给对象中的成员属性赋值
    // class_copyIvarList 获取类中的所有成员属性
    // 参数1 表示获取哪个类中的成员属性
    // 属性2 表示这个类中有多少成员属性,传入一个int 变量地址,会自动给这个变量赋值
    // 返回值ivar * :指的是一个ivar数组.会把所有成员属性放在一个数组中,通过返回的数组就能全部获取到
    // ivar 成员属性的意思
    /* 类似于下面的写法
    Ivar ivar;
    Ivar ivar1;
    Ivar ivar2;
   // 定义一个ivar的数组a
    Ivar a[] = {ivar,ivar1,ivar2};
    
    // 用一个ivar * 指针指向数组第一个元素
    Ivar *ivarList = a;
    // 根据指针访问数组第一个元素
    ivarList[0];
   */
    
    unsigned int count;
    // 获取类中的所有成员属性
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // 根据角标,从数组中取出对应的成员属性
        Ivar ivar = ivarList[i];
        
        // 获取成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 处理成员属性名->字典中的key
        // 从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        // 根据成员属性名去字典中查找相应的value
        id value = dictionary[key];
        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 二级转换:如果字典中还有字典,也需要把对应的字典转换成模型
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) {
            //处理类型字符串@\"User\"  -> User
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // 自定义对象 并且值是字典
            // value:user字典 -> User模型
            // 获取模型(user)类对象
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                // 字典转模型user
                value = [modelClass modelWithDictionary:value];
            }
        }
        
        // 三级转换:NSArray中也是字典,把数组中的字典转模型
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
    
                id idSelf = self;
                // 获取数组中字典对应的模型
                
                NSString *type = [idSelf arrayContainModelClass][key];
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                for (NSDictionary *dic in value) {
                    id model = [classModel modelWithDictionary:dic];
                    [arrM addObject:model];
                }
                
                value = arrM;
            }
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    
    return objc;
   
}
@end
