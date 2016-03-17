//
//  AInvocation.m
//  TestInvocationDemo
//
//  Created by caf on 3/4/16.
//  Copyright © 2016 kkkwan. All rights reserved.
//

#import "AInvocation.h"

@implementation AInvocation
- (void)somePrivateMethod:(NSString *)pr
{
    NSLog(@"printsomePrivateMethod:%@",pr);
}
- (NSInteger)actionInvokeArgument1:(NSInteger)arg1 arg2:(NSNumber *)arg2 {
    NSLog(@"action: arg1 + arg2=%d", arg1 - [arg2 integerValue]);
    return arg1 - [arg2 integerValue];
}

@end
