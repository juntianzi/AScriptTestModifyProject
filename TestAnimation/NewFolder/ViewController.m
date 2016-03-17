//
//  ViewController.m
//  TestAnimation
//
//  Created by caf on 3/2/16.
//  Copyright © 2016 kkkwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabelPurp;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController
{
    CGPoint originCenter;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSError *tDError = [NSError errorWithDomain:@"com.cf.nubi" code:3 userInfo:@{@"niubima":@YES}];
    
    NSLog(@"tdError.Domain:%@\n.code:%ld\n.userInfo:%@",tDError.domain,tDError.code,tDError.userInfo);
    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    originCenter = self.testLabelPurp.center;
    NSLog(@"originCenter:%@",NSStringFromCGPoint(originCenter));
}
- (IBAction)thefirstAction:(UIButton *)sender {
    static BOOL goBack = NO;
    goBack = !goBack;
    if (goBack) {
        NSLog(@"go");
   //     [self testUIViewAnimation:self.view.center];
        [self testspringAnimation:CGPointMake(100, 420)];
    } else {
        NSLog(@"back");
    //    [self testUIViewAnimation:originCenter];
        [self testspringAnimation:originCenter];
    }
    
}

#pragma mark - uiview 
- (void)testUIViewAnimation:(CGPoint)centP
{
    [UIView animateWithDuration: 0.5 delay: 0.35 options: UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseOut  animations: ^{
        self.testLabelPurp.alpha = !(self.testLabelPurp.alpha);
        NSLog(@"self.t.alpha:%f",self.testLabelPurp.alpha);
        self.testLabelPurp.center = centP;
    } completion: ^(BOOL finished) {
        if (finished) {
            NSLog(@"finished");
        } else {
            NSLog(@"unfinished");
        }
    }];
}
- (IBAction)simpleAnimationAction:(UIButton *)sender {//3 action
    static BOOL goBack = NO;
    goBack = !goBack;
    if (goBack) {
        NSLog(@"1go");
        
        [self testUIViewAnimation:self.view.center];
        
    } else {
        NSLog(@"1back");
        
        [self testUIViewAnimation:originCenter];
        
    }

}
- (IBAction)changeImageAction:(UIButton *)sender {//2 action
    [UIView transitionWithView: self.testImageView duration: 5 options: UIViewAnimationOptionTransitionFlipFromBottom|UIViewAnimationOptionTransitionCurlDown animations: ^{
        [self flipCard];
    } completion: ^(BOOL finished) {
        //isAnimating = NO;
        
        if (finished) {
            NSLog(@"imageChangeFinished");
        }
        else {
            NSLog(@"imageNOTFinished");
        }
    }];
}
- (void)flipCard
{
    static BOOL  isfliped = YES;
    if (isfliped) {
        self.testImageView.image = [UIImage imageNamed: @"test1.png"];
        isfliped = NO;
    } else {
        self.testImageView.image = [UIImage imageNamed:@"test2.png"];
        isfliped = YES;
    }
}

#pragma mark - uiview spring animation
- (void)testspringAnimation:(CGPoint)cPoint
{
    //dampingRatio：速度衰减比例。取值范围0 ~ 1，值越低震动越强
   // velocity：初始化速度，值越高则物品的速度越快
   // CGPoint center = CGPointMake(100, 330);
    
    
    [UIView animateWithDuration: 0.5 delay: 0.35 usingSpringWithDamping: 0.2 initialSpringVelocity: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        self.testLabelPurp.center = cPoint;
    } completion: nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
