//
//  SJChartLineView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJChartLineView.h"
#import "SJCircleView.h"

// Tag 基初值
#define BASE_TAG_COVERVIEW 100
#define BASE_TAG_CIRCLEVIEW 200
#define BASE_TAG_POPBTN 300

@interface SJChartLineView() {
   
    NSMutableArray *pointArray;
    
    CGFloat xAxis_L;
    CGFloat yAxis_L;
    
    NSInteger lastSelectedIndex;
}

@end

@implementation SJChartLineView

- (void)setMaxValue:(CGFloat)maxValue {
    
    _maxValue = maxValue;
}

- (void)setValueArray:(NSArray *)valueArray {
    _valueArray = valueArray;
}

- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {

    _xScaleMarkLEN = xScaleMarkLEN;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        lastSelectedIndex = - 1;
        pointArray = [NSMutableArray array];
        
        yAxis_L = frame.size.height;
        xAxis_L = frame.size.width;
    }
    return  self;
}

- (void)mapping {
   
    [self drawChartLine];
    [self drawGradient];
    
    [self setupCircleViews];
    [self setupCoverViews];
}

#pragma mark 画折线图
- (void)drawChartLine
    {
        UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
        
        for (int i = 0; i < self.valueArray.count; i ++) {
            
            CGFloat point_X = self.xScaleMarkLEN * i;
            
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
        pAxisLayer.strokeColor = [UIColor orangeColor].CGColor;
        pAxisLayer.fillColor = [UIColor clearColor].CGColor;
        pAxisLayer.path = pAxisPath.CGPath;
        [self.layer addSublayer:pAxisLayer];
}

#pragma mark 渐变阴影
- (void)drawGradient {
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    
    [gradientPath moveToPoint:CGPointMake(0, yAxis_L)];
    
    for (int i = 0; i < pointArray.count; i ++) {
        [gradientPath addLineToPoint:[pointArray[i] CGPointValue]];
    }
    
    CGPoint endPoint = [[pointArray lastObject] CGPointValue];
    endPoint = CGPointMake(endPoint.x, yAxis_L);
    [gradientPath addLineToPoint:endPoint];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, xAxis_L, yAxis_L);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
    gradientLayer.accessibilityPath = gradientPath;
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1);
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    gradientLayer.mask = arc;
    [self.layer addSublayer:gradientLayer];

}

#pragma mark 折线上的圆环
- (void)setupCircleViews {
    
    for (int i = 0; i < pointArray.count; i ++) {
        
        SJCircleView *circleView = [[SJCircleView alloc] initWithCenter:[pointArray[i] CGPointValue] radius:4];
        circleView.tag = i + BASE_TAG_CIRCLEVIEW;
        circleView.borderColor = [UIColor orangeColor];
        circleView.borderWidth = 1.0;
        [self addSubview:circleView];
    }
}

#pragma mark 覆盖一层点击图层
- (void)setupCoverViews {

    for (int i = 0; i < pointArray.count; i ++) {
        
        UIView *coverView = [[UIView alloc] init];
        coverView.tag = BASE_TAG_COVERVIEW + i;
        
        UITapGestureRecognizer *gesutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesutreAction:)];
        [coverView addGestureRecognizer:gesutre];
        
        if (i == 0) {
            
            coverView.frame = CGRectMake(0, 0, self.xScaleMarkLEN  / 2, yAxis_L);
            //coverView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
            [self addSubview:coverView];
        }
        else if (i == pointArray.count - 1) {
            CGPoint point = [pointArray[i] CGPointValue];
            coverView.frame = CGRectMake(point.x - self.xScaleMarkLEN / 2, 0, self.xScaleMarkLEN  / 2, yAxis_L);
            //coverView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
            [self addSubview:coverView];
        }
        else {
            CGPoint point = [pointArray[i] CGPointValue];
            coverView.frame = CGRectMake(point.x - self.xScaleMarkLEN / 2, 0, self.xScaleMarkLEN, yAxis_L);
            //coverView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
            [self addSubview:coverView];
        }
    }
}

#pragma mark- 点击层视图的点击事件
- (void)gesutreAction:(UITapGestureRecognizer *)sender {
    
    NSInteger index = sender.view.tag - BASE_TAG_COVERVIEW;
    
    if (lastSelectedIndex != -1) {
        
        SJCircleView *lastCircleView = (SJCircleView *)[self viewWithTag:lastSelectedIndex + BASE_TAG_CIRCLEVIEW];
        lastCircleView.borderWidth = 1;
        
        UIButton *lastPopBtn = (UIButton *)[self viewWithTag:lastSelectedIndex + BASE_TAG_POPBTN];
        [lastPopBtn removeFromSuperview];
    }
    
    SJCircleView *circleView = (SJCircleView *)[self viewWithTag:index + BASE_TAG_CIRCLEVIEW];
    circleView.borderWidth = 2;
    
    CGPoint point = [pointArray[index] CGPointValue];
    
    UIButton *popBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    popBtn.tag = index + BASE_TAG_POPBTN;
    popBtn.frame = CGRectMake(point.x - 10, point.y - 20, 20, 15);
    
    [popBtn setBackgroundImage:[UIImage imageNamed:@"btg_pop_bg.png"] forState:UIControlStateNormal];
    
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 3, 0, 0, 0)];
    popBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [popBtn setTitle:[NSString stringWithFormat:@"%@",self.valueArray[index]] forState:(UIControlStateNormal)];
    
    [self addSubview:popBtn];

    lastSelectedIndex = index;
}


@end
