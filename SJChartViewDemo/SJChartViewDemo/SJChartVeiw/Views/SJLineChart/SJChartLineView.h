//
//  SJChartLineView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJChartLineView : UIView

@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, assign) CGFloat maxValue;

/**
 *  与x轴平行的网格线的间距
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  绘图
 */
- (void)mapping;

@end
