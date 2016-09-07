//
//  ViewController.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "ViewController.h"

#import "SJAxisView.h"

@interface ViewController ()

/**
 *  y轴上的刻度Label宽度
 */
@property (nonatomic, assign) CGFloat yMarkLabelWidth;

/**
 *
 */
@property (nonatomic, assign) CGFloat xMarkLabelHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    SJAxisView *axisView = [[SJAxisView alloc] initWithFrame:CGRectMake(50, 100,CGRectGetWidth([UIScreen mainScreen].bounds)- 100, 200)];
    axisView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:axisView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end