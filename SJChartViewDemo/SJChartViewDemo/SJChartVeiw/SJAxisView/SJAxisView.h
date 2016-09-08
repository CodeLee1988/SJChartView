//
//  SJAxisView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAxisView : UIView


@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, assign) NSInteger yMarkCount;

@property (nonatomic, assign) NSInteger xMarkCount;

/**
 *  与y轴平行的网格线的间距
 */
@property (nonatomic, assign) CGFloat spaceBetweenYGridline;

/**
 *  与y轴平行的网格线的间距
 */
@property (nonatomic, assign) CGFloat spaceBetweenXGridline;


@end
