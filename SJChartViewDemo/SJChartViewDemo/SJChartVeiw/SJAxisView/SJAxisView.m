//
//  SJAxisView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJAxisView.h"

/**
 *  Y轴刻度标签 与 Y轴 之间 空隙
 */
#define HORIZON_YMARKLAB_YAXISLINE 10.f

/**
 *  Y轴刻度标签  宽度
 */
#define YMARKLAB_WIDTH 25.f

/**
 *  Y轴刻度标签  高度
 */
#define YMARKLAB_HEIGHT 16.f
/**
 *  X轴刻度标签  宽度
 */

#define XMARKLAB_WIDTH 40.f

/**
 *  X轴刻度标签  高度
 */
#define XMARKLAB_HEIGHT 16.f


@interface SJAxisView() {
    
    /**
     *  视图的宽度
     */
    CGFloat axisViewWidth;
    /**
     *  视图的高度
     */
    CGFloat axisViewHeight;
    /**
     *  x 轴长度
     */
    CGFloat xAxis_L;
    /**
     *  y 轴长度
     */
    CGFloat yAxis_L;
    
    /**
     *  折线点集合
     */
    NSMutableArray *pointArray;
    
    CGFloat PerItemWidth;
    
    NSInteger lastSeletedIndex;
}

@end

@implementation SJAxisView


- (instancetype)initWithPerWidth:(CGFloat)perWidth perHeight:(CGFloat)perHeight yMarkCount:(NSInteger)yMarkCount xMarkCount:(NSInteger)xMarkCount maxValue:(CGFloat) maxValue{
    return nil;
}

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        
        self.spaceBetweenXGridline = 63.5;
        self.spaceBetweenYGridline = 40;
        
        self.xMarkCount = 6;
        self.yMarkCount = 10;
        
        self.maxValue = 100;
        
        axisViewWidth = self.spaceBetweenXGridline * (self.xMarkCount - 1) + HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH + XMARKLAB_WIDTH / 2.0;
       
        axisViewHeight = self.spaceBetweenYGridline * self.yMarkCount + XMARKLAB_HEIGHT + YMARKLAB_HEIGHT;
        
        xAxis_L = self.spaceBetweenXGridline * (self.xMarkCount - 1);
        
        yAxis_L = self.spaceBetweenYGridline * self.yMarkCount;
        
        self.frame  = CGRectMake(0, 0, axisViewWidth, axisViewHeight);
       
        [self s_setupViews];
    }
    return  self;
}

- (void)s_setupViews {
    
    self.backgroundColor = [UIColor yellowColor];
    
    CGFloat start_X = HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH;
    CGFloat start_Y = YMARKLAB_HEIGHT / 2.0;
    
    // y 轴上的刻度标签
    for (int i = 0; i <= self.yMarkCount; i ++) {
        
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, start_Y - YMARKLAB_HEIGHT / 2 + i * self.spaceBetweenYGridline, YMARKLAB_WIDTH, YMARKLAB_HEIGHT)];
        markLab.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.5];
        markLab.textAlignment = NSTextAlignmentRight;
        markLab.font = [UIFont systemFontOfSize:12.0];
        markLab.text = [NSString stringWithFormat:@"%.f",self.maxValue / self.yMarkCount * (self.yMarkCount - i)];
        [self addSubview:markLab];
    }
    
    
    // x 轴上的刻度标签
    for (int i = 0;i < self.xMarkCount; i ++) {
        
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(start_X - XMARKLAB_WIDTH / 2 + i * self.spaceBetweenXGridline, yAxis_L + YMARKLAB_HEIGHT, XMARKLAB_WIDTH, XMARKLAB_HEIGHT)];
        markLab.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
        markLab.textAlignment = NSTextAlignmentCenter;
        markLab.font = [UIFont systemFontOfSize:11.0];
        markLab.text = [NSString stringWithFormat:@"09-0%d",i + 1];
        [self addSubview:markLab];
    }
    
    // y 轴
    {
        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(start_X, start_Y + yAxis_L)];
        [yAxisPath addLineToPoint:CGPointMake(start_X, start_Y)];
        
        CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
        // 设置线为虚线
        [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        yAxisLayer.lineWidth = 0.5;
        yAxisLayer.strokeColor = [UIColor redColor].CGColor;
        yAxisLayer.path = yAxisPath.CGPath;
        [self.layer addSublayer:yAxisLayer];
    }
    
    // x 轴
    {
        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        [xAxisPath moveToPoint:CGPointMake(start_X, yAxis_L + start_Y)];
        [xAxisPath addLineToPoint:CGPointMake(xAxis_L + start_X, yAxis_L + start_Y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        // 设置线为虚线
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor redColor].CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
    
    
    // 与 y 轴平行的网格线
    for (int i = 0; i < self.xMarkCount - 1; i ++) {

        CGFloat perMark_W = xAxis_L / (self.xMarkCount - 1);
        PerItemWidth = perMark_W;
        CGFloat curMark_X = start_X + perMark_W * (i + 1);

        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(curMark_X, yAxis_L + start_Y)];
        [yAxisPath addLineToPoint:CGPointMake(curMark_X, start_Y)];
        
        CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
        [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]]; // 设置线为虚线
        yAxisLayer.lineWidth = 0.5;
        yAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        yAxisLayer.path = yAxisPath.CGPath;
        [self.layer addSublayer:yAxisLayer];
    }
    
    
    // 与 x 轴平行的网格线
    for (int i = 0; i < self.yMarkCount; i ++) {
        
        CGFloat perMark_W = yAxis_L / self.yMarkCount;
        CGFloat curMark_Y = perMark_W * i;
        
        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        [xAxisPath moveToPoint:CGPointMake(start_X, curMark_Y + start_Y)];
        [xAxisPath addLineToPoint:CGPointMake(start_X + xAxis_L, curMark_Y + start_Y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
}

@end
