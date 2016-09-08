//
//  SJChartAssistView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/8.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJChartAssistView : UIView

/**
 *  表名
 */
@property (nonatomic, strong) NSString *title;

/**
 *  x轴刻度线
 */
@property (nonatomic, strong) NSArray *xMarkLabs;

/**
 *  y轴刻度线
 */
@property (nonatomic, strong) NSArray *yMarkLabs;

/**
 *  表的说明
 */
@property (nonatomic, strong) NSString *introduce;

@property (nonatomic, assign) CGFloat titleHeight;





@end
