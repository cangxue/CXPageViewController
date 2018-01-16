//
//  CXSegmentViewController.m
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/16.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXSegmentViewController.h"
#import "CXSegmentView.h"

@interface CXSegmentViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, CXSegmentViewDelegate> {
    NSInteger _currentIndex; // 当前的索引
}

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) CXSegmentView *segmentView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CXSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = 0;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UIViewController *vc = [self.dataSource objectAtIndex:self.selectedIndex];
    
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    self.segmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.segmentView];
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self.dataSource objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == self.dataSource.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    
    index++;
    
    return [self.dataSource objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    NSInteger index = [self.dataSource indexOfObject:nextVC];
    
    _currentIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.segmentView.selectedIndex = _currentIndex;
    }
}

#pragma mark - CXSegmentViewDelegate
- (void)segmentView:(CXSegmentView *)view didSelectedIndex:(NSInteger)index {
    UIViewController *vc = [self.dataSource objectAtIndex:index];
    
    if (index > _currentIndex) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } else {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    
    _currentIndex = index;
}

#pragma mark - setter
- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}

- (CXSegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[CXSegmentView alloc] init];
        _segmentView.delegate = self;
    
        [self.view addSubview:_segmentView];
    }
    
    return _segmentView;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    self.segmentView.titles = titles;
}

- (void)setChildViewControllers:(NSArray<UIViewController *> *)childViewControllers {
    _childViewControllers = childViewControllers;
    
    [self.dataSource addObjectsFromArray:childViewControllers];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    self.segmentView.selectedIndex = selectedIndex;
    
    _currentIndex = selectedIndex;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    self.segmentView.bgColor = bgColor;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    
    self.segmentView.fontSize = fontSize;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    
    self.segmentView.normalColor = normalColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    
    self.segmentView.selectedColor = selectedColor;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    
    self.segmentView.indicatorColor = indicatorColor;
}



@end
