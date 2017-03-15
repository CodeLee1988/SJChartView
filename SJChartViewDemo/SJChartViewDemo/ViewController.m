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

@property (nonatomic, strong) SJLineChart *lineChart;


@end

@implementation ViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // 初始化折线图
    self.lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 200)];
  
    // 设置折线图属性
    
    self.lineChart.title = @"折线图"; // 折线图名称
    self.lineChart.maxValue = 5;   // 最大值
    self.lineChart.yMarkTitles = @[@"0",@"1",@"2",@"3",@"4",@"5"]; // Y轴刻度标签
    
    [self.lineChart setXMarkTitlesAndValues:@[@{@"item":@"9月1日",@"count":@2},@{@"item":@"9月2日",@"count":@3},@{@"item":@"9月3日",@"count":@0},@{@"item":@"9月4日",@"count":@2},@{@"item":@"9月5日",@"count":@2},@{@"item":@"9月6日",@"count":@1},@{@"item":@"9月7日",@"count":@5}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值

    // lineChart.xScaleMarkLEN = 60; // 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
    //设置完数据等属性后绘图折线图
    [self.lineChart mapping];
    
    [self.view addSubview:self.lineChart];
}

- (IBAction)updateChart:(id)sender {
    
    [self.lineChart setXMarkTitlesAndValues:@[@{@"item":@"9月1日",@"count":@1},@{@"item":@"9月2日",@"count":@0},@{@"item":@"9月3日",@"count":@4},@{@"item":@"9月4日",@"count":@2},@{@"item":@"9月5日",@"count":@5},@{@"item":@"9月6日",@"count":@1},@{@"item":@"9月7日",@"count":@5}] titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
    
    //设置完数据等属性后绘图折线图
    [self.lineChart reloadDatas];
    
}

@end
