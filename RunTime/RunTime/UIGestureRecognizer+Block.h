//
//  UIGestureRecognizer+Block.h
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MSJGestureBlock) (id gestureRecognizer);
@interface UIGestureRecognizer (Block)

/**
 使用类方法初始化添加手势

 @param block 手势回调
 @return block 内部action
 *  使用 __unsafe_unretained __typeof(self) weakSelf = self;
 *  防止循环引用
 */
+ (instancetype)msj_gestureRecoginizerWithActionBlock:(MSJGestureBlock)block;
@end
