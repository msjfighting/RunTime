//
//  ViewController.m
//  RunTime
//
//  Created by zlhj on 2018/8/8.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Dog.h"
#import "NSObject+Property.h"
#import "NSObject+DictionaryToModel.h"
#import "NSObject+Model.h"
#import "UIGestureRecognizer+Block.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /****************   1.runtime发送消息  **********************/
    Dog *dog = [[Dog alloc] init];
    // 系统底层本质  -> 让对象发消息
    objc_msgSend(dog, @selector(run));
    objc_msgSend([Dog class], @selector(eat));
    
     /****************   2.runtime交换方法  **********************/
    // 系统自带方法功能不够用,给系统自带方法扩展一些功能,并保存原有功能
    // 通过runtime 交换自定义方法和UIimage中的imageNamed: 来实现图片加载 不被渲染
    UIImage *image = [UIImage imageNamed:@"123"];
    
    /****************   3.runtime动态添加方法  **********************/
    // 如果一个类方法非常多,加载到内存中的时候,会比较耗费资源,需要给方法生成映射表,这里可以使用动态添加方法给某个类
    // 当一个对象调用未实现的方法,会调用+(BooL)resolveInstanceMethod:(SEL)sel 这个方法处理,并且会把这个列表传过来
    [dog performSelector:@selector(jump)];
    
    
    /****************   4.runtime给分类添加属性  **********************/
   // 给一个类声明属性,其实本质就是给这个类添加关联,并不是直接把这个值的内存空间添加到内存空间
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"张三";
    NSLog(@"%@",obj.name);
    
      /****************   5.runtime字典转模型  **********************/
    NSArray *array = [NSArray arrayWithObjects:@1, @2, @3, @4, nil];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"dfdf" forKey:@"dfsdf"];
    
    
    [NSObject transformToModelByDictionary:@{@"name" : @"str", @"num" : array, @"count" : @0, @"hah": arr, @"dic" : dic,@"mutDic":[NSMutableDictionary dictionaryWithDictionary:dic]}];
    
    NSMutableDictionary *di = [NSMutableDictionary dictionary];
    NSMutableArray *a = [NSMutableArray array];
    [a addObject:dic];
    [di setValue:a forKey:@"dic"];
    
    id model =   [NSObject modelWithDictionary:dic];
    
    NSLog(@"%@", model);
    
    
    id dmodel =   [NSObject modelWithDictionary:di];
    
    NSLog(@"%@", dmodel);
    
    /****************   6.runtime快速归档  **********************/
    
     /****************  最后使用runtime 来写了通过 block回调 直接调用手势识别的action *********/
    [self.view addGestureRecognizer:[UITapGestureRecognizer msj_gestureRecoginizerWithActionBlock:^(id gestureRecognizer) {
        NSLog(@"点击了");
    }]];
    
    [self.view addGestureRecognizer:[UILongPressGestureRecognizer msj_gestureRecoginizerWithActionBlock:^(id gestureRecognizer) {
        NSLog(@"长按了");
    }]];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
