//
//  ViewController.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "ViewController.h"


#import "SJLineChart.h"

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
    
    SJLineChart *chartAssistView = [[SJLineChart alloc] initWithFrame:CGRectMake(10, 50, CGRectGetWidth([UIScreen mainScreen].bounds) - 20, 260)];
    [self.view addSubview:chartAssistView];
    
    [chartAssistView show];

}

@end
