//
//  NSObject+Extension.h
//  RunTime
//
//  Created by zlhj on 2018/8/9.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
- (NSArray *)ignoredNames;
- (void)encode:(NSCoder *)aCoder;
- (void)dencode:(NSCoder *)aDecoder;
@end
