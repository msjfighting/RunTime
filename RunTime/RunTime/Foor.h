//
//  Foor.h
//  RunTime
//
//  Created by zlhj on 2018/8/23.
//  Copyright © 2018年 zlhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foor : NSObject
@property(nonatomic, assign) int pwd;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, assign) BOOL isUrl;
@property(nonatomic, strong) NSArray *emailList;
@property(nonatomic, strong) NSArray *manyMoo;
@property(nonatomic, strong) NSDictionary *childrenList;
@property(nonatomic, strong) NSDictionary *MooDic;
@end
