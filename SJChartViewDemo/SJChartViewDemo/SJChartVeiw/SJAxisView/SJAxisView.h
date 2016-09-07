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

@property (nonatomic, assign) NSInteger yMarkCount;

@property (nonatomic, assign) NSInteger xMarkCount;

@property (nonatomic, strong) NSArray *valueArray;

@end
