//
//  SJLineChart.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJLineChart.h"

#import "SJChartLineView.h"
#import "SJAxisView.h"

@interface SJLineChart()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SJAxisView *axisView;

@property (nonatomic, strong) SJChartLineView *chartLineView;

@end

@implementation SJLineChart

- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {
    _xScaleMarkLEN = xScaleMarkLEN;

}

- (void)setXMarkTitles:(NSArray *)xMarkTitles {
    _xMarkTitles = xMarkTitles;
}

- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setValueArray:(NSArray *)valueArray {
    _valueArray = valueArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 30, 320, 200)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:self.scrollView];
        
    }
    return self;
}

- (void)show {
    
    if (!self.xMarkTitles) {
        self.xMarkTitles = @[@"09-01",@"09-02",@"09-03",@"09-04",@"09-05",@"09-06",@"09-07"];
    }
    if (!self.yMarkTitles) {
        self.yMarkTitles = @[@0,@20,@40,@60,@80,@100];
    }
    
    if (!self.valueArray) {
        self.valueArray =  @[@95,@44,@70,@60,@55,@100,@50];
    }
    
 
    [self mappingAxisView];
    
    self.scrollView.contentSize = self.axisView.frame.size;
    
    [self mappingChartLineView];
    
    [self.axisView addSubview:self.chartLineView];
    [self.scrollView addSubview:self.axisView];

}

- (void)mappingChartLineView {
    
    self.chartLineView = [[SJChartLineView alloc] initWithFrame:CGRectMake(self.axisView.startPoint.x, self.axisView.startPoint.y, self.axisView.xAxis_L, self.axisView.yAxis_L)];
    
    self.chartLineView.xScaleMarkLEN = self.axisView.xScaleMarkLEN;
    self.chartLineView.valueArray = self.valueArray;
    self.chartLineView.maxValue = 100;
    [self.chartLineView mapping];
    
}

- (void)mappingAxisView {
    
    self.axisView = [[SJAxisView alloc] initWithFrame:CGRectMake(0, 30, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.axisView.xScaleMarkLEN = self.xScaleMarkLEN;
    self.axisView.xMarkTitles = self.xMarkTitles;
    self.axisView.yMarkTitles = self.yMarkTitles;
    [self.axisView mapping];
    
}

@end
