//
//  SJAxisView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJAxisView.h"

@interface SJAxisView() {
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
}



@end
@implementation SJAxisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        xAxis_L = frame.size.width;
        yAxis_L = frame.size.height;
        
        self.xMarkCount = 5;
        self.yMarkCount = 5;
        
        self.maxValue = 100;
        [self s_setupViews];
    }
    return  self;
}


- (void)s_setupViews {
    
    // y 轴
    {
        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(0, yAxis_L)];
        [yAxisPath addLineToPoint:CGPointMake(0, 0)];
        
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
        [xAxisPath moveToPoint:CGPointMake(0, yAxis_L)];
        [xAxisPath addLineToPoint:CGPointMake(xAxis_L, yAxis_L)];
        
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
        CGFloat curMark_X = perMark_W * (i + 1);

        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(curMark_X, yAxis_L)];
        [yAxisPath addLineToPoint:CGPointMake(curMark_X, 0)];
        
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
        [xAxisPath moveToPoint:CGPointMake(0, curMark_Y)];
        [xAxisPath addLineToPoint:CGPointMake(xAxis_L, curMark_Y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
    
    
    // 画折线图
    {
        self.valueArray = @[@40,@50,@70,@50,@60];
        
        pointArray = [NSMutableArray array];
    
        UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];

        for (int i = 0; i < self.valueArray.count; i ++) {
            
            CGFloat perMark_W = xAxis_L / (self.xMarkCount - 1);
            CGFloat point_X = perMark_W * i;
            
            CGFloat value = [self.valueArray[i] floatValue];
            CGFloat percent = value / self.maxValue;
            CGFloat point_Y = yAxis_L * (1 - percent);
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            
            if (i == 0) {
                 [pAxisPath moveToPoint:point];
            }
            else {
                 [pAxisPath addLineToPoint:point];
            }
        }
        
        CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
        pAxisLayer.lineWidth = 1;
        pAxisLayer.strokeColor = [UIColor greenColor].CGColor;
        pAxisLayer.fillColor = [UIColor clearColor].CGColor;
        pAxisLayer.path = pAxisPath.CGPath;
        [self.layer addSublayer:pAxisLayer];
    }
    
    // 渐变阴影
    {
        UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
        
        [gradientPath moveToPoint:CGPointMake(0, yAxis_L)];

        for (int i; i < pointArray.count; i ++) {
            [gradientPath addLineToPoint:[pointArray[i] CGPointValue]];
        }
        
        CGPoint endPoint = [[pointArray lastObject] CGPointValue];
        endPoint = CGPointMake(endPoint.x, yAxis_L);
        [gradientPath addLineToPoint:endPoint];

        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, xAxis_L, yAxis_L);
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:50/255.0 green:255/255.0 blue:50/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:225/255.0 green:255/255.0 blue:225/255.0 alpha:0.2].CGColor];
        gradientLayer.accessibilityPath = gradientPath;
        gradientLayer.locations=@[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0.0,0.0);
        gradientLayer.endPoint = CGPointMake(0.0,1);
       
        CAShapeLayer *arc = [CAShapeLayer layer];
        arc.path = gradientPath.CGPath;
        gradientLayer.mask = arc;
        
        [self.layer addSublayer:gradientLayer];
        
    }
    
}


@end
