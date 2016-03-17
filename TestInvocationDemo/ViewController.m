//
//  ViewController.m
//  TestInvocationDemo
//
//  Created by caf on 3/4/16.
//  Copyright © 2016 kkkwan. All rights reserved.
//

#import "ViewController.h"
#import "AInvocation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testPerformInvocation];
   // [self testNSInvocationInvo];
    
    
}
- (IBAction)cancelPerformAction:(UIButton *)sender {
    [ViewController cancelPreviousPerformRequestsWithTarget:self ];
    [ViewController cancelPreviousPerformRequestsWithTarget:[AInvocation new]];//这个其他类的方法无法取消
}
#pragma mark - perform invocation
- (void)testPerformInvocation
{
    [[AInvocation new] performSelector:@selector(somePrivateMethod:) withObject:@"someArgu" afterDelay:10];//unerror just warning
    NSLog(@"test is asyn");//asyn
    [self performSelector:@selector(testSelfInvoPerform:) withObject:@"aString" afterDelay:5];
    
   // [[AInvocation new] somePrivateMethod];//not visible error
}
- (void)testSelfInvoPerform:(NSString *)pr
{
    NSLog(@"selfInvoPerform:%@",pr);
}
#pragma mark - NSInvocation invo
- (void)testNSInvocationInvo
{
    SEL mySelector = @selector(actionInvokeArgument1:arg2:);
    NSMethodSignature* signature1 = [self methodSignatureForSelector:mySelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature1];//invocation不能使用 alloc跟init來建立實體, 只能使用invocationWithMethodSignature:來建立object.
    
    [invocation setTarget:[AInvocation new]];
    [invocation setSelector:mySelector];
    NSInteger arg1 = 1;
    NSNumber* arg2 = @5;
    [invocation setArgument:&arg1 atIndex:2];//NSMethodSignature的numberOfArguments最小值是2; 0跟1是給預設的隱藏參數使用(self & _cmd). 從2開始才是method-spec使用.
    [invocation setArgument:&arg2 atIndex:3];
    [invocation invoke];
   // [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1];//要注意的是, 如果會需要取得回傳值, 可能不適合使用delay的方式~//这种方式也不适合调用其他类的实例方法
   
    NSInteger retVal;
    [invocation getReturnValue:&retVal];
    NSLog(@"return:%d", retVal);
    NSNumber* getArg2 ;
    [invocation getArgument:&getArg2 atIndex:3];
    NSLog(@"getArg:%@",getArg2);
}
- (NSInteger)actionInvokeArgument1:(NSInteger)arg1 arg2:(NSNumber *)arg2 {
    NSLog(@"action: arg1 + arg2=%d", arg1 + [arg2 integerValue]);
    return arg1 + [arg2 integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
