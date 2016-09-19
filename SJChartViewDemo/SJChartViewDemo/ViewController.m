//
//  ViewController.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "ViewController.h"

#import "SJAxisView.h"
#import "SJChartLineView.h"
#import "SJLineChart.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // 初始化折线图
    SJLineChart *lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 200)];
  
    // 设置折线图属性
    
    lineChart.title = @"折线图"; // 折线图名称
    lineChart.maxValue = 100;   // 最大值
    lineChart.yMarkTitles = @[@"20",@"40",@"60",@"80",@"100"]; // Y轴刻度标签
    
    [lineChart setXMarkTitlesAndValues:@[@{@"item":@"9月1日",@"count":@60},@{@"item":@"9月2日",@"count":@30},@{@"item":@"9月3日",@"count":@90},@{@"item":@"9月4日",@"count":@100},@{@"item":@"9月5日",@"count":@60},@{@"item":@"9月6日",@"count":@60},@{@"item":@"9月7日",@"count":@12}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值

    // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
    
    //设置完数据等属性后绘图折线图
    [lineChart mapping];
    
    [self.view addSubview:lineChart];

}

@end
