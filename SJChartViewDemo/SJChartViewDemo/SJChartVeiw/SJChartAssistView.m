//
//  SJChartAssistView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/8.
//  Copyright © 2016年 S.J. All rights reserved.
//  

#import "SJChartAssistView.h"

@interface SJChartAssistView()
{
    UILabel *titleLab;
}

@end

@implementation SJChartAssistView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleHeight = 30.f;
        
        [self s_setupViews];
            }
    return  self;
}
- (void)s_setupViews {
 
    titleLab.backgroundColor = [UIColor yellowColor];
    [self addSubview:titleLab];
}


@end
