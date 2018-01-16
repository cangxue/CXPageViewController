//
//  CXSegmentView.h
//  CXPageViewController
//
//  Created by xiaoma on 2018/1/15.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXSegmentViewDelegate;

@interface CXSegmentView : UIView

// select delegate
@property (nonatomic, weak) id<CXSegmentViewDelegate> delegate;

// titles
@property (nonatomic, strong) NSArray<NSString *> *titles;

// selected index
@property (nonatomic, assign) NSInteger selectedIndex;

// color
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *indicatorColor;

// font size
@property (nonatomic, assign) CGFloat fontSize;

@end


@protocol CXSegmentViewDelegate <NSObject>

- (void)segmentView:(CXSegmentView *)view didSelectedIndex:(NSInteger)index;

@end

/**************************************************************/
#pragma mark CXSegmentCell
@interface CXSegmentCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, assign) CGFloat fontSize;

@end

#pragma mark CXSegmentModel
@interface CXSegmentModel : NSObject

// title
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat fontSize;


@end

