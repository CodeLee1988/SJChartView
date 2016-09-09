//
//  SJLineChart.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJLineChart : UIView

/**
 *  X轴刻度标签的长度（单位长度）
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

/**
 *  X轴刻度标签title
 */
@property (nonatomic, strong) NSArray *xMarkTitles;
/**
 *  Y轴刻度标签title
 */
@property (nonatomic, strong) NSArray *yMarkTitles;

/**
 *  折线点的值
 */
@property (nonatomic, strong) NSArray *valueArray;

/**
 *  Y轴最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

- (void)showLineChart;

@end
