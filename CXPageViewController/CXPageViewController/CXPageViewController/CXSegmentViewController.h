//
//  CXSegmentViewController.h
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/16.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSegmentViewController : UIViewController

/**
 标题
 */
@property (nonatomic, strong) NSArray<NSString *> *titles;

/**
 子控制器
 */
@property (nonatomic, strong) NSArray<UIViewController *> *childViewControllers;

/**
 选中的索引
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 标题背景的颜色
 */
@property (nonatomic, strong) UIColor *bgColor;

/**
 标题未选中的颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 标题选中的颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 指示器的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 标题字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;

@end
